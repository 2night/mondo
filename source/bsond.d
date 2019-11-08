import std.stdio;
import std.datetime;
import std.bitmanip;
import std.system;
import std.string;
import std.array;
import std.traits;
import std.conv;

import mongoc;

alias BsonLong      = long;
alias BsonInt       = int;
alias BsonString    = string;
alias BsonBool      = bool;
alias BsonFloat     = double;
alias BsonDateTime  = SysTime;
alias BsonNull      = typeof(null);

// Cut verbosiy
alias BO = BsonObject;
alias BA = BsonArray;

enum BsonExceptionCode
{
   invalidOidFormat,

   invalidKey,
   invalidValue,

   encodingError,
   decodingError,

   invalidMethod
}

class BsonException : Exception
{
   this(in string message, in BsonExceptionCode code, string file = __FILE__, size_t line = __LINE__)
   {
      super(message, file, line);
      this.code = code;
   }

   BsonExceptionCode code;
}

/// A binary data type
struct BinaryData
{
   ubyte subtype = 0;
   private ubyte[] _data;

   alias _data this;
}

/// An ObjectId type
struct ObjectId
{
   string toString() const
   {
      static immutable char[] digits = "0123456789abcdef";
      auto app = appender!string;

      foreach(b; _data)
      {
         app.put(digits[b >> 4]);
         app.put(digits[b & 0xF]);
      }

      return text("ObjectId(\"", app.data, "\")");
      //return app.data;
   }

   this(in string v) { opAssign(v); }
   this(in ubyte[] data) { opAssign(data); }


   void opAssign(in string v)
   {
      if (v.length != 24) throw new BsonException("ObjectId: length != 24", BsonExceptionCode.invalidOidFormat);

      int toUbyte(in char str)
      {
         if (str >= '0' && str <= '9') return cast(ubyte)(str) - cast(ubyte)('0');
         else if (str >= 'a' && str <= 'f') return 10 + cast(ubyte)(str) - cast(ubyte)('a');
         else if (str >= 'A' && str <= 'F') return 10 + cast(ubyte)(str) - cast(ubyte)('A');
         else throw new BsonException(text("ObjectId: invalid hex char '", str, "'"), BsonExceptionCode.invalidOidFormat);
      }

      foreach(i; 0..12)
      {
         _data[i] = cast(ubyte)((toUbyte(v[i*2]) << 4) + toUbyte(v[i*2+1]));
      }
   }

   void opAssign(in ubyte[] data)
   {
      _data = data;
   }

   ubyte[12] _data;
   alias _data this;
}

/// A regex
struct BsonRegEx
{
   this(in string regex, in string options = "") { this.regex = regex; this.options = options; }

   string regex;
   string options;
}

// Type defined by Bson Specs
enum isNativeBsonValue(T) = 
   is(Unqual!T == BsonLong) || is(Unqual!T == BsonInt) || is(Unqual!T == BsonString) || 
   is(Unqual!T == BsonBool) || is(Unqual!T == BsonFloat) || is(Unqual!T == BinaryData) || 
   is(Unqual!T == ObjectId) || is(Unqual!T == BsonDateTime) || is(Unqual!T == SysTime) || is (Unqual!T == BsonNull) ||
   is(Unqual!T == BsonObject) || is (Unqual!T == BsonArray) || is(Unqual!T == BsonRegEx);

enum isComplexBsonValue(T) = 
   is(Unqual!T == BinaryData) || is(Unqual!T==ObjectId) || is(Unqual!T == BsonObject) || 
   is (Unqual!T==BsonArray) || is(Unqual!T == BsonRegEx) || is(Unqual!T == BsonDateTime);

enum isBsonContainerClass(T) =  is(T == class) && __traits(compiles, new T(BsonObject()));
enum isBsonContainerStruct(T) = !is(T == BsonObject) && !is(T == BsonArray) && is(T == struct) && __traits(compiles, T(BsonObject()));

enum isBsonContainer(T) = isBsonContainerClass!T || isBsonContainerStruct!T;

// Type we can cast to one above
enum isExtraBsonValue(T) = is(Unqual!T == short) || is(Unqual!T == float);

// All accepted type
enum isValidBsonValue(T) = isNativeBsonValue!T || isExtraBsonValue!T || isComplexBsonValue!T;

// Check if string is number-only
@nogc pure nothrow
bool isNumericKey(in string key)
{
   foreach(const c; key) if (c < '0' || c > '9') { return false; }
   return true;
}

pure nothrow
auto parseKey(in string index)
{
   import std.typecons: tuple;

   string idx = cleanPath(index);
   size_t lastPos = 1, currPos = 1; // For key parsing

   // If we have a composed index like /your/nested/value, it search for the first chunk ("your")
   while (currPos < idx.length && idx[currPos] != '/') currPos++;

   // return tuple("your", "/nested/value")
   return tuple(idx[lastPos .. currPos], idx[currPos..$]);
}



/// A BsonField is returned by bson["fieldName"].as!T
struct BsonField(T)
{
   /// The value of BsonField
   @property   value() const    { return _value; }

   /// Just tell you whether the value exists or not.
   @property   exists()   const { return _exists; }

   /// If something goes wrong during read, this field is set to false
   @property   ok() const    { return !_error; }

   private T          _value;
   private bool      _error   = false;
   private bool      _exists  = false;

   alias value this;
}

pure nothrow
private string cleanPath(T)(in T path) if(isSomeString!T)
{
   auto idxAppender = appender!string;
   bool isSlash = false;
   foreach(c; path)
   {
      if (c == '/')
      {
         if (isSlash) continue;
         idxAppender.put(c);
      }
      else idxAppender.put(c);

      isSlash = (c == '/');
   }

   string result = idxAppender.data;
   if (result.length > 1 && result[$-1] == '/') return result[0..$-1];
   else return result;
}

/// A BsonObject. Container/map of BsonValue
struct BsonObject
{
   string              toString()                  { return exportJson(this); }

   immutable(ubyte)[]  exportData() const          { return exportRaw(this); }
   
   private void initValue() 
   { 
      if (value is null)
         value = new PreservedAA!(string, BsonValue); 
   }

   void importData(in ubyte* data)  
   { 
      initValue();
      genericParse!BsonObject(data,  this); 
   }

   void  importData(in string data)
   {
         bson_error_t error;
         bson_t *bson = bson_new_from_json(cast(ubyte*)data, (cast(ubyte[])data).length, &error);

         if (bson)
         {
            importData(bson_get_data(bson));
            bson_destroy(bson);
         }
         else throw new BsonException(error.message.to!string, BsonExceptionCode.decodingError);
   }

   BsonObject dup()   const   { return BsonObject(exportData.ptr); }
   this(in ubyte* data)    { this.importData(data); }
   this(in string data)    { this.importData(data); }
   
   bool empty() const { return value is null || value.length == 0; }

   void dump() { writeln(value); }

   // Implement "in" operator for BsonObject
   auto opBinaryRight(string op)(string key) const if (op == "in")
   {
      if (value is null)
         return null;

      return key in value;
   }

   bool opEquals(in BsonObject b) const
   {
      import std.algorithm : uniq, sort;

      if (this.value is null || b.value is null)
         return this.value == b.value;
      
      if (this.value.keys.length != b.value.keys.length) 
         return false;
      
      foreach(k; this.value.keys)
         if (!(k in b && b[k] == this[k]))
            return false;

      return true;
   }

   /// Build from a tuple
   /// -------
   /// auto bo = new BsonObject("key", "value", "another_key", 3); // Something like { "key" : "value", "another_key" : 3 }
   /// -------
   this(T...)(T vals)
   {
      if (T.length > 0)
         append(vals);
   }

   /// Append tuple to BsonObject. See ctor.
   void append(T...)(T vals)
   {
       initValue();
      // Appends nothing, recursion ends
      static if (vals.length == 0) return;

      // We're working with a tuple (key, value, key, value, ...) so args%2==0 is key and args%2==1 is value
      static if (vals.length % 2 == 0)
      {
         // Key should be a string!
         static if (!is(typeof(vals[0]) == string))
            throw new BsonException("Wrong param type. Key not valid.", BsonExceptionCode.invalidKey);

         static if (!isSomeString!(typeof(vals[1])) && !isValidBsonValue!(typeof(vals[1])) && isArray!(typeof(vals[1])))
         {
            value[vals[0]] = BsonValue(BsonArray(vals[1]));
         }
         else static if (!isValidBsonValue!(typeof(vals[1])) && !(isInstanceOf!(BsonField, typeof(vals[1])) && isValidBsonValue!(typeof(vals[1]._value))))
         {
            throw new BsonException("Wrong param type. Value not valid.", BsonExceptionCode.invalidValue);
         }
         else
         {
            value[vals[0]] = BsonValue(vals[1]);
         }

         // Recursion call
         static if (vals.length > 2)
            append(vals[2..$]);
      } else throw new BsonException("Wrong params. Should be: append(string key1, T1 val1, string key2, T2 val2, ...)", BsonExceptionCode.invalidValue);

   }

   void opIndexOpAssign(string op, K, T)(K val, T index) if (op == "~" && (isValidBsonValue!T || is(T == BsonValue)))
   {
      initValue();

      if (index.length == 0)
         throw new BsonException(text("Empty index"), BsonExceptionCode.invalidKey);

      string    key;
      string   nextKey;

      bool   isLastChunk = true;

      if (index[0] == '/')
      {
         auto parseResult = parseKey(index);
         key = parseResult[0];
         nextKey = parseResult[1];
         isLastChunk = parseResult[1].empty;
      }
      else key = index;

      // If chunk is empty, throw an exception
      if (key.empty)
         throw new BsonException(text("Empty index"), BsonExceptionCode.invalidKey);

      bool isNumericKey = true;
      foreach(c; key) if (c < '0' || c > '9') { isNumericKey = false; break; }

      // It shouldn't happen. We are inside a BsonObject, so we expect a string index
      if (isNumericKey)
         throw new BsonException(text("Can't use index '", key, "': expected string"), BsonExceptionCode.invalidKey);

      if (!isLastChunk)
      {
         // We still don't finish key parsing. We have to read next part of key. Recursion happens.

         // If key doesn't exist we create it.
         if (key !in value)
         {
            BsonObject o;
            o.opIndexOpAssign!op(val, nextKey);
            value[key] = o;
         }
         else value[key].opIndexOpAssign!op(val, nextKey);
      }
      else
      {
         // It's the last chunk of key. If key doesn't exists we create a new array
         // for example  obj["newkey"] ~= 10  create a key {"newkey" : [10]}
         if (key !in value) value[key] = BsonArray(val);

         // If we have obj["key"] = "hello" obj["key"] ~= 10 will create a new array {"key" : ["hello", 10]}
         else if(value[key].type != typeid(BsonArray)) value[key] = BsonArray(value[key], val);

         // Simple case, just append a new value to bson array
         else value[key] = value[key].get!BsonArray ~ val;
      }

   }


   inout(BsonValue) opIndex(T)(T idx) inout
   if (isSomeString!T)
   {
      if (value !is null)
      {
         if(idx[0] == '/')
         {
            // Parse composed key
            auto parseResult = parseKey(idx);
            string key = parseResult[0];
            string nextKey = parseResult[1];
            bool isLastChunk = parseResult[1].empty;

            if (key.empty)
               throw new BsonException(text("Empty index"), BsonExceptionCode.invalidKey);

            if (!isNumericKey(key) && key in value)
            {
               if (isLastChunk) return value[key];
               else return value[key].opIndex(nextKey);
            }
         }
         else if (idx in value) return value[idx];
      }

      return inout(BsonValue)();
   }


   void opIndexAssign(K,T)(K val, T index) if (isSomeString!T)
   {
      initValue();

      static if (isArray!K && !isSomeString!K)
      {
         opIndexAssign(BsonArray(val), index);
         return;
      }
      else
      {
         if (index.empty)
            throw new BsonException(text("Empty index"), BsonExceptionCode.invalidKey);

         if (index[0] == '/')
         {
            // Parse composed key
            auto parseResult = parseKey(index);
            string key = parseResult[0];
            string nextKey = parseResult[1];
            bool isLastChunk = parseResult[1].empty;

            if (key.empty)
               throw new BsonException(text("Empty index"), BsonExceptionCode.invalidKey);

            if (isNumericKey(key))
               throw new BsonException(text("Can't use index '", key, "': expected string"), BsonExceptionCode.invalidKey);

            if (!isLastChunk)
            {
               if (key !in value)
               {
                  BsonObject o;
                  o.opIndexAssign(val, nextKey);
                  value[key] = o;
               }
               else value[key].opIndexAssign(val, nextKey);
            }
            else value[key] = val;
         }
         else
         {
            
            static if (isInstanceOf!(BsonField, K)) value[index] = val.value;
            else value[index] = val;
         }
      }
   }

   int opApply(int delegate(in BsonValue) dg) const
   {
      int result = 0;

      if (value !is null)
         foreach(e; value)
         {
            result = dg(e);
            if (result)
               break;
         }

      return result;
   }

   int opApply(int delegate(const ref string, in BsonValue) dg) const
   {
      int result = 0;

      if (value !is null)
         foreach(key, e; value)
         {
            result = dg(key, e);
            if (result)
               break;
         }

      return result;
   }

   bool remove(in string idx) 
   {
      initValue();
      return value.remove(idx); 
   }

   private PreservedAA!(string, BsonValue) value;
   //private BsonValue[string] value;
   //alias value this;
}

/// A BsonArray. Container/array of BsonValue
struct BsonArray
{
   immutable(ubyte)[]  exportData()   const        { return exportRaw(this); }
   void                importData(in ubyte* data)  { genericParse!BsonArray(data,  this); }

   string              toString()                      { return exportJson(this); }

   public BsonArray dup()  const    { return BsonArray(exportData); }
   private this(in ubyte* data)    { this.importData(data); }
   private this(BsonValue[] a)      { value = a.dup; }
   private this(typeof(null))      { append(null); }

   bool opEquals(in BsonArray b)  const
   {
      if (b.value.length != this.value.length) return false;

      foreach(i, k; this.value)
         if (!(this.value[i] == b.value[i]))
            return false;

      return true;
   }


   /// Build from a tuple
   /// -------
   /// auto bo = new BsonObject("key", 1, 3.4); // Something like ["key", 1, 3.4]
   /// -------
   this(T...)(T vals)  { append(vals); }

   this(T)(T[] vals)  { append(vals); }


   void append(T)(T[] vals) if (!isSomeString!(T[]))
   {
      foreach(v; vals)
      {
         static if (is(typeof(v) == BsonValue)) value ~= v;
         else static if (isValidBsonValue!(typeof(v))) value ~= BsonValue(v);
         else throw new BsonException(text("Can't append ", (typeof(v)).stringof, " to BsonArray"), BsonExceptionCode.invalidValue);
      }
   }

   void append(T...)(T vals)
   {
      foreach(v; vals)
      {
         static if (is(typeof(v) == BsonValue)) value ~= v;
         else static if (isValidBsonValue!(typeof(v))) value ~= BsonValue(v);
         else throw new BsonException(text("Can't append ", (typeof(v)).stringof, " to BsonArray"), BsonExceptionCode.invalidValue);
      }
   }

   void append(T)(T v) if (isValidBsonValue!T || is(typeof(v) == BsonValue))
   {
      static if (is(typeof(v) == BsonValue)) value ~= v;
      else static if (isValidBsonValue!(typeof(v))) value ~= BsonValue(v);
      else throw new BsonException(text("Can't append ", (typeof(v)).stringof, " to BsonArray"), BsonExceptionCode.invalidValue);

   }

   void opOpAssign(string op, T)(T val) if (op == "~") { append(val); }

   BsonArray opBinary(string op, T)(T val) if (op == "~" && isValidBsonValue!T)
   {
      BsonArray b = value.dup;
      b ~= val;
      return b;
   }

   int opApply(int delegate(in BsonValue) dg) const
   {
      int result = 0;

      foreach(e; value)
      {
         result = dg(e);
         if (result)
            break;
      }

      return result;
   }


   int opApply(int delegate(const ref size_t, in BsonValue) dg) const
   {
      int result = 0;

      foreach(key, e; value)
      {
         result = dg(key, e);
         if (result)
            break;
      }

      return result;
   }


   void remove(in size_t idx)
   {
      if (idx == value.length-1) value.length = value.length-1;
      else remove(idx,idx);
   }

   void remove(in size_t from, in size_t to)
   in { assert(from<=to); }
   body
   {
      import std.algorithm;
      copy(value[to+1..$], value[from..from + $-(to+1)]);
      value.length -= to-from+1;
   }

   inout(BsonValue) opIndex(T)(T idx) inout if (isIntegral!T) { return value[idx]; }

   inout(BsonValue) opIndex(T)(T idx) inout if (isSomeString!T)
   {
      if (idx[0] == '/')
      {
         // Parse composed key
         auto parseResult = parseKey(idx);
         string key = parseResult[0];
         string nextKey = parseResult[1];
         bool isLastChunk = parseResult[1].empty;

         if (key.empty)
            throw new BsonException(text("Empty index"), BsonExceptionCode.invalidKey);

         if (isNumericKey(key) && std.conv.to!size_t(key) < value.length)
         {
            if (isLastChunk) return value[std.conv.to!size_t(key)];
            else return value[std.conv.to!size_t(key)].opIndex(nextKey);
         }
      }
      else
      {
         if (isNumericKey(idx) && std.conv.to!size_t(idx) < value.length)
            return value[std.conv.to!size_t(idx)];
      }

      return inout(BsonValue)();
   }

   void opIndexOpAssign(string op, K, T)(K val, T index) if (op == "~" && (isValidBsonValue!T || is(T == BsonValue)))
   {
      if (index.length == 0)
         throw new BsonException(text("Empty index"), BsonExceptionCode.invalidKey);

      if (index[0] == '/')
      {
         // Parse composed key
         auto parseResult = parseKey(index);
         string key = parseResult[0];
         string nextKey = parseResult[1];
         bool isLastChunk = parseResult[1].empty;

         if (key.empty)
            throw new BsonException(text("Empty index"), BsonExceptionCode.invalidKey);

         if (!isNumericKey(key))
            throw new BsonException(text("Can't use index '", key, "': expected numeric"), BsonExceptionCode.invalidKey);

         if (std.conv.to!size_t(key) >= value.length)
            throw new BsonException(text("Bad index '", key, "': out of bounds"), BsonExceptionCode.invalidKey);

         if (!isLastChunk) value[std.conv.to!size_t(key)].opIndexOpAssign!op(val, nextKey);
         else
         {
            size_t szKey = std.conv.to!size_t(key);
            if (szKey >= value.length) value[szKey] = BsonArray(val);
            else if(value[szKey].type != typeid(BsonArray)) value[szKey] = BsonArray(value[szKey], val);
            else value[szKey] = value[szKey].get!BsonArray ~ val;
         }
      }
      else throw new BsonException(text("Can't use index '", index, "': expected numeric"), BsonExceptionCode.invalidKey);

   }


   void opIndexAssign(K,T)(K val, T index) if (isIntegral!(Unqual!T))
   {
      if (index >= value.length)
      {
         size_t oldLen = value.length;
         value.length = index+1;
         value[oldLen .. $-1] = BsonValue(null);
      }  
      value[index] = val;
   }

   void opIndexAssign(K,T)(K val, T index) if (isSomeString!T)
   {
      if (index.length == 0)
         throw new BsonException(text("Empty index"), BsonExceptionCode.invalidKey);

      if (index[0] == '/')
      {
         // Parse composed key
         auto parseResult = parseKey(idx);
         string key = parseResult[0];
         string nextKey = parseResult[1];
         bool isLastChunk = parseResult[1].empty;

         if (key.empty)
         throw new BsonException(text("Empty index"), BsonExceptionCode.invalidKey);

         if (!isNumericKey(key))
            throw new BsonException(text("Can't use index '", idx[0], "': expected numeric"), BsonExceptionCode.invalidKey);

         if (std.conv.to!size_t(key) >= value.length)
         throw new BsonException(text("Bad index '", key, "': out of bounds"), BsonExceptionCode.invalidKey);

         if (!isLastChunk) value[std.conv.to!size_t(key)].opIndexAssign(val, nextKey);
         else value[std.conv.to!size_t(key)] = val;
      }
      else throw new BsonException(text("Can't use index '", index, "': expected numeric"), BsonExceptionCode.invalidKey);
   }

   import std.typecons;

   mixin Proxy!value;
   private BsonValue[] value;

   @property ref array() const { return value; }

   size_t currentIdx = 0;
}

// Convert type T (eg: BsonValue[]) to a valid identifier (eg: BsonValue__)
private string UnionMangle(T)()
{
   import std.ascii;

   char[] mangled = ("as" ~ (Unqual!T).stringof).dup;
   foreach(ref c; mangled) if (!isAlphaNum(c)) c = '_';

   return mangled;
}

// Support functions for union management
private string UnionDeclaration(T)()   { return T.stringof ~ " " ~ UnionMangle!T ~ ";"; }
private string UnionGetter(T)()         { return "value." ~ UnionMangle!T(); }

private template UnionSetter(OBJ, TYPE, SUBTYPE = TYPE)
{
   enum UnionSetter = "static if (is(" ~ Unqual!OBJ.stringof ~ " == " ~  Unqual!SUBTYPE.stringof ~ ")) { type = typeid(" ~  Unqual!TYPE.stringof ~ "); " ~ UnionGetter!TYPE ~ " = val; return; }";
}

private enum UnionConversion(TO, TYPE) = "if (type == typeid(" ~ TYPE.stringof ~ ")) return std.conv.to!" ~ TO.stringof ~ "(cast(Unqual! " ~ TYPE.stringof ~ ")" ~ UnionGetter!TYPE ~ ");";

private immutable(ubyte)[] exportRaw(T)(T obj) if (is(Unqual!T == BsonObject) || is(Unqual!T == BsonArray))
{
   import std.conv;

   auto buffer = appender!(immutable(ubyte)[])();
   auto subbuffer = appender!(immutable(ubyte)[])();

   static if(is(Unqual!T == BsonObject))
   {
      if (obj["_id"].exists) subbuffer.put(obj["_id"].exportRaw("_id"));
   }

   foreach(i, v; obj)
   {
      static if(is(Unqual!T == BsonObject))
      {
         if (i == "_id") continue;
      }
      subbuffer.put(v.exportRaw(to!string(i)));
   }
   
   auto subdata = subbuffer.data;
   buffer.append!(int, Endian.littleEndian)(cast(int)subdata.length + 5);
   buffer.put(subdata);
   buffer.append!ubyte(0);

   return buffer.data;
}

private string encodeJsonString(in string str)
{
   auto buffer = appender!string();

   buffer.put(`"`);
   foreach(c; str)
   {
      switch(c)
      {
         case '"' : buffer.put(`\"`); break;
         case '\\' : buffer.put(`\\`); break;
         case '/' : buffer.put(`\/`); break;
         case '\b' : buffer.put(`\b`); break;
         case '\f' : buffer.put(`\f`); break;
         case '\r' : buffer.put(`\r`); break;
         case '\n' : buffer.put(`\n`); break;
         case '\t' : buffer.put(`\t`); break;
         default: buffer.put(c); break;
      }
   }
   buffer.put(`"`);

   return buffer.data;
}

private string exportJson(T)(T obj) if (is(Unqual!T == BsonObject) || is(Unqual!T == BsonArray))
{
   import std.conv;

   auto buffer = appender!(string)();
   bool isFirst = true;

   static if (is(Unqual!T == BsonObject))
   {
      buffer.put("{");

      if (obj["_id"].exists)
      {
         buffer.put(`"_id":`);
         buffer.put(obj["_id"].toString());
         isFirst = false;
      }
   }
   else buffer.put("[");

   foreach(i, v; obj)
   {
      static if(is(Unqual!T == BsonObject))
         if (i == "_id") continue;

      if (!isFirst) buffer.put(",");

      static if(is(Unqual!T == BsonObject))
      {
         buffer.put(encodeJsonString(to!string(i)));
         buffer.put(":");
      }

      buffer.put(v.toString());
      isFirst = false;
   }

   static if (is(Unqual!T == BsonObject)) buffer.put("}");
   else buffer.put("]");

   return buffer.data;
}


/// A value inside Bson
struct BsonValue
{

   // Union with all natives data types supported by BsonValue
   private union BsonType
   {
      mixin(UnionDeclaration!BsonLong);
      mixin(UnionDeclaration!BsonInt);
      mixin(UnionDeclaration!BsonString);
      mixin(UnionDeclaration!BsonBool);
      mixin(UnionDeclaration!BsonFloat);
      mixin(UnionDeclaration!BinaryData);
      mixin(UnionDeclaration!ObjectId);
      mixin(UnionDeclaration!BsonDateTime);
      mixin(UnionDeclaration!BsonNull);

      mixin(UnionDeclaration!BsonArray);
      mixin(UnionDeclaration!BsonObject);
      mixin(UnionDeclaration!BsonRegEx);
   }


   immutable(ubyte)[] exportRaw(in string key) const
   {

      void appendHeader(Appender!(immutable(ubyte)[]) appender, in ubyte type, in string key)
      {
         appender.append!ubyte(type);
         appender.put(key.representation);
         appender.append!ubyte(0);
      }

      auto buffer = appender!(immutable(ubyte)[])();

      if (type == typeid(BsonFloat))
      {
         appendHeader(buffer, 1, key);
         buffer.append!(double, Endian.littleEndian)(get!double);
      }
      else if (type == typeid(BsonString))
      {
         immutable string val = get!string;
         appendHeader(buffer, 2, key);
         buffer.append!(int, Endian.littleEndian)(cast(int)val.representation.length+1);
         buffer.put(val.representation);
         buffer.append!ubyte(0);
      }
      else if (type == typeid(BsonObject))
      {
         appendHeader(buffer, 3, key);
         buffer.put(get!BsonObject.exportRaw);
      }
      else if (type == typeid(BsonArray))
      {
         appendHeader(buffer, 4, key);
         buffer.put(get!BsonArray.exportRaw);
      }
      else if (type == typeid(BinaryData))
      {
         auto bo = get!BinaryData;
         appendHeader(buffer, 5, key);
         buffer.append!(int, Endian.littleEndian)(cast(int)(bo._data.length));
         buffer.append!(ubyte)(bo.subtype);
         buffer.put(bo._data);
      }
      else if (type == typeid(ObjectId))
      {
         appendHeader(buffer, 7, key);
         buffer.put((get!ObjectId)._data[]);
      }
      else if (type == typeid(BsonBool))
      {
         appendHeader(buffer,8, key);
         buffer.append!ubyte(get!BsonBool == true?1:0);
      }
      else if (type == typeid(BsonDateTime))
      {
         appendHeader(buffer, 9, key);
	 SysTime tm = get!SysTime;
         buffer.append!(long, Endian.littleEndian)(tm.toUnixTime!long*1000+tm.fracSecs.total!"msecs");
      }
      else if (type == typeid(BsonNull))
      {
         appendHeader(buffer, 0xa, key);
      }
      else if (type == typeid(BsonRegEx))
      {
         appendHeader(buffer, 0xb, key);
         BsonRegEx re = get!BsonRegEx;
         buffer.put(re.regex.representation);
         buffer.append!ubyte(0);
         buffer.put(re.options.representation);
         buffer.append!ubyte(0);
      }
      else if (type == typeid(BsonInt))
      {
         appendHeader(buffer, 0x10, key);
         buffer.append!(int, Endian.littleEndian)(get!BsonInt);
      }
      else if (type == typeid(BsonLong))
      {
         appendHeader(buffer, 0x12, key);
         buffer.append!(long, Endian.littleEndian)(get!BsonLong);
      }
      else throw new BsonException(text("Can't encode type ", type, " as BsonValue"), BsonExceptionCode.encodingError);


      return buffer.data;
   }

   string toString() const
   {

      auto buffer = appender!string();

      if (type == typeid(BsonFloat))          buffer.put(std.conv.to!string(get!double));
      else if (type == typeid(BsonString))    buffer.put(std.conv.to!string(encodeJsonString(get!string)));
      else if (type == typeid(BsonObject))    buffer.put(get!BsonObject.exportJson);
      else if (type == typeid(BsonArray))     buffer.put(get!BsonArray.exportJson);
      else if (type == typeid(ObjectId))      buffer.put(std.conv.to!string(get!ObjectId));
      else if (type == typeid(BsonBool))      buffer.put(get!BsonBool == true?"true":"false");
      else if (type == typeid(BsonDateTime))  
      {
         SysTime tm = get!SysTime;
         buffer.put(std.conv.to!string(tm.toUnixTime!long*1000 + tm.fracSecs.total!"msecs"));
      }
      else if (type == typeid(BsonNull))      buffer.put("null");
      else if (type == typeid(BsonInt))       buffer.put(std.conv.to!string(get!BsonInt));
      else if (type == typeid(BsonLong))      buffer.put(std.conv.to!string(get!BsonLong));
      else throw new BsonException(text("Can't encode type ", type, " as BsonValue"), BsonExceptionCode.encodingError);

      return buffer.data;
   }

   private bool      _exists = false;

   // Current value hold inside BsonValue
   private BsonType    value;

   // Current type
   private TypeInfo   type = typeid(null);

   @property bool isType(T)() const   { return _exists && (typeid(T) == type); }
   @property bool isType(typeof(null) T)() const {  return _exists && type == typeid(null); }

   @property bool exists() const { return _exists; }

   /// Build a BsonValue
   this(T)(T val) { assign(val); }


   private void assign(T)(T val)
   {
      _exists = true;

      static if (isInstanceOf!(BsonField, T)) { alias OriginalType = Unqual!(typeof(val._value)); }
      else { alias OriginalType = Unqual!T; }

      static if (isNativeBsonValue!OriginalType) mixin(UnionSetter!(OriginalType,OriginalType));
      else static if (isExtraBsonValue!OriginalType)
      {
         mixin(UnionSetter!(OriginalType, BsonInt, short));
         mixin(UnionSetter!(OriginalType, BsonFloat, float));
      }

   }

   // Implement "in" operator for BsonObject
   BsonValue* opBinaryRight(string op)(string key) if (op == "in")
   {
      if (type != typeid(BsonObject)) return null;
      else return key in get!BsonObject;
   }

   /// Return data only if match T type.
   auto get(T)() inout
      if (isNativeBsonValue!T)
   {
      if (!_exists)
         throw new BsonException(text("Can't get ", T.stringof, ": BsonValue doesn't exists"), BsonExceptionCode.invalidValue);

      if (typeid(T) == type)
      {
         static if (is(T == typeof(null))) return null;
         else return mixin(UnionGetter!T);
      }

      throw new BsonException(text("Can't get ", T.stringof, ": type mismatch"), BsonExceptionCode.invalidValue);
   }

   /// Return data only if I can convert to T
   auto to(T)() inout
   {
      import std.conv;

      if (!_exists)
         throw new BsonException(text("Can't get ", T.stringof, ": BsonValue doesn't exists"), BsonExceptionCode.invalidValue);

      // if T is a native value, no conversion needed
      static if (isNativeBsonValue!T)
         if (typeid(T) == type)
         {
            static if (is(T == typeof(null))) return null;
            else return get!T;
         }

      static if (isValidBsonValue!T && !isComplexBsonValue!T)
      {

         // Try using std.conv.to if one of this time
         mixin(UnionConversion!(T, BsonInt));
         mixin(UnionConversion!(T, BsonLong));
         mixin(UnionConversion!(T, BsonString));
         mixin(UnionConversion!(T, BsonBool));
         mixin(UnionConversion!(T, BsonFloat));

      }

      static if (is (T == BsonString))
      {
         // TODO: Add other non-common-weird types here
         if (type == typeid(ObjectId)) return get!ObjectId.toString;

         mixin(UnionConversion!(T, BsonDateTime));
      }

      static if(is (Unqual!T == class))
      {
         static if(isBsonContainerClass!T)
         {
            if (type == typeid(BsonObject)) return new T(mixin(UnionGetter!BsonObject));
         }
         else throw new BsonException(text("Can't convert ", type, " to ", T.stringof, ". You should implement this(BsonValue obj) for " ~ T.stringof), BsonExceptionCode.invalidValue);
      }

      if (isBsonContainerStruct!(Unqual!T))
      {
         static if(isBsonContainerStruct!(Unqual!T))
         {
            if (type == typeid(BsonObject)) return Unqual!T(mixin(UnionGetter!BsonObject));
         }
         else throw new BsonException(text("Can't convert ", type.toString, " to ", T.stringof, ". You should implement this(BsonValue obj) for " ~ T.stringof), BsonExceptionCode.invalidValue);
      }

      throw new BsonException(text("Can't convert ", type.toString, " to ", T.stringof), BsonExceptionCode.invalidValue);
   }

   /// Return always something. See BsonField(T)
   auto as(T)(inout lazy T fallback = T.init) inout
   {
      bool exists = this.exists;

      try
      {
         if (!exists) return inout(BsonField!T)(fallback, true, exists);
         else return inout(BsonField!T)(this.to!T, false, exists);
      }
      catch (Exception e)
      {
         return inout(BsonField!T)(fallback, true, exists);
      }

   }


   void opAssign(BsonValue val)
   {
      this.value  = val.value;
      this.type   = val.type;
      this._exists = val._exists;
   }

   void opAssign(T)(BsonField!T val)
   {
      opAssign(val.value);
   }

   void opAssign(T)(T val) if (isValidBsonValue!T && !is(T == BsonValue))
   {
      assign(val);
   }


   int opApply(int delegate(in BsonValue) const dg) const
   {

      if (type == typeid(BsonArray)) return get!BsonArray.opApply(dg);
      else if (type == typeid(BsonObject)) return get!BsonObject.opApply(dg);
      else throw new BsonException("forEach(k; object) works only with BsonObject & BsonArray", BsonExceptionCode.invalidMethod);
   }

   int opApply(int delegate(const ref string, in BsonValue) const dg) const
   {
      if (type == typeid(BsonObject)) return get!BsonObject.opApply(dg);
      else throw new BsonException("forEach(string k, v; object) works only with BsonObject", BsonExceptionCode.invalidMethod);
   }


   int opApply(int delegate(const ref size_t, in BsonValue) const dg) const
   {
      if (type == typeid(BsonArray)) return (get!BsonArray).opApply(dg);
      else throw new BsonException("forEach(size_t k, v; object) works only with BsonArray", BsonExceptionCode.invalidMethod);
   }


   bool remove(in string key)
   {
      if (type == typeid(BsonObject)) return mixin(UnionGetter!BsonObject).remove(key);
      else throw new BsonException(text("remove(\"", key, "\") works only with BsonObject"), BsonExceptionCode.invalidKey);

   }

   void remove(in size_t idx)
   {
      if (type == typeid(BsonArray)) return mixin(UnionGetter!BsonArray).remove(idx);
      else throw new BsonException(text("remove(", idx ,") works only with BsonArray"), BsonExceptionCode.invalidKey);
   }

   void remove(in size_t from, in size_t to)
   {
      if (type == typeid(BsonArray)) return mixin(UnionGetter!BsonArray).remove(from, to);
      else throw new BsonException(text("remove(", from, ",", to, ") works only with BsonArray"), BsonExceptionCode.invalidKey);
   }


   // Operator [ ]

   inout(BsonValue) opIndex(T)(T idx) inout if (isSomeString!T)
   {
      bool isBsonObject = type == typeid(BsonObject);
      bool isBsonArray = type == typeid(BsonArray);

      if (!exists)
         return inout(BsonValue)();

      if (!isBsonObject && !isBsonArray)
         return inout(BsonValue)();
         //throw new BsonException(text("Index '", idx, "' works only with BsonObject and BsonArray"), BsonExceptionCode.invalidKey);

      if (idx.empty) return inout(BsonValue)();

      if (isBsonObject) return get!BsonObject.opIndex(idx);
      else return get!BsonArray.opIndex(idx);

   }

   auto opIndex(T)(T idx) inout if (isIntegral!T)
   {
      if (type != typeid(BsonArray))
         return BsonValue();
         //throw new BsonException(text("Index '", idx, "' works only with BsonArray"), BsonExceptionCode.invalidKey);

      else return get!BsonArray[idx];
   }

   void opIndexOpAssign(string op, T)(T val, string idx) if (op == "~" && isValidBsonValue!T && !is(T == BsonValue))
   {
      bool isBsonObject = type == typeid(BsonObject);
      bool isBsonArray = type == typeid(BsonArray);

      if (!isBsonObject && !isBsonArray)
      {
         BsonArray o;
         o ~= val;
         assign(o);
         return;
      }

      if (idx.empty)
         throw new BsonException(text("Invalid index"), BsonExceptionCode.invalidKey);


      if (isBsonObject) get!BsonObject.opIndexOpAssign!"~"(val, idx);
      else get!BsonArray.opIndexOpAssign!"~"(val, idx);
   }

   void opIndexAssign(T, K)(BsonField!T val, K idx) if (isValidBsonValue!T && !is(T == BsonValue))
   {
      opIndexAssign(val.value, idx);
   }

   void opIndexAssign(T,K)(T val, K idx) if (isValidBsonValue!(Unqual!T) && !is(Unqual!T == BsonValue) && isSomeString!K)
   {
      bool isBsonObject = type == typeid(BsonObject);
      bool isBsonArray = type == typeid(BsonArray);

      try
      {
         if (!idx.empty)
         {
            if (idx[0] == '/') opIndexAssign(val, idx[1..$].to!size_t);
            else opIndexAssign(val, idx[0..$].to!size_t);

            return;
         }
      }
      catch (Throwable t) { /* Conversion fails, we use it as string key */ }

      if (!isBsonObject)
      {
         BsonObject o;
         o.opIndexAssign(val, idx);
         assign(o);
         return;
      }

      if (idx.empty)
         throw new BsonException(text("Invalid index"), BsonExceptionCode.invalidKey);

      (mixin(UnionGetter!BsonObject)).opIndexAssign(val, idx);
   }

   void opIndexAssign(T,K)(T val, K idx) if (isValidBsonValue!(Unqual!T) && !is(Unqual!T == BsonValue) && isIntegral!(Unqual!K))
   {
      bool isBsonObject = type == typeid(BsonObject);
      bool isBsonArray = type == typeid(BsonArray);

      if (!isBsonArray)
         throw new BsonException(text("Invalid index ", typeid(K)), BsonExceptionCode.invalidKey);

      if (idx<0)
         throw new BsonException(text("Invalid index"), BsonExceptionCode.invalidKey);

      (mixin(UnionGetter!BsonArray)).opIndexAssign(val, idx);
   }

   bool opEquals(const BsonValue obj) const
   {
      if (obj.type != this.type) return false;

      if (type == typeid(BsonFloat))          return get!double == obj.get!double;
      else if (type == typeid(BsonString))    return get!string == obj.get!string;
      else if (type == typeid(BsonObject))    return get!BsonObject == obj.get!BsonObject;
      else if (type == typeid(BsonArray))     return get!BsonArray == obj.get!BsonArray;
      else if (type == typeid(ObjectId))      return get!ObjectId == obj.get!ObjectId;
      else if (type == typeid(BsonBool))      return get!BsonBool == obj.get!BsonBool;
      else if (type == typeid(BsonDateTime))  return get!BsonDateTime == obj.get!BsonDateTime;
      else if (type == typeid(BsonNull))      return isType!null && obj.isType!null;
      else if (type == typeid(BsonInt))       return get!BsonInt == obj.get!BsonInt;
      else if (type == typeid(BsonLong))      return get!BsonLong == obj.get!BsonLong;
      else throw new BsonException(text("Can't encode type ", type, " as BsonValue"), BsonExceptionCode.encodingError);
   }



   bool opEquals(T)(const T obj) const
   {
      // Works if BsonValue contains exactly a value of that type
      try { return get!T == obj; }
      catch (BsonException) { return false; }
   }

}

//~this(){ }


private T genericParse(T)(in ubyte* data, ref T result)  if (is(T == BsonObject) || is(T == BsonArray))
{
   import core.stdc.string;

   size_t index = 0;

   ubyte[] sized_data;
   sized_data.length = *(cast(int*)data);
   memcpy(sized_data.ptr, data, sized_data.length);

   genericParseRecurse!T(sized_data, index, result);
   return result;
}

private void genericParseRecurse(T)(in ubyte[] data, ref size_t cursor, ref T result) if ((is(T == BsonObject) || is(T == BsonArray)))
{
   import std.bitmanip;
   import std.array;
   import std.conv;
   import std.system;

   // Support function to read a C-String
   // zero-terminated
   string readCString(in ubyte[] data, ref size_t cursor)
   {
      auto builder = appender!(ubyte[])();
      while(true)
      {
         ubyte u = data.peek!ubyte(&cursor);
         if (u == 0) break;
         builder.put(u);
      }

      return to!string(cast(char[])builder.data);
   }

   // Support function to read a non zero-terminated string
   string readString(in ubyte[] data, ref size_t cursor)
   {
      auto builder = appender!(ubyte[])();
      int size = data.peek!(int, Endian.littleEndian)(&cursor);
      
      foreach(_; 0..size-1) builder.put(data.peek!ubyte(&cursor));

      if (data.peek!ubyte(&cursor) != 0) throw new BsonException("String malformed", BsonExceptionCode.decodingError);
      return to!string(cast(char[])builder.data);
   }

   // Start parsing
   enum isObject = is(Unqual!T == BsonObject);

   // Just a workaround for a bug on LDC 1.0alpha
   immutable size_t cursor_backup = cursor;
   immutable size_t cursor_limit = cursor_backup + data.peek!(int, Endian.littleEndian)(&cursor);
   
   // There's always a byte at end. It should be == 0
   while(cursor < cursor_limit - 1)
   {
      ubyte   type    = data.peek!ubyte(&cursor);

      static if (isObject) string key = readCString(data, cursor);
      else
      {
         size_t key = to!size_t(readCString(data, cursor));
         if (result.value.length == key) result.value.length = key+1;
         else throw new BsonException(text("BsonArray malformed. Length:", result.value.length, " Expected: ", key), BsonExceptionCode.decodingError);
      }

      switch(type)
      {
         case 1: result[key] = data.peek!(double, Endian.littleEndian)(&cursor); break;
         case 2: result[key] = readString(data, cursor); break;

         case 3:
            BsonObject newObj;
            genericParseRecurse!BsonObject(data, cursor, newObj);
            result[key] = newObj;
            break;

         case 4:
            BsonArray newObj;
            genericParseRecurse!BsonArray(data, cursor, newObj);
            result[key] = newObj;
            break;

         case 5:
            BinaryData bd;

            int datasize = data.peek!(int, Endian.littleEndian)(&cursor);
            bd.subtype  = data.peek!ubyte(&cursor);

            auto builder = appender!(ubyte[])();
            while(datasize--) builder.put(data.peek!ubyte(&cursor));

            bd._data = builder.data;
            result[key] = bd;
            break;

         case 7:
            ObjectId oid;
            auto builder = appender!(ubyte[])();

            foreach(_; 0..12) builder.put(data.peek!ubyte(&cursor));

            oid = builder.data;
            result[key] = oid;
            break;

         case 8:     result[key] = (data.peek!ubyte(&cursor) != 0);   break;
         case 9:     long l = data.peek!(long, Endian.littleEndian)(&cursor); result[key] = SysTime.fromUnixTime(l/1000, PosixTimeZone.getTimeZone("UTC"))+dur!"msecs"(l%1000); break;

         case 0xa:   result[key] = null; break;

         case 0xb:
            BsonRegEx reg;
            reg.regex    = readCString(data, cursor);
            reg.options  = readCString(data, cursor);
            result[key] = reg;
            break;

         case 0x10: result[key] = data.peek!(int, Endian.littleEndian)(&cursor);     break;
         case 0x12:  result[key] = data.peek!(long, Endian.littleEndian)(&cursor);    break;

         default: throw new BsonException(text("Can't decode type ", type), BsonExceptionCode.decodingError);
      }
      
   }

   ubyte eod = data.peek!ubyte(&cursor);

   if (eod != 0)
      throw new BsonException(text("BsonObject malformed. Expected EOD found: ", eod), BsonExceptionCode.decodingError);
}


// Just a wrapper over AA to force preservation of keys order
class PreservedAA(K,V)
{
   inout @property keys() const { return _keys; }

   int opApply(int delegate(in V) dg ) const
   {
      int result = 0;

      foreach(k; keys)
      {
         result = dg(_aa[k]);
         if (result)
            break;
      }

      return result;
   }

   int opApply(int delegate(const ref K, in V) dg) const 
   {
      int result = 0;

      foreach(k; keys)
      {
         result = dg(k, _aa[k]);
         if (result)
            break;
      }

      return result;
   }
   

   void opIndexAssign(KK, VV)(VV val, KK idx)
   {
      import std.conv:to;

      if (idx !in _aa)
         _keys ~= idx;

      _aa[idx] = val;
   }

   auto ref opIndex(T)(T idx) inout 
   {
      return _aa[idx];
   }

   bool remove(K key)
   {
      bool result = _aa.remove(key);
      
      if (result)
      {
         import std.algorithm : remove, countUntil;
         _keys = _keys.remove(_keys.countUntil(key));
      }

      return result;
   }

   bool opEquals(const PreservedAA!(K,V) obj) const
   {
      return this._aa == obj._aa;
   }

   override string toString() const 
   {
      import std.conv : to;
      return _aa.to!string;
   }

   auto opBinaryRight(string op)(K k) inout if (op == "in") {
      return (k in _aa);
   }

   size_t length() const { return _aa.length; }

   private K[] _keys;
   private V[K] _aa;
}


unittest
{

   import std.stdio;
   import std.exception;

   // A simple bson object. In json it would sound like:
   /* 
    *    {
    *       "type":"place",
    * 
    *       "address":
    *       {
    *          "street":"main st.",
    *          "number":15
    *       },
    * 
    *       "tags": ["first",2,"last"],
    *       "array" : [10, 20, 30]
    *    }
    * 
    */

   BsonObject obj = 
   BO
   (
      "type", "place", 
      "address", 
      BO
      (
         "street", "main st.", 
         "number", 15
      ), 
      "tags", BA("first", 2, "last"),   // Mixed-type array
      "array", [10, 20, 30] 
   );
   // Check that you can append to BO constructed without args.
   BO emptyBO;
   emptyBO.append (`test`, `value`);

   // get!type only works if requested type match the actual one
   assert(obj["type"].get!string == "place");
   assertThrown!(BsonException)(obj["type"].get!int);
   assertNotThrown(obj["/tags/0"].get!string);

   // to!type only works if field can be converted to the requested type
   assert(obj["/tags/1"].to!float == 2.0f);       // obj["/tags/1"] is int
   assert(obj["/tags/0"].to!string == "first");   // obj["/tags/0"] is string 
   assertThrown!(std.conv.ConvException)(obj["/tags/0"].to!int); // Can't convert "first" to int 

   // as!type works like to, but it doesn't throw exceptions, it simply returns a default value
   assert(obj["/address/street"].as!string == "main st.");
   assert(obj["/address/number"].as!string == "15");
   assert(obj["/address/asdasd"].as!int == int.init);      // Default value is type.init
   assert(obj["/address/asdasd"].as!int(50) == 50);      // Default value can be specified
   assert(obj["/address/number"].as!int(50) == 15);
   assert(!obj["address"]["number"]["this"].exists);      
   assert(!obj["address"]["asdasd"]["blah"].exists);   

   // Check this example ...
   obj["address"]["number"]["blah"]["blah"] = 42;  // We're assigning a temporary object so no side effect
   assert(obj["/address/number/blah/blah"].exists == false);

   // ... Vs this
   obj["/address/number/blah/blah"] = 42;   // Here we recreate the whole object tree

   assert(obj["/address/number/blah/blah"].exists == true);
   assert(obj["/address/number/blah/blah"].get!int == 42);
   // More as!T examples
   assert(obj["/tags/1"].as!int == 2);
   assert(obj["/tags/1"].as!long == 2);
   assert(obj["/tags/1"].as!string == "2");
   assert(obj["/tags/1"].as!string.ok);
   assert(obj["/tags/0"].as!string("nothing") == "first");

   // This field doesn't exists. It returns default value
   auto tmpField = obj["/address/asdasd"].as!int(50);
   assert(tmpField.ok == false);
   assert(tmpField.exists == false);
   assert(tmpField == 50);

   // This field exists, but can't be converted to int. It returns default value.
   tmpField = obj["/tags/0"].as!int(50);
   assert(tmpField.ok == false);
   assert(tmpField.exists == true); // <- exists but conversion failed
   assert(tmpField == 50);

   // Checks for dups
   auto newObj = obj.dup;   
   assert(obj["/address/number"].exists == true);
   assert(obj.toString == newObj.toString);
   obj["address"].remove("number");

   assert(obj["/address/number"].exists == false);
   assert(obj.toString != newObj.toString);

   // Array ops
   obj["/array"]    ~= 2;
   obj["/tags"]    ~= "hello";
   obj["/tags"]    ~= 15.3f;
   obj["/tags/0"]    = true;
   obj["/tags"][1] = false;

   // Check if array is built correctly
   assert(obj["tags"].toString == `[true,false,"last","hello",15.3]`);

   // This will replace whole array with an object
   obj["/tags/value"] = 10;               
   assert(obj["tags"].toString == `{"value":10}`);

   // This will replace the object with an integer
   obj["tags"] = 5;                      
   assert(obj["tags"].toString == `5`);

   // This will replace the object with an array
   obj["tags"] = [1,2,3];                   
   assert(obj["tags"].toString == `[1,2,3]`);

   // Assign an existing value
   assertNotThrown(obj["/tags/0"] = false);

   // Out of bounds
   assertNotThrown(obj["/tags/10"] = "fail");
   assert(obj["/tags/10"] == "fail");
   assert(obj["/tags/9"].isType!null);
   assert(obj["/tags"].as!BsonArray.length == 11);

   // "Address" it's not an array
   assertThrown(obj["/address/10"] = "fail");   

   obj["type"] ~= 20;                     // type was a string "place", now is ["place", 20]
   obj["type"] ~= 15;
   obj["type"] ~= null;
   assert(obj["type"].toString == `["place",20,15,null]`);

   assert(obj["/type/3"].isType!null);           // The right way to check if value is "null"
   assert(obj["/type/0"].isType!string);        // The way to check type
   assert(obj["/type/0"].isType!int == false);   
   assert(obj["/type/0"].isType!null == false);

   // Null is a special val in bson
   obj["/test/blah"] = null;               
   assert(obj["type"].isType!null == false);
   assert(obj["test"].toString == `{"blah":null}`);

   obj["/test/blah"] ~= 20;
   obj["/test/blah"] ~= BO("hello", "world");

   // Subobject are copied by ref
   obj["/sub-obj"] = newObj;
   obj["/sub-obj/type"] = "changed";
   assert(newObj["type"] == "changed");
   assert(obj["/sub-obj/type"] == newObj["type"]);

   // Unless you're using dup, of course
   obj["/sub-obj"] = newObj.dup;
   obj["/sub-obj/type"] = "copy";
   assert(newObj["type"] == "changed");
   assert(obj["/sub-obj/type"] != newObj["type"]);

   BsonObject fromJSON = BsonObject(`{"hello" : "world", "test": 1, "sub": {"zero": 2}}`);
   assert(fromJSON["hello"].to!string == "world");
   assert(fromJSON["/sub/zero"].to!int == 2);

}

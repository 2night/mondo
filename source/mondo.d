import mongoc;

import bsond;

private import std.algorithm  : map;
private import std.traits     : Unqual;
private import std.conv       : to, text;
private import std.regex      : regex, match;
private import std.string     : toUpper, toStringz;
private import std.range      : empty, isInputRange, ElementType, array;
import std.traits : EnumMembers;
import std.algorithm : map;
import std.conv : to;
import std.array : array;
import std.string : join;

// Some alias over c library structs/enums
alias LogLevel    = mongoc_log_level_t;
//alias QueryFlags  = mongoc_query_flags_t;
//alias InsertFlags = mongoc_insert_flags_t;
//alias DeleteFlags = mongoc_delete_flags_t;
//alias UpdateFlags = mongoc_update_flags_t;

alias ErrorCodes     = mongoc_error_code_t;
alias ErrorDomains   = mongoc_error_domain_t;
alias ReadMode       = mongoc_read_mode_t;

// Can you insert your custom struct/class into db?
// YOURTYPE.bson must return a BsonObject 
private enum canExportBson(T) = __traits(compiles, { void tmp(in BsonObject obj) { } const obj = T.init; tmp(obj.bson); } );

/// An error triggered by mongo.
class MongoException : Exception
{
   this(in ErrorDomains domain, in ErrorCodes code, in string message = "") 
   { 
      this.code = code;
      this.domain = domain;
      this.message = message;
      super(text("Mongo Exception - Code: ", code, " Domain: ", domain, " Message: ", message));
   }

   private this(in bson_error_t err)
   {
      this
      (
         cast(ErrorDomains)err.domain, 
         cast(ErrorCodes)err.code, 
         cast(string)(err.message)
      );
   }

   string        message;
   ErrorDomains   domain;
   ErrorCodes     code;
}

/// MongoDB WriteConcern params for query. Check mongo documentation.
class WriteConcern
{
   private this(const(mongoc_write_concern_t) *writeconcern) { _writeConcern = mongoc_write_concern_copy(writeconcern); }

   this()   { _writeConcern = mongoc_write_concern_new(); }
   ~this() { mongoc_write_concern_destroy(_writeConcern); }

   @property fsync()         { return cast(bool) mongoc_write_concern_get_fsync(_writeConcern); }
   @property fsync(bool v)    { mongoc_write_concern_set_fsync(_writeConcern, v); }

   @property journal()       { return cast(bool) mongoc_write_concern_get_journal(_writeConcern); }
   @property journal(bool v)   { mongoc_write_concern_set_journal(_writeConcern, v); }

   @property w()            { return cast(int) mongoc_write_concern_get_w(_writeConcern); }
   @property w(int w)        { mongoc_write_concern_set_w(_writeConcern, w); }

   @property wtimeout()      { return cast(int) mongoc_write_concern_get_wtimeout(_writeConcern); }
   @property wtimeout(int w)   { mongoc_write_concern_set_wtimeout(_writeConcern, w); }

   @property wmajority()      { return cast(int) mongoc_write_concern_get_wmajority(_writeConcern); }
   @property wmajority(int w)  { mongoc_write_concern_set_wmajority(_writeConcern, w); }

   private mongoc_write_concern_t *_writeConcern;
}


/// MongoDB ReadConcern params for query. Check mongo documentation.
class ReadConcern
{
   private this(const(mongoc_read_concern_t) *readconcern) { _readConcern = mongoc_read_concern_copy(readconcern); }

   this()   { _readConcern = mongoc_read_concern_new(); }
   ~this() { mongoc_read_concern_destroy(_readConcern); }

   @property level() { return to!string(mongoc_read_concern_get_level(_readConcern)); }
   @property level(in string level) { mongoc_read_concern_set_level(_readConcern, level.toStringz); }
   
   private mongoc_read_concern_t *_readConcern;
}


/// MongoDB Read Preferences params for query. Check mongo documentation.
class ReadPrefs
{
   private this(const(mongoc_read_prefs_t) *readprefs) { _readPrefs = mongoc_read_prefs_copy(readprefs); }
   
   this() { _readPrefs = null; /*mongoc_read_prefs_new();*/ }
   ~this() { mongoc_read_prefs_destroy(_readPrefs); }

   @property mode(in ReadMode rm) { mongoc_read_prefs_set_mode(_readPrefs, rm); }
   @property mode() { return cast(ReadMode)mongoc_read_prefs_get_mode(_readPrefs); }

   private mongoc_read_prefs_t *_readPrefs;
}

/// MongoDB SslOptions. Check mongo documentation.
class SslOptions
{
   private this(const(mongoc_ssl_opt_t) *opt)
   {
      pemFile = to!string(opt.pem_file);
      pemPwd  = to!string(opt.pem_pwd);
      caFile  = to!string(opt.ca_file);
      caDir   = to!string(opt.ca_dir);
      crlFile = to!string(opt.crl_file);

      weakCertValidation = opt.weak_cert_validation != 0;
   }

   private mongoc_ssl_opt_t* sslOptions()
   {
      _options.pem_file   = pemFile.ptr;
      _options.pem_pwd   = pemPwd.ptr;
      _options.ca_file   = caFile.ptr;
      _options.ca_dir    = caDir.ptr;
      _options.crl_file   = crlFile.ptr;

      _options.weak_cert_validation = weakCertValidation?1:0;

      return &_options;
   }

   private mongoc_ssl_opt_t _options;

   string  pemFile;
   string  pemPwd;
   string  caFile;
   string  caDir;
   string  crlFile;

   bool weakCertValidation;
}

/// A simple class that hold query informations
class Query
{
   /// Simply return an empty query (just to avoid (new Query()) verbosity on ufcs)
   static Query init() { return new Query(); }

   private template DeclareChainingProperty(string name, T)
   {
      enum MangledProperty = "_" ~ name;
      enum DeclareChainingProperty = 
         "@property auto ref " ~ name ~ "() inout { return " ~ MangledProperty ~ ";}\n" ~
         "@property auto ref " ~ name ~ "(" ~ T.stringof ~ " val) { " ~ MangledProperty ~ " = val; return this;} ";
   }

   private template DeclareQueryField(string T)
   {
      enum var = "_" ~ T;
      enum DeclareQueryField = 
         "@property auto ref " ~ T ~ "() inout { return " ~ var ~ "; }\n" ~
         "@property auto ref " ~ T ~ "(BsonObject b) { " ~ var ~ " = b; return this; }\n" ~
         "@property has" ~ toUpper(T[0..1]) ~ T[1..$] ~ "() const { return !" ~ var ~ ".empty; }\n";
   }

   mixin(DeclareChainingProperty!("limit", int));
   mixin(DeclareChainingProperty!("skip", int));
   mixin(DeclareChainingProperty!("explain", bool));
   mixin(DeclareChainingProperty!("comment", string));
   mixin(DeclareChainingProperty!("returnKey", bool));
   mixin(DeclareChainingProperty!("snapshot", bool));
   mixin(DeclareChainingProperty!("showDiskLoc", bool));

   mixin(DeclareQueryField!"conditions");
   mixin(DeclareQueryField!"sorts");
   mixin(DeclareQueryField!"fields");
   mixin(DeclareQueryField!"hint");
   mixin(DeclareQueryField!"max");
   mixin(DeclareQueryField!"min");
   mixin(DeclareQueryField!"maxScan");

   private
   {
      BsonObject  _conditions;
      BsonObject  _sorts;
      BsonObject  _fields;
      BsonObject  _hint;
      BsonObject  _max;
      BsonObject  _min;
      BsonObject  _maxScan;

      bool   _explain = false;
      int    _skip   = 0;
      int    _limit   = 0;
      
      string  _comment;
      
      bool   _returnKey   = false;
      bool   _snapshot   = false;
      bool   _showDiskLoc = false;
   }
}

/// Class to manage connection pools. It should be thread safe.
class MongoPool
{
   this(in string connectionString) 
   { 
      _uri = mongoc_uri_new (connectionString.toStringz);

      if (_uri is null)
         throw new Exception("Invalid db uri");

      _pool = mongoc_client_pool_new(_uri);
      garbage.addChild(new RefCountTree("uri", RefCountTree.Type.uri_t, _uri)); 
      garbageIdx[_uri].addChild(new RefCountTree("pool", RefCountTree.Type.pool_t, _pool)); 
   }

   ~this()
   {
      garbageIdx[_pool].canBeDestroyed();
      garbageIdx[_uri].canBeDestroyed();
   }

   // Get a connection from a pool. It will be recycled when returned class will be destroyed.
   Mongo pop() 
   {
      return new Mongo(this);
   }

   @property sslOptions(SslOptions opt) { mongoc_client_pool_set_ssl_opts(_pool, opt.sslOptions); }
   @property max(in uint maxSize) { mongoc_client_pool_max_size(_pool, maxSize); }
   @property min(in uint minSize) { mongoc_client_pool_max_size(_pool, minSize); }
   
   private mongoc_client_pool_t* _pool  = null;
   private mongoc_uri_t*         _uri   = null;
}

unittest
{
   MongoPool pool = new MongoPool("mongodb://localhost");
   Mongo mongo = pool.pop;
   assert(mongo.connected == true);
   assert(mongo.dbs.length > 0);
}

// LogFunction used by class MongoLogger
alias LogFunction = void delegate(LogLevel, in string, in string);
   
/// Simple way to catch mongo log using a callback
class MongoLogger
{
   
   private static extern(C) void logRedirector(mongoc_log_level_t level, const(char)* domain, const(char)* message, void*) 
   {
      string sDomain = to!string(domain);
      string sMessage = to!string(message);
     
      foreach(logger; _loggers)
       logger(level, sDomain, sMessage); 
   }
   
   static this()
   {
      mongoc_log_set_handler(&logRedirector, null); 
   }

   static removeAll() { _loggers = null; }
   
   /// Add a new callback
   static void addLogger(LogFunction f)      {  _loggers[f] = f;  }
   
   /// Remove a previously added callback
   static void removeLogger(LogFunction f)   { _loggers.remove(f); }

   private static LogFunction[LogFunction] _loggers;
}

unittest
{
   string[] log; 
   MongoLogger.addLogger((LogLevel ll, in string logDomain, in string message) { log ~= message; });
   mongoc_log(mongoc_log_level_t.LEVEL_ERROR, "test", "asd");
   assert(log.length > 0);
}


/// Main class. Connect to mongo and gives access to Dbs. If you need thread safety, try with MongoPool.
class Mongo
{

   /** 
    * Create main mongo class and start connection 
    * 
    * Params:
    *  connectionString Mongo connection string 
    * 
    * Example:
    * -----
    * auto mongo = new Mongo("mongodb://localhost");
    * auto db = mongo["my_database"];
    * -----
    */
   this(in string connectionString) 
   { 
      _client = mongoc_client_new(connectionString.toStringz);

      if (_client is null)
         throw new Exception("Invalid db uri");

      _inited = true;
      _pool = null;

      initBsonCtx();
      
      garbage.addChild(new RefCountTree("mongo", RefCountTree.type.client_t, _client));
   }

   private this(MongoPool mongoPool)
   {
      _mongoPool = mongoPool;
      _pool = mongoPool._pool;
      _client = mongoc_client_pool_pop(_pool);

      if (_client is null)
         throw new Exception("Invalid db uri");

      _inited = true;

      initBsonCtx();
      
      garbageIdx[_pool].addChild(new RefCountTree("pool_client", RefCountTree.type.pool_client_t, _client));
   }

   ~this() 
   {  
      if(_bson_ctx) bson_context_destroy(_bson_ctx); 
      
      if (_inited && _client)
      {
         garbageIdx[_client].canBeDestroyed();
      }

      _pool = null;
      _client = null;
   }
   
   private void initBsonCtx() { _bson_ctx = bson_context_get_default(); }

   /// It generate a new Bson OID. OIDs are UUID.
   public ObjectId generateObjectId()
   {
      bson_oid_t tmp;
      bson_oid_init(&tmp, _bson_ctx);
     
      return ObjectId(cast(ubyte[])tmp.bytes);
   }

   unittest
   {
      Mongo m = new Mongo("mongodb://localhost");
      assert(m.generateObjectId.length == 12);
   }
  

   /// Global writeConcern settings.
   @property WriteConcern writeConcern() { return new WriteConcern(mongoc_client_get_write_concern(_client)); }  
   @property void writeConcern(WriteConcern wc) { mongoc_client_set_write_concern(_client, wc._writeConcern); } /// ditto

   /// Global readConcern settings.
   @property ReadConcern readConcern() { return new ReadConcern(mongoc_client_get_read_concern(_client)); }  
   @property void readConcern(ReadConcern rc) { mongoc_client_set_read_concern(_client, rc._readConcern); } /// ditto

   /// Global readPrefs settings.
   @property ReadPrefs readPrefs() { return new ReadPrefs(mongoc_client_get_read_prefs(_client)); }  
   @property void readPrefs(ReadPrefs rp) { mongoc_client_set_read_prefs(_client, rp._readPrefs); } /// ditto

   @property sslOptions(SslOptions opt) { mongoc_client_set_ssl_opts(_client, opt.sslOptions); }
   
   /// Hey are we connected?
   @property connected() 
   { 
      if (!_inited || _client == null) 
         return false;
      
      bson_t reply;

      scope(exit) bson_destroy(&reply);
      mixin(MongoReadPrefsMixin);

      auto copy = mongoc_read_prefs_copy(prefs);
      scope(exit) mongoc_read_prefs_destroy(copy);

      return mongoc_client_get_server_status(_client, copy, &reply, null);
   }

   /// Returns db status
   @property status()
   { 
      bson_t reply;
      bson_error_t error;
     
      scope(exit) bson_destroy(&reply);
      mixin(MongoReadPrefsMixin);
     
      auto copy = mongoc_read_prefs_copy(prefs);
      scope(exit) mongoc_read_prefs_destroy(copy);
     
      auto result = mongoc_client_get_server_status(_client, copy, &reply, &error);
     
      auto response = BsonObject(bson_get_data(&reply));

      if (!result)
       throw new MongoException(error);
     
      return response;
   }
   
   unittest
   {
      import std.exception;
      
      {
         Mongo m = new Mongo("mongodb://localhost");
         assert(m.connected == true);
         assertNotThrown(m.status);
      }
      
      {
         Mongo m = new Mongo("mongodb://localhostasd");
         assert(m.connected == false);
         assertThrown(m.status);
      }
   }
   
   Db opIndex(in string db) { return new Db(this, db); }
   Db opDispatch(string db)() { return opIndex(db); }

   /// Get available db names
   string[] dbs()
   {
      string[] dbNames;
      char **strv = null;
      mixin(MongoWrapErrorMixin!"(strv = mongoc_client_get_database_names (_client, &error)) == null");
      for(size_t i = 0; strv[i]; ++i)
         dbNames ~= to!string(strv[i]);
      
      bson_strfreev(strv);
      return dbNames;
   }
   
   unittest
   {
      assert((new Mongo("mongodb://localhost")).dbs.length > 0);
   }
   
   private bool                     _inited = false;
   private MongoPool                _mongoPool;
   private mongoc_client_pool_t*    _pool   = null;
   private mongoc_client_t*         _client = null;
   private bson_context_t*          _bson_ctx = null;

}

/**
 * Class representing a db. You can't create it directly. Use Mongo m = ...;  Db db = m["your_db"];
 */
class Db
{
   // You can't build this directly, sorry. Use Mongo m = ...;  Db db = m["your_db"];
   private this(Mongo mongo, in string db)   
   { 
      _mongo = mongo; 
      _name = db; 
      _db = mongoc_client_get_database(_mongo._client, _name.toStringz);
      
      garbageIdx[_mongo._client].addChild(new RefCountTree("db", RefCountTree.Type.db_t, _db));
   }

   ~this() { garbageIdx[_db].canBeDestroyed(); } //if (_db) mongoc_database_destroy(_db); }

   /**
    * Run a command on db
    */
   BsonObject runCommand(in BsonObject command, in ReadPrefs readPrefs = null)            
   { 
      bson_t bson_reply;
      mixin(MongoReadPrefsMixin);
      mixin(BsonInitMixin!command);
      mixin(MongoWrapErrorMixin!"mongoc_database_command_simple(_db, &bson_command, prefs, &bson_reply, &error) == 0");
      return BsonObject(bson_get_data(&bson_reply));
   }

   Collection opIndex(in string collection) { return new Collection(_mongo, this, collection); }
   Collection opDispatch(string s)() 
   { 
      return opIndex(s);
   }

   /// It drops the whole database. Be careful!
   public void drop() { mixin(MongoWrapErrorMixin!"mongoc_database_drop(_db, &error) == 0");}

   /// Get collections names
   string[] collections()
   {
      string[] collectionsNames;
      char **strv = null;
      mixin(MongoWrapErrorMixin!"(strv = mongoc_database_get_collection_names (_db, &error)) == null");
      for(size_t i = 0; strv[i]; ++i)
         collectionsNames ~= to!string(strv[i]);
      
      bson_strfreev(strv);
      return collectionsNames;
   }
   
   /// Check if collection exists on this db
   public bool hasCollection(in string name) 
   { 
      bson_error_t error;
      return mongoc_database_has_collection(_db, name.toStringz, &error) != 0; 
   }

   @property WriteConcern writeConcern() { return new WriteConcern(mongoc_database_get_write_concern(_db)); }  
   @property void writeConcern(WriteConcern wc) { mongoc_database_set_write_concern(_db, wc._writeConcern); }
   
   @property ReadConcern readConcern() { return new ReadConcern(mongoc_database_get_read_concern(_db)); }  
   @property void readConcern(ReadConcern rc) { mongoc_database_set_read_concern(_db, rc._readConcern); } /// ditto
   
   @property ReadPrefs readPrefs() { return new ReadPrefs(mongoc_database_get_read_prefs(_db)); }  
   @property void readPrefs(ReadPrefs rp) { mongoc_database_set_read_prefs(_db, rp._readPrefs); }

   /// Return db name
   @property name()      { return _name; }
    
   /// Return a ref to its own db
   @property mongo()     { return _mongo; }

   private string           _name;
   private Mongo            _mongo;
   private mongoc_database_t   *_db = null;
}

/**
 * Class representing a collection. You can't create it directly. Use  Db db = ...; Collection c = db.your_collection; or Collection c = db["your_collection"];
 */
class Collection
{
   private this(Mongo mongo,  Db db, in string collection) 
   { 
      _mongo = mongo; 
      _name = collection; 
      _db = db; 
      _collection = mongoc_client_get_collection(_mongo._client, _db.name.toStringz, collection.toStringz);
      garbageIdx[_db._db].addChild(new RefCountTree("collection", RefCountTree.Type.collection_t, _collection));
   }

   ~this() { garbageIdx[_collection].canBeDestroyed(); }

   /// Does this collection exist? 
   public bool exists() { return _db.hasCollection(_name); }
   
   /// Perform a simple distinct command on collection
   public auto distinct(in string field)
   {
      return _db.runCommand(BO("distinct", name, "key", field))["values"].as!BsonArray;
   }
   
   /// Update or upsert (check UpdateFlags!) multiple/single objects (again check UpdateFlags) that satisfy selector conditions. 
   public void update(in BsonObject selector, in BsonObject update, in UpdateFlags flags = UpdateFlags.NONE, in WriteConcern writeConcern = null)
   {
      mixin(MongoWriteConcernMixin);
      mixin(BsonInitMixin!selector);
      mixin(BsonInitMixin!update);
      mixin(MongoWrapErrorMixin!"mongoc_collection_update(_collection, cast(mongoc_update_flags_t)flags, &bson_selector, &bson_update, wc, &error) == 0");
   }

   /// Remove multiple/single objects (check DeleteFlags!)
   public void remove(in BsonObject selector, in DeleteFlags flags = DeleteFlags.NONE, in WriteConcern writeConcern = null)
   {
      mixin(MongoWriteConcernMixin);
      mixin(BsonInitMixin!selector);
      mixin(MongoWrapErrorMixin!"mongoc_collection_delete(_collection, flags, &bson_selector, wc, &error) == 0");
   }

   /// Save an object into db. Every struct or class is good if I can call `yourVariable.bson` and it returns a BsonObject
   public void save(T)(in T document, in WriteConcern writeConcern = null) if (!is(Unqual!T == BsonObject))
   {
      static if (!canExportBson!T)  static assert(false, "save!" ~ T.stringof ~ "(...) works only if `const(" ~ T.stringof ~").bson` is a BsonObject.");
      else save(document.bson, writeConcern);
   }
   
   /// Save a BsonObject into Db
   public void save(in BsonObject document, in WriteConcern writeConcern = null)
   {
      mixin(MongoWriteConcernMixin);
      mixin(BsonInitMixin!document);
      mixin(MongoWrapErrorMixin!"mongoc_collection_save(_collection, &bson_document, wc, &error) == 0");
   }
   
   /// Insert an object into db. Every struct or class is good if I can call `yourVariable.bson` and it returns a BsonObject
   public void insert(T)(in T document, in InsertFlags flags = InsertFlags.NONE, in WriteConcern writeConcern = null) if (!(isInputRange!T))
   {
      static if (!canExportBson!T)  static assert(false, "insert!" ~ T.stringof ~ "(...) works only if `const(" ~ T.stringof ~").bson` is a BsonObject.");
      else insert(document.bson, flags, writeConcern);
   }
   
   /// Insert a BsonObject into Db
   public void insert(in BsonObject document, in InsertFlags flags = InsertFlags.NONE, in WriteConcern writeConcern = null)
   {
      mixin(MongoWriteConcernMixin);
      mixin(BsonInitMixin!document);
      mixin(MongoWrapErrorMixin!"mongoc_collection_insert(_collection, flags, &bson_document, wc, &error) == 0");
   }

   /// Insert a range of objects into db. Every struct or class is good if I can call `yourVariable.bson` and it returns a BsonObject
   public void insert(Range)(Range documentsRange, in InsertFlags flags = InsertFlags.NONE, in WriteConcern writeConcern = null) if (isInputRange!Range && !is(ElementType!Range == BsonObject))
   {
      static if (!canExportBson!(ElementType!Range)) static assert(false, "insert(Range...) works only if const(ElementType!Range).bson is a BsonObject.");
      else 
      {
         insert(documentsRange.map!(x => x.bson), flags, writeConcern);
      }
   }
   
   /// Insert a range of bsonobjects into db.
   public void insert(Range)(Range documentsRange, in InsertFlags flags = InsertFlags.NONE, in WriteConcern writeConcern = null) if (isInputRange!Range && is(ElementType!Range == BsonObject))
   {
      mixin(MongoWriteConcernMixin);
      auto documents = documentsRange.map!((doc) => bson_from_array(doc.exportData())).array;
      scope(exit) { foreach(document; documents) bson_destroy(document); }

      assert(documents.length < int.max, "Too many documents to insert");
      mixin(MongoWrapErrorMixin!"mongoc_collection_insert_bulk(_collection, flags, documents.ptr, cast(int)documents.length, wc, &error) == 0");
   }

   /// Return number of documents matching conditions
   public long count(in BsonObject conditions, in QueryFlags flags = QueryFlags.NONE, in ReadPrefs readPrefs = null)
   {
      mixin(MongoReadPrefsMixin);
      mixin(BsonInitMixin!conditions);

      bson_error_t error;
      long total = mongoc_collection_count(_collection, flags, &bson_conditions, 0, 0, prefs, &error);

      if (total < 0) throw new MongoException(error);
      return total;
   }

   /// Return number of documents in this collection
   public long count()
   {
      BsonObject tmp;
      return count(tmp);
   }

   /// This drop the whole collection. Be careful!
   public void drop()
   {
      mixin(MongoWrapErrorMixin!"mongoc_collection_drop(_collection, &error) == 0");
   }
   
   /// Return a (lazy) range holding query results. find!T works if T(BsonObject()) or new T(BsonObject()) works too.
   public auto find(T = BsonObject)(in Query query = Query.init, in QueryFlags flags = QueryFlags.NONE, in ReadPrefs readPrefs = null) 
   {
      return findImpl!(T, false)(query, flags, readPrefs);
   }

   /// Return first result of find!T(...)
   public T findOne(T = BsonObject)(in Query query = Query.init, in QueryFlags flags = QueryFlags.NONE, in ReadPrefs readPrefs = null) 
   {
      static if (!(is(T == BsonObject) || isBsonContainer!T)) static assert(false, "findOne!T(...) works only if `T(BsonObject())` or `new T(BsonObject())` works.");
      else 
      {
         auto cursor = findImpl!(T, true)(query, flags, readPrefs);

         if (cursor.empty)
         {
            static if (isBsonContainerClass!T) return null;
            else return T.init;
         }
         else              return cursor.front;   // First result returned.
      }
   }

   private auto findImpl(T = BsonObject, bool justOne = false)(in Query query, in QueryFlags flags = QueryFlags.NONE, in ReadPrefs readPrefs = null)
   {
      static if (!(is(T == BsonObject) || isBsonContainer!T)) static assert(false, "findOne!" ~ T.stringof ~ "(...) / find!" ~ T.stringof ~ "(...) works only if `"~ T.stringof ~"(BsonObject())` or `new " ~ T.stringof ~ "(BsonObject())` work.");
      else 
      {
         mixin(MongoReadPrefsMixin);

         BsonObject q;

         if (query.hasConditions)   q["$query"] = query.conditions.dup;
         if (query.hasSorts)       q["$orderby"] = query.sorts.dup;
         if (query.hasHint)        q["$hint"] = query.hint.dup;
         if (query.hasMax)         q["$max"] = query.max.dup;
         if (query.hasMin)         q["$min"] = query.min.dup;
         if (query.hasMaxScan)      q["$maxScan"] = query.maxScan.dup;

         if (query.explain)        q["$explain"] = true;
         if (!query.comment.empty)   q["$comment"] = query.comment;
         if (query.returnKey)      q["$returnKey"] = true;
         if (query.snapshot)       q["$snapshot"] = true;
         if (query.showDiskLoc)     q["$showDiskLoc"] = true;

         mixin(BsonInitMixin!q);
         bson_t bson_fields;
         bool hasFields = query.hasFields;

         if (hasFields)
         {
            bson_init_from_array(&bson_fields, query.fields.exportData());
            scope(exit) { bson_destroy(&bson_fields); }
         }

         import std.range;
         auto cursor = Cursor!T
         (
            _collection,
            mongoc_collection_find(_collection, flags, query.skip, justOne?1:query.limit, 0, &bson_q, hasFields?&bson_fields:null, prefs),
            flags
         );

         return cursor;
      }
   }

   /// Execute an aggregate command on this collection
   Cursor!T aggregate(T = BsonObject, K)(in K aggregate, in BsonObject options = BsonObject.init, in QueryFlags flags = QueryFlags.NONE, in ReadPrefs readPrefs = null)
   if (is(Unqual!K == BsonArray) || is(Unqual!K == BsonObject))
   {
      mixin(MongoReadPrefsMixin);
      mixin(BsonInitMixin!aggregate);
      mixin(BsonInitMixin!options);

      auto ret = Cursor!T
      (
         _collection,
         mongoc_collection_aggregate(_collection, flags, &bson_aggregate, &bson_options, prefs),
         flags
      );
      
      return ret;
   }

   @property WriteConcern writeConcern() { return new WriteConcern(mongoc_collection_get_write_concern(_collection)); }  
   @property void writeConcern(WriteConcern wc) { mongoc_collection_set_write_concern(_collection, wc._writeConcern); }
     
   @property ReadConcern readConcern() { return new ReadConcern(mongoc_collection_get_read_concern(_collection)); }  
   @property void readConcern(ReadConcern rc) { mongoc_collection_set_read_concern(_collection, rc._readConcern); } /// ditto
   
   @property ReadPrefs readPrefs() { return new ReadPrefs(mongoc_collection_get_read_prefs(_collection)); }  
   @property void readPrefs(ReadPrefs rp) { mongoc_collection_set_read_prefs(_collection, rp._readPrefs); }

   /// What's your name, collection?
   @property name()      { return _name; }
   
   // A reference to parent db
   @property db()        { return _db; }
   
   private Db                 _db;
   private Mongo              _mongo;
   private string             _name;
   public mongoc_collection_t *_collection;
}


/// Cursor pointing to query results. Implemented as InputRange.
struct Cursor(T = BsonObject) if (is(T == BsonObject) || isBsonContainer!T)
{
   private __gshared size_t[mongoc_cursor_t*] cursorReference;
   
   private class IncrLock { }
   private __gshared IncrLock lock;
   
   shared static this() { lock = new IncrLock; }
   
   private this(mongoc_collection_t* collection, mongoc_cursor_t* cursor, QueryFlags flags = QueryFlags.NONE) 
   { 
      _collection  = collection;
      _cursor = cursor;  
      _flags = flags;
      
      synchronized(lock)
      {
         if (_cursor !in cursorReference) 
         {
            garbageIdx[_collection].addChild(new RefCountTree("cursor", RefCountTree.Type.cursor_t, _cursor));
            cursorReference[_cursor] = 1;
         }
         else cursorReference[_cursor]++;
      }
   }
   
   public this(this)
   {
      synchronized(lock)
         cursorReference[this._cursor]++;
   }
   
   ~this() 
   {
      synchronized(lock)
      {
         cursorReference[_cursor]--;
         if (cursorReference[_cursor] == 0)
         {
            garbageIdx[_cursor].canBeDestroyed();
         }
      }
   }

   private void tryInit() { if (!_inited) next(); }

   private bool next()
   {
      _inited = true;

      // Read next value
      if (!mongoc_cursor_next(_cursor, cast(const(bson_t)**) &_current))
      {
         _empty = true;
         return false;
      } else _empty = false;

      return true;
   }
   
   @property T front() 
   {
      tryInit();

      static if (isBsonContainer!T)
      {
         BsonObject result = BsonObject(bson_get_data(_current));
         static if (isBsonContainerClass!T) return new T(result);
         else return T(result);
      }
      else static if(is (T == BsonObject)) return BsonObject(bson_get_data(_current));
      else static assert(false, text("Can't read a ", T.stringof, " object from mongo. You should define a ctor that accepts a BsonObject as param."));

   }
   
   void popFront()
   {
      tryInit();
      next();
   }
   
   @property empty() 
   {  
      tryInit();

      if (_empty && (_flags & QueryFlags.TAILABLE_CURSOR) == QueryFlags.TAILABLE_CURSOR)
         next();

      return _empty;
   }

   
   private mongoc_cursor_t*   _cursor  = null;
   private bson_t*            _current = null;
   private bool               _inited  = false;
   private bool               _empty   = false;

   private mongoc_collection_t*   _collection = null;
   private QueryFlags   _flags;
}

private template BsonInitMixin(alias T)
{
   enum object_name = T.stringof;
   enum bson_t_name = "bson_" ~ object_name;
   enum BsonInitMixin = 
      "bson_t " ~ bson_t_name ~ "; " ~
      "bson_init_from_array(&" ~ bson_t_name ~ ", " ~ object_name ~ ".exportData());" ~
      "scope(exit) { bson_destroy(&" ~ bson_t_name ~ "); }";
   
}


private enum MongoWrapErrorMixin(string T)  = "bson_error_t error; if (" ~ T ~ ") throw new MongoException(error);";
private enum MongoReadPrefsMixin         = "const mongoc_read_prefs_t *prefs = (readPrefs is null)?null:readPrefs._readPrefs;";
private enum MongoWriteConcernMixin       = "const mongoc_write_concern_t *wc = (writeConcern is null)?null:writeConcern._writeConcern;";
      

private bson_t* bson_from_array(in ubyte[] data) 
in     { assert(data.length <= int.max, "Too much data for bson"); }
body   { return bson_new_from_data(data.ptr, data.length); }

private bool bson_init_from_array(bson_t* bson, in ubyte[] data) 
in     { assert(data.length <= int.max, "Too much data for bson"); }
body   { return bson_init_static(bson, data.ptr, cast(int)data.length) != 0; }

// Ok GC, object should be destroyed in the right order.
private class RefCountTree
{
   private enum Type
   {
      root,
      uri_t,
      pool_t,
      client_t,
      pool_client_t,
      db_t,
      collection_t,
      cursor_t
   }
   
   this(string id, Type type, void* address = null)
   {
      this.id = id;
      this.type = type;
      this.address = address;
      garbageIdx[this.address] = this;
      
      // debug { writeln("Build ", id, " with address ", address); }
   }
   
   bool tryDestroy()
   {
      if (children.length > 0 || (this.address == null && this.type != Type.root)  || !toDestroy)
      {
         // debug { writeln("TryDestroy ", id, " with address ", address, " fail. toDestroy: ", toDestroy, " children.lenght:", children.length); }
         return false; 
      } 
      
      // debug { writeln("Destroying ", id, " with address ", address); }
      
      final switch(type)
      {
         case Type.pool_t: mongoc_client_pool_destroy(cast(mongoc_client_pool_t*)address); break;
         case Type.client_t: mongoc_client_destroy(cast(mongoc_client_t*)address); break;
         case Type.pool_client_t: mongoc_client_pool_push(cast(mongoc_client_pool_t*)parent.address, cast(mongoc_client_t*)address); break;
         case Type.uri_t: mongoc_uri_destroy(cast(_mongoc_uri_t*)address); break;
         case Type.cursor_t: mongoc_cursor_destroy(cast(mongoc_cursor_t*)address); break;
         case Type.db_t: mongoc_database_destroy(cast(mongoc_database_t*)address); break;
         case Type.collection_t: mongoc_collection_destroy(cast(mongoc_collection_t*)address); break;
         case Type.root: mongoc_cleanup(); break;
      }
      
      assert(parent !is null || type == Type.root);
      
      if (parent)
         parent.removeChild(this);
      
      return true;
   }
   
   bool canBeDestroyed()
   {
      // debug { writeln("Marked destroyable ", id, " with address ", address); }
      toDestroy = true;
      return tryDestroy();
   }
   
   void addChild(RefCountTree mi)
   {
       // debug { writeln("Add child to: ", id, " with address ", address, " child ", mi.id, " with address ", mi.address); }
      children[mi.address] = mi;
      mi.parent = this;
   }
   
   bool removeChild(RefCountTree mi)
   {
      // debug {writeln("Removing child from: ", id, " with address ", address, " child ", mi.id, " with address ", mi.address); }
      children.remove(mi.address);
      return tryDestroy();
   }
   
   bool                 toDestroy = false;
   void*                address = null;
   Type                 type;
   RefCountTree         parent = null;
   RefCountTree[void*]  children;  
   
   string id; 
}

private static __gshared RefCountTree[void*] garbageIdx;
private static __gshared RefCountTree garbage;

shared static this()
{
   mongoc_init();
   garbage = new RefCountTree("root", RefCountTree.Type.root, null); 
} 

shared static ~this()
{ 
   garbage.canBeDestroyed();
}

# mondo
D library for MongoDb (over mongo-c-driver 1.8.0).

You need to install libmongo on your system.

Fast way to get mongo-c-driver on your machine:

```
$ curl -LO https://github.com/mongodb/mongo-c-driver/releases/download/1.8.0/mongo-c-driver-1.8.0.tar.gz
$ tar xzf mongo-c-driver-1.8.0.tar.gz
$ cd mongo-c-driver-1.8.0/
$ ./configure --with-libbson=bundled
$ make 
$ sudo make install
```


Tested with dmd and ldc2 on Ubuntu/Linux.

## How it works

```d
import mondo;
import bsond;

void main()
{   
  // Create a connection to mongo
  Mongo mongo = new Mongo("mongodb://localhost");
   
  // Also: Collection c = mongo["my_database"]["my_collection"]
  Collection c = mongo.my_database.my_collection;
   
  // Drop collection if already exists
  if (c.exists) c.drop();
   
  // Insert a new object. BO is an alias for BsonObject
  // It inserts something like {"my_message" : "Ciao Mondo!", "my_language" : "it"}
  c.insert(BO(
    "my_message", "Ciao Mondo!",  // It actually means "Hello World!" in italian
    "my_language", "it"
  ));
   
  assert(c.count == 1); // Of course.
   
  auto obj = c.findOne(); // Returns the first object it finds
   
  // Verify it is the object we've just inserted
  assert( obj["my_message"].as!string == "Ciao Mondo!" );
  assert( obj["blah"].as!string("default") == "default"); // This field doesn't exists
   
  auto field = obj["my_message"].as!int(42); 
  assert(field == 42);             // Conversion error. Defaulted
  assert(field.exists == true);    // Field exists on db
  assert(field.ok == false);       // But can't read as int
   
  obj["my_message"]    = "Hello World!";
  obj["my_language"]   = "en";
   
  // Save back object to db
  c.save(obj);
   
  // Do a simple check for all objects inside collection (just one)
  // c.find() returns a lazy range of BsonObject.
  import std.algorithm : all;
  assert(c.find.all!(x => x["my_language"].as!string == "en") == true);
}
```

## Binding a custom class/struct

```d

void bind_test()
{
  // Create a connection to mongo
  Mongo mongo = new Mongo("mongodb://localhost");
   
  // Also: Collection c = mongo["my_database"]["my_collection"]
  Collection c = mongo.my_database.my_collection;
   
  // Drop collection if already exists
  if (c.exists) c.drop();
    
  c.insert(BO("nickname", "trikko", "info", BO("firstname", "Andrea", "lastname", "Fontana")));
  c.insert(BO("nickname", "other", "info", BO("firstname", "Foo", "lastname", "Bar")));
   
  // Find return a User instead of a BsonObject
  foreach(user; c.find!User)
  {
    user.nickname = user.nickname ~ "_1";
    
    // It saves back object to db
    c.save(user);
  }
   
  import std.algorithm : all, endsWith;
  assert(c.find!User.all!(x => x.nickname.endsWith("_1")));
}

// Class works too
struct User
{
  @property string firstname()  { return _bson["/info/firstname"].as!string; }
  @property string lastname()   { return _bson["/info/lastname"].as!string; }
  @property string nickname()   { return _bson["nickname"].as!string; }
   
  @property void nickname(in string nickname) { _bson["nickname"] = nickname; }

  // This is required if you want to read from db
  this(BsonObject bo) { _bson = bo; }
   
  // This is required if you want to save to db
  // If BsonObject obj = yourobject.bson; compiles, it's fine.
  @property auto bson() const { return _bson; }
   
  BsonObject _bson;
}

```
## Perform a simple search

```d
import std.range;
import std.algorithm;
import std.array;
import std.stdio;
   
void search_test()
{
   
  // Create a connection to mongo
  Mongo mongo = new Mongo("mongodb://localhost");
   
  // Also: Collection c = mongo["my_database"]["my_collection"]
  Collection c = mongo.my_database.my_collection;
   
  // Drop collection if already exists
  if (c.exists) c.drop();
   
  // Create 100 random users
  // Sort by score
  // Update ranking for the first 10 
  // Save to db the top ten
  auto data = new RandomUserGenerator()
    .take(100)
    .array
    .sort!((a,b) => a["points"].as!float < b["points"].as!float)
    .enumerate(1)
    .take(10)
    .map!( (x) { x.value["ranking"] = to!int(x.index); return x.value; } );

  // I can insert a range of custom struct/class too
  c.insert(data);
   
  // Simple query to get only nickname of users named mark
  {
    Query q = new Query();
    q.conditions["name"] = "mark";
    q.fields["nickname"] = true;
    c.find(q).each!writeln;
  }
   
  // Same query, but working with helper functions defined below
  {
    c.find
    (
      Query.init
      .filterByName("mark")
      .showFields(["nickname"])
    )
    .each!writeln;
  }
}

// Helper function could be a good idea
auto filterByName(Query q, in string name) { q.conditions["name"] = name; return q; }
auto showFields(Query q, in string[] fields) { fields.each!(x => q.fields[x] = true); return q; }

// I use this to create some random data to fill database
class RandomUserGenerator
{
   this() { popFront(); }
   
   void popFront() 
   {
      import std.random;
      string[] names = ["mark", "john", "andrew"];
      string name = randomSample(names, 1).front;
      
      front = BO(
         "name", name, 
         "nickname", name ~ uniform(1000,9999).to!string,
         "age", uniform(20,30),
         "points", uniform(0.0f, 100.0f)
      ); 
   }
   
   BsonObject front;
   bool empty = false;
 
}
```

### More examples

For more examples just check unittests :)

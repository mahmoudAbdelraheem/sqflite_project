import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await inatialDb();
      return _db;
    } else {
      return _db;
    }
  }

  // this function for create local database
  Future<Database> inatialDb() async {
    //get database path
    String dbPath = await getDatabasesPath();
    String fullPath = join(dbPath, "note_db.db");
    Database myDb = await openDatabase(fullPath,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

// this function is called when update the database
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("onUpgrade ==============================================");
  }

// just called one time on create database
  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "notes" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "title" TEXT NOT NULL,
        "note" TEXT NOT NULL ,
        "color" TEXT 
      )    
    ''');

    print("onCreate ==============================================");
  }

  // to get  data from database
  Future<List<Map>> readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  // to insert  data into database
  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  // to update  data in database
  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  // to delete  data from database
  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  // for delete database
  void deleteMyDb() async {
    String dbPath = await getDatabasesPath();
    String fullPath = join(dbPath, "note_db.db");
    await deleteDatabase(fullPath);
  }

  // to get  data from database
  Future<List<Map>> read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  // to insert  data into database
  Future<int> insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  // to update  data in database
  Future<int> update(
      String table, Map<String, Object?> values, String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: myWhere);
    return response;
  }

  // to delete  data from database
  Future<int> delete(String table, String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: myWhere);
    return response;
  }
}

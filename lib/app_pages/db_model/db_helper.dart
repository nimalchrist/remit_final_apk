import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'table_timer.dart';

class db_helper {
  static Database _db = null;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "table_timer.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
      "CREATE TABLE limitTimer(appName TEXT PRIMARY KEY, limitTime INTEGER)",
    );
    print("Table Created");
  }

  void insertLimit(limitTimer limit_time) async {
    var db_client = await db;
    print("Inserted");
    await db_client.transaction((txn) async {
      return await txn.rawInsert(
          "INSERT INTO limitTimer(appName, limitTime) VALUES('${limit_time.appName}', ${limit_time.limitTime})");
    });
  }

  void updateLimit(limitTimer limit_time) async {
    print("Updated");
    var db_client = await db;
    await db_client.rawUpdate(
        "UPDATE limitTimer SET limitTime = ${limit_time.limitTime} WHERE appName = '${limit_time.appName}'");
  }

  Future<List<limitTimer>> getLimit() async {
    var db_client = await db;
    List<Map> fetchedApps =
        await db_client.rawQuery("SELECT * FROM limitTimer");
    List<limitTimer> limitApps = [];
    for (var i = 0; i < fetchedApps.length; i++) {
      limitApps.add(
          limitTimer(fetchedApps[i]["appName"], fetchedApps[i]["limitTime"]));
    }
    print(limitApps.length);
    return limitApps;
  }

  void deleteDB() async {
    var db_client = await db;
    await db_client.rawDelete("DELETE TABLE limitTimer");
  }
}

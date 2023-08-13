import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:tugasakhirmobile/models/catatan_model.dart';

class DBHelper {
  DBHelper();
  Database? _database;

  DBHelper.createObject();

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "catatan.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE catatan_harian ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "date TEXT"
          ")");
    });
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<int?> addData(CatatanHarian newClient) async {
    final db = await database;
    var table =
        await db?.rawQuery("SELECT MAX(id)+1 as id FROM catatan_harian");
    Object? id = table?.first["id"];
    var raw = await db?.rawInsert(
        "INSERT Into catatan_harian(id,title,description,date)"
        " VALUES (?,?,?,?)",
        [
          id,
          newClient.title,
          newClient.description,
          newClient.date,
        ]);
    return raw;
  }

  Future<int?> insert(CatatanHarian object) async {
    Database? db = await database;
    int? count = await db?.update("catatan_harian", object.toJson(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int?> delete(int id) async {
    Database? db = await database;
    int? count =
        await db?.delete("catatan_harian", where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<CatatanHarian>> getAllProduct() async {
    final db = await database;
    var res = await db?.query("catatan_harian");
    List<CatatanHarian> list = res!.isNotEmpty
        ? res.map((e) => CatatanHarian.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<int?> deleteDB() async {
    Database? db = await database;
    var del = await db!.delete("catatan_harian");
    return del;
  }
}

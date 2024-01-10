import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tugasakhirmobile/models/catatan_model.dart';

class DBHelper {
  DBHelper();
  Database? _database;

  DBHelper.createObject();

  initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "catatan.db");
    return await openDatabase(path, version: 1, onOpen: (final db) {},
        onCreate: (final Database db, final int version) async {
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

  Future<int?> addData(final CatatanHarian newClient) async {
    final db = await database;
    final table =
        await db?.rawQuery("SELECT MAX(id)+1 as id FROM catatan_harian");
    final id = table?.first["id"];
    final raw = await db?.rawInsert(
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

  Future<int?> insert(final CatatanHarian object) async {
    final db = await database;
    final count = await db?.update("catatan_harian", object.toJson(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int?> delete(final int id) async {
    final db = await database;
    final count =
        await db?.delete("catatan_harian", where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<CatatanHarian>> getAllProduct() async {
    final db = await database;
    final res = await db?.query("catatan_harian");
    // ignore: prefer_final_locals
    List<CatatanHarian> list = res!.isNotEmpty
        ? res.map((final e) => CatatanHarian.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<int?> deleteDB() async {
    final db = await database;
    final del = await db!.delete("catatan_harian");
    return del;
  }
}

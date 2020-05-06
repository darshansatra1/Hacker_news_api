import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/repositories.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  Future<List<int>> fetchTopIds() {
    return null;
  }

  void init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'items1.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
          CREATE TABLE Items(
            id INTEGER PRIMARY KEY,
            deleted INTEGER,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            dead INTEGER,
            parent INTEGER,
            kids BLOB,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER 
          );
          """);
    });
  }

  Future<int> addItem(ItemModel item) {
    return db.insert("Items", item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<ItemModel> fetchItem(int id) async {
    final item = await db
        .query("Items", columns: null, where: "id = ?", whereArgs: [id]);
    if (item.length > 0) {
      return ItemModel.fromDb(item.first);
    }
    return null;
  }

  Future<int> clear() {
    return db.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();

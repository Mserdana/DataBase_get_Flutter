import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static final DbProvider _dbProvider = DbProvider._();
   late Database _database;

  factory DbProvider() {
    return _dbProvider;
  }

  DbProvider._();


  Database get getDatabase => _database;


  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'app_database.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database db){},
      onCreate: (Database db , int version) async{
        await db.execute('CREATE TABLE category ('
            'id INTEGER  PRIMARY KEY AUTOINCREMENT, '
            'name TEXT '
            ')');
        await db.execute('CREATE TABLE notes ('
            'id INTEGER  PRIMARY KEY AUTOINCREMENT , '
            'name TEXT '
            'info TEXT'
            'done NUMERIC'
            'category_id INTEGER'
            ')');
      },
      onUpgrade: (Database db , int oldVersion , int newVersion){},
      onDowngrade: (Database db , int oldVersion , int newVersion){}
    );
  }
}

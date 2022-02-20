import 'package:data_base/Database/db_operation.dart';
import 'package:data_base/Database/db_provider.dart';
import 'package:data_base/models/Category.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDbController extends DbOperation<Category> {
  Database _database = DbProvider().getDatabase;
  String tabelName = "category";
  @override
  Future<int> create(Category object) async {
    //INSERT INTO categories (name) VALUE ('New Name)
    return await _database.insert(tabelName, object.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    // DELETE * category
    int countOfDeletedRows = await _database.delete(tabelName, where: 'id=? ', whereArgs: [id]);
    return countOfDeletedRows > 0;
  }

  @override
  Future<List<Category>> read() async {
    // SELECT * FROM category
    List<Map<String , dynamic>> rows = await _database.query('category');
    if(rows.isNotEmpty){
      return rows.map((rowMap) => Category.fromMap(rowMap)).toList();
    }
    return[];
  }

  @override
  Future<Category?> show(int id) async{
    // Select * from category where id = 2
    List<Map<String , dynamic>> rows = await _database.query(tabelName , where: 'id = ?' , whereArgs: [id]);
    if(rows.isNotEmpty){
      return rows.map((row) => Category.fromMap(row)).first;
    }
    return null;
  }

  @override
  Future<bool> update(Category object)async {
    // Update category Set name = 'name' where id = 2
    int countOfUpdatedRows = await _database.update(tabelName, object.toMap(), where: 'id=?' , whereArgs: [object.id]);
    return countOfUpdatedRows > 0 ;
  }
}

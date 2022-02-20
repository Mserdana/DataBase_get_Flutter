import 'package:flutter/foundation.dart';

class Category {
  late int id ;
  late String name;


  Category();



  Category.fromMap(Map<String , dynamic> rowMap){
      id = rowMap['id'];
      name = rowMap['name'];
  }

  Map<String ,dynamic> toMap(){
    Map<String,dynamic> map = Map<String,dynamic>();
    map['name'] = name;
    return map;
  }
}
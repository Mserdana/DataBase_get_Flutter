

import 'package:data_base/Controlers/category_db_controller.dart';
import 'package:data_base/models/Category.dart';
import 'package:get/get.dart';

class CategoryGetxController extends GetxController{

  RxList<Category> categoryList = <Category>[].obs;
  CategoryDbController _categoryDbController = CategoryDbController();

  static CategoryGetxController get to => Get.find();
  @override
  void onInit() {
    read();
    super.onInit();
  }

  Future<bool> create  ({required Category category}) async{
    int id =  await _categoryDbController.create(category);
    if(id != 0){
      category.id = id;
      categoryList.add(category);
      update();
      return true;
    }
    return false;
  }

  Future<void> read () async{
    categoryList.value =  await _categoryDbController.read();
   }

  Future<bool> updateCategory (Category category) async{
    bool isUpdated = await _categoryDbController.update(category);
    if(isUpdated){
      int index  = categoryList.indexWhere((element) => element.id == category.id);
      if(index != -1){
        categoryList[index] = category;
         return true;
      }
    }
    return false;
  }

  Future<bool> delete ({required  int id }) async{
    bool isDeleted = await _categoryDbController.delete(id);
    if(isDeleted){
      int index = categoryList.indexWhere((element) => element.id == id);
      if(index != -1){
        categoryList.removeAt(index);
        return true;
      }
    }
    return false;
  }
  
}
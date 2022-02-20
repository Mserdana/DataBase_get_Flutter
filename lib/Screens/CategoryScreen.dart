import 'package:data_base/GetxControllers/category_getx_controller.dart';
 import 'package:data_base/Screens/add_category.dart';
import 'package:data_base/Screens/updated_category_screen.dart';
import 'package:data_base/utlis/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with Helper {

  final CategoryGetxController controller = Get.put(CategoryGetxController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCategoryScreen(),
                  ),
                );
              },
              icon: Icon(Icons.add))
        ],

      ),
      body: Obx((){
        if (controller.categoryList.isNotEmpty) {
          return ListView.builder(
              itemCount: controller.categoryList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateCategoryScreen(
                          category: controller.categoryList[index],
                        ),
                      ),
                    );
                  },
                  leading: Icon(Icons.category),
                  title: Text(controller.categoryList[index].name),
                  subtitle:
                  Text(controller.categoryList[index].id.toString()),
                  trailing: IconButton(
                    onPressed: () async {
                      await deleted(context, controller.categoryList[index].id);
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.redAccent,
                  ),
                );
              });
        }else{
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  size: 80,
                  color: Colors.grey.shade500,
                ),
                Text(
                  'NO DATA',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 24),
                )
              ],
            ),
          );
        }
      }),
     );
  }

  Future<void> deleted(BuildContext context, int id) async {
     bool isDelated = await CategoryGetxController.to.delete(id: id);
    String message =  isDelated ? "Category Delated Successfully" : "Category Delated Failed";
    showSnackBar(context: context, content: message, error: !isDelated);
  }
}


/*
body: GetX<CategoryGetxController>(
        init: CategoryGetxController(),
        builder:  (CategoryGetxController controller){
          if (controller.categoryList.isNotEmpty) {
            return ListView.builder(
                itemCount: controller.categoryList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateCategoryScreen(
                            category: controller.categoryList[index],
                          ),
                        ),
                      );
                    },
                    leading: Icon(Icons.category),
                    title: Text(controller.categoryList[index].name),
                    subtitle:
                    Text(controller.categoryList[index].id.toString()),
                    trailing: IconButton(
                      onPressed: () async {
                        await deleted(context, controller.categoryList[index].id);
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.redAccent,
                    ),
                  );
                });
          }else{
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning,
                    size: 80,
                    color: Colors.grey.shade500,
                  ),
                  Text(
                    'NO DATA',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 24),
                  )
                ],
              ),
            );
          }
        },
      )
 */
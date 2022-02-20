import 'package:data_base/GetxControllers/category_getx_controller.dart';
 import 'package:data_base/models/Category.dart';
import 'package:data_base/utlis/helper.dart';
import 'package:flutter/material.dart';

class AddCategoryScreen extends StatefulWidget{
  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> with Helper {
  late TextEditingController _textEditingController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController =TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async{
                await save();
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50)),
            )
          ],
        ),
      ),
    );
  }


  Future<void> performSave() async{
    if(checkData()){
      await save();
    }
  }

  bool checkData(){
    if(_textEditingController.text.isNotEmpty){
      return true;
    }
      showSnackBar(context: context, content: 'Enter Required Data' , error: true);
    return false;
  }

  Future<void> save() async{
    bool status = await CategoryGetxController.to.create(category: category);
    if(status){
      showSnackBar(context: context, content: 'Category Created Successfully' , error: false);
      clear();
     }else{
      showSnackBar(context: context, content: 'Category Created Failed' , error: true);

    }
  }

  void clear(){
    _textEditingController.text = ' ';

  }

  Category get category{
    Category category = Category();
    category.name = _textEditingController.text;
    return category;
  }
}

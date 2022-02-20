import 'package:data_base/GetxControllers/category_getx_controller.dart';
 import 'package:data_base/models/Category.dart';
import 'package:data_base/utlis/helper.dart';
import 'package:flutter/material.dart';

class UpdateCategoryScreen extends StatefulWidget{
  final Category category;
  UpdateCategoryScreen({required this.category});

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();

}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> with Helper {


  late TextEditingController _textEditingController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController(text:  widget.category.name);
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
        title: Text('Update Category'),
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
                await update();
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


  Future<void> performUpdate() async{
    if(checkData()){
      await update();
    }
  }

  bool checkData(){
    if(_textEditingController.text.isNotEmpty){
      return true;
    }
    showSnackBar(context: context, content: 'Enter Required Data' , error: true);
    return false;
  }

  Future<void> update() async{
    bool status = await CategoryGetxController.to.updateCategory(category);
    if(status){
      showSnackBar(context: context, content: 'Category Updated Successfully' , error: false);
      Navigator.pop(context);
     }else{
      showSnackBar(context: context, content: 'Category Updated Failed' , error: true);

    }
  }



  Category get category{
    Category category = Category();
    category.id = widget.category.id;
    category.name = _textEditingController.text;
    return category;
  }
}

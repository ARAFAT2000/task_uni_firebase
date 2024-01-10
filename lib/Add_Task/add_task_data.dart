import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_uni_firebase/Add_Task/show_task_screen.dart';
import 'package:task_uni_firebase/Widget/raised_button.dart';

class AddtaskData extends StatefulWidget {
  const AddtaskData({super.key});

  @override
  State<AddtaskData> createState() => _AddtaskDataState();
}

class _AddtaskDataState extends State<AddtaskData> {


  final titleController= TextEditingController();
  final descController =TextEditingController();
  final _key=GlobalKey<FormState>();

  final ref= FirebaseFirestore.instance.collection('Teacher');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Column(
          children: [
             SizedBox(
               height: 25,
             ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                       decoration: InputDecoration(
                         hintText: 'Title',
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10)
                         )
                       ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: descController,
                        maxLines: 6,
                        decoration: InputDecoration(
                            hintText: 'Descritions',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Desciption';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                          title: 'Submit', onTap: (){
                        Submit();
                      })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void Submit(){
    if(_key.currentState!.validate()){
      var id=DateTime.now().toString();
       ref.doc(id).set({
         'Title':titleController.text.toString(),
         'Description':descController.text.toString(),
         'Id':id,
       }).then((value) {
          Get.snackbar('Thanks','You create a new task');
       }).onError((error, stackTrace) {
         Text(error.toString());
       });
       Get.to(ShowTaskScreen());
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}


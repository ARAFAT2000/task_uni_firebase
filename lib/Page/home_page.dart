

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_uni_firebase/Add_Task/show_task_screen.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:task_uni_firebase/Utils/flutter_toast_messege.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  firebase_storage.FirebaseStorage storage =  firebase_storage.FirebaseStorage.instance;
 DatabaseReference databaseReference=FirebaseDatabase.instance.ref('Post');
 bool isloading= false;
//dart.io sese a import krle error remove hbe
  File ? images;
  final ImagePicker picker = ImagePicker();
  Future<void> GetImages()async{
    final picfiled =await picker.pickImage(source: ImageSource.gallery,imageQuality: 40);
    setState(() {
      if(picfiled !=  null){
        images= File(picfiled.path);
      }else{
        print('No Images');
      }
    });
  }
 
 String first='';
 String last='';

  GetData()async{
    SharedPreferences sp= await SharedPreferences.getInstance();
   setState(() {
     first=sp.getString('First').toString();
    last= sp.getString('Last').toString();
   });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body:SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                  child: Container(
                    width: double.infinity,
                    color: Colors.deepPurple,
                child:Column(
                  children: [
                    ProfileCard(context)
                 
                  ],
                ) ,
              )),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(

                            children: [

                              InkWell(
                                onTap:(){
                                  Get.to(ShowTaskScreen());
                                },
                                child: Container(
                                  height: 120,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                   // color: Colors.black
                                  ),
                                    child: Card(
                                        elevation: 5,
                                        child: Center(child: Text('Note')))),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap:(){},
                                child: Container(
                                    height: 120,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Colors.black
                                    ),
                                    child: Card(
                                        elevation: 5,
                                        child: Center(child: Text('Notice Board')))),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap:(){},
                                child: Container(
                                    height: 120,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                       // color: Colors.black
                                    ),
                                    child: Card(
                                        elevation: 5,
                                        child: Center(child: Text('Tuition')))),
                              ),

                            ],
                          ),
                        ],
                      ),
                    )
                  )),
            ],)),
    );
  }

  Container ProfileCard(BuildContext context) {
    return Container(
      height: 90,
      child: Card(
               child: ListTile(
                 title: Padding(
                   padding: const EdgeInsets.only(left: 20),
                   child: InkWell(
                       onTap: (){
                         UploadFile();
                       },
                       child: Text(first.toString(),style: TextStyle(fontSize: 20,color: Colors.deepPurple),)),
                 ),
                 subtitle: Padding(
                   padding: const EdgeInsets.only(left: 20),
                   child: Text(last.toString()),
                 ),
                trailing: SizedBox(
                  height: 80,
                  width: 80,
                  child: InkWell(
                    onTap: (){
                      GetImages();
                    },
                   child: Center(
                     child: images==null?Text('Take Picture'):
                   ClipOval(
                     child: Image.file(
                       height: 60,
                         images!.absolute),
                   )
                   ),

                  ),
                ),
               ),
             ),
    );
  }
  Future<void> UploadFile()async{
    firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/filename'+
        DateTime.now().millisecond.toString());
    firebase_storage.UploadTask uploadTask=ref.putFile(images!.absolute);

 Future.value(uploadTask).then((value) {
   var newUrl=ref.getDownloadURL();
   databaseReference.child('1').set({
     'id':'2345',
     'title':newUrl.toString()
   }).then((value) {
     setState(() {
       isloading=false;
     });
     Utils().toastmessege('Upload');
   }).onError((error, stackTrace) {
     setState(() {
       isloading=false;
     });
   });
 }).onError((error, stackTrace){
   Utils().toastmessege(error.toString());
   setState(() {
     isloading=false;
   });
 });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_uni_firebase/Auth/sign_up_screen.dart';
import 'package:task_uni_firebase/Page/home_page.dart';
import 'package:task_uni_firebase/Utils/flutter_toast_messege.dart';

import '../Style_Button/style.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  final emailController= TextEditingController();
  final passwordController= TextEditingController();
  final _formKey= GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('LogIn ',style: TextStyle(color: Colors.deepPurple,
                      fontSize: 25,fontWeight: FontWeight.bold),),

                  SizedBox(height: 20,),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Email';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: TextFormfieldDesign('Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 13,),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: TextFormfieldDesign('password'),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 13,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     SizedBox(
                       child: Text(''),
                     ),
                     InkWell(
                       onTap: (){
                         if(_formKey.currentState!.validate()){
                           LogIn();
                         }
                       },
                       child: SizedBox(
                         child: Container(
                           height: 50,
                             width: 100,
                             decoration: BoxDecoration(
                               color: Colors.deepPurple,
                               borderRadius: BorderRadius.circular(20)
                             ),
                             child: Center(child: Text('LogIn',style: TextStyle(
                               color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16
                             ),))),
                       ),
                     )
                   ],
                 ),
                  SizedBox(height: 60,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(' Dont have an account ?'),
                      TextButton(onPressed: (){
                        Get.to(Sign_upScreen());
                      }, child: Text('SignUp'))
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
  void LogIn(){

    _firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim().toString(),
        password: passwordController.text.toString()).
        then((value) {
       Get.to(HomePage());
    }).
    onError((error, stackTrace) {
      Utils().toastmessege('Please Check correct Email and Password');
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

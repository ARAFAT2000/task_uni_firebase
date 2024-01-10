import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_uni_firebase/Auth/login_Screen.dart';
import 'package:task_uni_firebase/Utils/flutter_toast_messege.dart';

import '../Style_Button/style.dart';

class Sign_upScreen extends StatefulWidget {
  const Sign_upScreen({super.key});

  @override
  State<Sign_upScreen> createState() => _Sign_upScreenState();
}

class _Sign_upScreenState extends State<Sign_upScreen> {
  final firstnameController= TextEditingController();
  final lastnameController= TextEditingController();
  final emailController= TextEditingController();
  final phonenumberController= TextEditingController();
  final passwordController= TextEditingController();
  final _formKey= GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,top: 35),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Create Account',
                          style: TextStyle(color: Colors.deepPurple,
                            fontSize: 25,fontWeight: FontWeight.bold),),
                        Text('',),
        
                      ],
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter First Name';
                        }
                        return null;
                      },
                      controller: firstnameController,
                      decoration: TextFormfieldDesign('First Name'),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 13,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Last Name';
                        }
                        return null;
                      },
                      controller: lastnameController,
                      decoration: TextFormfieldDesign('Last Name'),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 13,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Valid Email';
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
                          return 'Enter Active Number';
                        }
                        return null;
                      },
                      controller: phonenumberController,
                      decoration: TextFormfieldDesign('Phone Number'),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 13,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Strong password with 6 digit';
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
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              SharedPreferences sp= await SharedPreferences.getInstance();
                              sp.setString('First', firstnameController.text);
                              sp.setString('Last', lastnameController.text);
                              _firebaseAuth.createUserWithEmailAndPassword(
                                  email: emailController.text.trim().toString(),
                                  password: passwordController.text.trim().toString()).
                              then((value) {

                              }).
                              onError((error, stackTrace) {
                                Utils().toastmessege(error.toString());
                              });
                              Get.snackbar('Hi', 'Succesfully create your account');
                              Get.to(LogInScreen());
                            };

                          },
                          child: SizedBox(
                            child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text('SignUp',style: TextStyle(
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
                        Text('Already have an account !'),
                        TextButton(onPressed: (){
                          Get.to(LogInScreen());
                        }, child: Text('LogIn'))
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phonenumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

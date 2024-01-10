import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_uni_firebase/Page/home_page.dart';

import '../Auth/login_Screen.dart';

class SplassServices{
  void isLogIn(BuildContext context){
    final _auth= FirebaseAuth.instance;
    final user=_auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 3), () {
       Get.to(HomePage());
      });
    }else{
      Timer(Duration(seconds: 3), () {
        Get.to(LogInScreen());
      });
    }

  }
}
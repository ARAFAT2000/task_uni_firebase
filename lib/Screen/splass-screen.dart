import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_uni_firebase/Services/all_services.dart';

import '../Auth/login_Screen.dart';


class SplassScreen extends StatefulWidget {
  const SplassScreen({super.key});

  @override
  State<SplassScreen> createState() => _SplassScreenState();
}

class _SplassScreenState extends State<SplassScreen> {
  SplassServices _splassServices= SplassServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splassServices.isLogIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: Center(
             child: Text('TODO  APPLICATION',style: TextStyle(
               color: Colors.black,fontSize: 20
             ),),
           ),
    );
  }
}

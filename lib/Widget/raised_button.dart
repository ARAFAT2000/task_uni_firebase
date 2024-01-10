import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class RaisedButton extends StatelessWidget {
  String title;
  final VoidCallback onTap;
  final isLoading;
  RaisedButton({super.key,required this.title,this.isLoading=false,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: onTap,
      child: Container(
        height: 40,

        decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: isLoading? CircularProgressIndicator(strokeWidth: 2,color: Colors.white,):
          Text(title,style: TextStyle(
              color: Colors.white
          ),),
        ),
      ),

    );
  }
}

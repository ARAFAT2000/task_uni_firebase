import 'package:flutter/material.dart';

InputDecoration TextFormfieldDesign(label) {
  return InputDecoration(
    hintText: label,

    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20)
    ),

  );
}
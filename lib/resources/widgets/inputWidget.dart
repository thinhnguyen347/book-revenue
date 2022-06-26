import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget inputTextWidget({required controller, required hintText}) {
  return Container(
      padding: const EdgeInsets.only(right: 16),
      child: TextField(
        obscureText: false,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        controller: controller,
      ));
}

Widget inputNumberWidget({required controller, required hintText}) {
  return Container(
      padding: const EdgeInsets.only(right: 16),
      child: TextField(
        obscureText: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        controller: controller,
      ));
}

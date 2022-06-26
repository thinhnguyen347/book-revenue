import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget inputWidget({required String labelText, required controller, required hintText}) {
  return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        obscureText: false,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
        controller: controller,
      ));
}
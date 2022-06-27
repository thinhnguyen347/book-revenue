import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget inputTextWidget({required controller, required hintText}) {
  return Container(
      padding: const EdgeInsets.only(right: 16),
      child: TextField(
        obscureText: false,
        autofocus: true,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        controller: controller,
        keyboardType: TextInputType.number,
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
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ));
}

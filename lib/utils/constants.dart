import 'package:flutter/material.dart';
import 'package:plane_startup/utils/const.dart';

const primaryColor = Color.fromRGBO(63, 118, 255, 1);
const primaryLightColor = Color.fromRGBO(63, 118, 255, 0.1);
const greyColor = Color.fromRGBO(136, 136, 136, 1);
const lightGreeyColor = Color.fromRGBO(238, 238, 238, 1);

InputDecoration kTextFieldDecoration = InputDecoration(
  labelText: '',
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 253, 17, 0)),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  border: const OutlineInputBorder(
    borderSide: BorderSide(color: greyColor),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

const LinearGradient gradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    Color.fromRGBO(107, 174, 250, 1),
    Color.fromRGBO(244, 247, 251, 1),
    Colors.white
  ],
);

double height = MediaQuery.of(Const.globalKey.currentContext!).size.height;

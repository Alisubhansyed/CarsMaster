import 'package:flutter/material.dart';

const InputDecoration? emaildecoration = InputDecoration(
  focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  focusColor: Colors.white,
  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
  labelStyle: TextStyle(fontSize: 23, color: Colors.white),
  floatingLabelStyle: TextStyle(fontSize: 25, color: Colors.white),
  labelText: "Email Address",
  fillColor: Colors.white,
  // isDense: true,
);
const InputDecoration? passworddecoration = InputDecoration(
  focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  focusColor: Colors.white,
  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
  labelStyle: TextStyle(fontSize: 23, color: Colors.white),
  floatingLabelStyle: TextStyle(fontSize: 25, color: Colors.white),
  labelText: "passward",
  // isDense: true,
);

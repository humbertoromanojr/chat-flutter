import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
    theme: ThemeData(
      primaryColor: Color(0xff0026ca),
      accentColor: Color(0xff304ffe)
    ),
    debugShowCheckedModeBanner: false,
  ));
}




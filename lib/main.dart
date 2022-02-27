
import 'package:chatapp/screens/chats.dart';
import 'package:chatapp/screens/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString("Email");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email == null?LoginPage():Chat(),
  )) ;
}





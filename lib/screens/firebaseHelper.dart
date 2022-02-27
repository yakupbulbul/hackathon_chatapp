import 'package:chatapp/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatspage.dart';
import 'dasboard.dart';

class Service{
  final auth =FirebaseAuth.instance;
  void createUser(context, email, password)async{
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) =>
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboards()))
          });
    } catch(e){
      errorBox(context, e);
    }

  }
  void loginUser(context, email, password) async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value) =>
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboards()))
      });
    }
    catch(e){
      errorBox(context, e);
    }
  }
  void signOut(context) async {
    try{
      await auth.signOut().then((value) => {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginPage()), (route) => false)
      });

    } catch(e){}
  }
  void errorBox(context, e){
    showDialog(context: context, builder: (context)
    {
      return AlertDialog(
        title: Text("Error"),
        content: Text(e.toString()),
      );
    });


  }
  

}
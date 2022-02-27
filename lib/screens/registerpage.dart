import 'package:chatapp/screens/firebaseHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';

class RegisterPage extends StatelessWidget {
  final storeUsers = FirebaseFirestore.instance;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordsController=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController lastname=TextEditingController();


  Service service =Service();


  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
        autofocus: false,
        controller: name,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          name.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: lastname,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          lastname.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordsController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordsController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));


    //signup button

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all( 36),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SizedBox(
                    height: 180,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    )),
               
                SizedBox(height: 45),
                firstNameField,
                SizedBox(height: 20),
                secondNameField,
                SizedBox(height: 20),
                emailField,
                SizedBox(height: 20),
                passwordField,

                ElevatedButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 80)
                    ),
                    onPressed: (){
                      if(emailController.text.isNotEmpty&& passwordsController.text.isNotEmpty&& name.text.isNotEmpty&&lastname.text.isNotEmpty){

                         storeUsers.collection("Users").doc(emailController.text).set({
                          "email": emailController.text,
                           "name":name.text,
                           "lastname":lastname.text
                         });
                         service.createUser(context, emailController.text, passwordsController.text);

                      }else{
                        service.errorBox(context, "Fields must not empthy");
                      }


                    },
                    child: Text("Register")),



                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage(),),);
                }, child: Text("I already have an account"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

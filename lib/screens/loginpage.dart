import 'package:chatapp/screens/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screens/firebaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatelessWidget {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordsController=TextEditingController();
  Service service =Service();

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 180,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    )),
                SizedBox(height: 20),
                emailField,
                SizedBox(height: 20),
                passwordField,
                ElevatedButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 80)
                    ),
                    onPressed: () async {
                      SharedPreferences pref = await SharedPreferences.getInstance();

                      if(emailController.text.isNotEmpty&& passwordsController.text.isNotEmpty){
                        service.loginUser(context, emailController.text, passwordsController.text);
                        pref.setString("email", emailController.text);

                      }else{
                        service.errorBox(context, "Fields must not empthy");
                      }
                    },
                    child: Text("Login")),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterPage()));
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ]),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

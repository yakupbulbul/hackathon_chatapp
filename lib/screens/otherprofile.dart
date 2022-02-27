import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class OtherProfile extends StatefulWidget {
  final String email;

  OtherProfile(this.email);

  @override
  State<OtherProfile> createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  final storePosts = FirebaseFirestore.instance;

  final auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.email)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://www.pngitem.com/pimgs/m/272-2720607_this-icon-for-gender-neutral-user-circle-hd.png'),
              ),
              SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${loggedInUser.firstName}",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "${loggedInUser.secondName}",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  //SizedBox(width: 25),

                  //IconButton(onPressed: () {}, icon: Icon(Icons.send))
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Posts").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      //reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      primary: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, i) {
                        QueryDocumentSnapshot x = snapshot.data!.docs[i];

                        if (x["email"] == widget.email) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Image.network(
                                "https://ps.w.org/simple-user-avatar/assets/icon-256x256.png?rev=2413146",
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text("${x["name"]} ${x["lastname"]}"),
                            subtitle: Text(x['post']),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      });
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}

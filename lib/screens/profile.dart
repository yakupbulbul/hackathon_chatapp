import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        .doc(loginUser!.email.toString())
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  String texts = "";
  TextEditingController textEditingController = TextEditingController();

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
              const CircleAvatar(
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
                    style: const TextStyle(
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
                    return const Center(
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

                        if (x["email"] == loginUser!.email.toString()) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Enter Your Experience'),
            content: TextField(
              maxLines: 3,
              onChanged: (value) {},
              controller: textEditingController,
              decoration: const InputDecoration(
                  hintText: "Text Field in Dialog",
                  border: OutlineInputBorder()),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 80)),
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty) {
                      storePosts
                          .collection("Posts")
                          .doc(loggedInUser.email.toString())
                          .set({
                        "email": loggedInUser.email.toString(),
                        "name": loggedInUser.firstName.toString(),
                        "lastname": loggedInUser.secondName.toString(),
                        "post": textEditingController.text,
                      });
                    }
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("OK")),
            ],
          ),
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.post_add),
      ),
    );
  }
}

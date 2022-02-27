import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chatspage.dart';

class Chat extends StatefulWidget {

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8,16,8,12),
        child: Column(

          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
              FirebaseFirestore.instance.collection("Users").snapshots(),
              builder: (context, snapshot)
              {
                if(!snapshot.hasData){
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
                    itemBuilder: (context, i){
                      QueryDocumentSnapshot x =snapshot.data!.docs[i];
                      return ListTile(
                        leading: FloatingActionButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(x["name"],x["email"],x["lastname"], ),),);
                            //print(x["email"]+"yakup");

                          },
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://www.pngitem.com/pimgs/m/272-2720607_this-icon-for-gender-neutral-user-circle-hd.png'),
                          ),
                        ),
                        title: Text("${x["name"]} ${x["lastname"]}"),

                      );
                    }
                );

              },



            ),
          ],
        ),
      ),
    );
  }
}

import 'package:chatapp/screens/otherprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Postlar extends StatelessWidget {
  const Postlar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,16,8,12),
      child: SafeArea(
        child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance.collection("Posts").snapshots(),
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
                        return Container(
                          decoration: BoxDecoration( //                    <-- BoxDecoration
                            border: Border(bottom: BorderSide(
                                 color: Colors.lightBlueAccent,
                              width: 0.1 ,
                              //style: BorderStyle.solid,

                            )),
                          ),
                          child: ListTile(
                            leading: FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OtherProfile(x['email']),),);
                                },
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      'https://www.pngitem.com/pimgs/m/272-2720607_this-icon-for-gender-neutral-user-circle-hd.png'),
                                ),
                            ),
                            title: Text("${x["name"]} ${x["lastname"]}"),
                            subtitle: Text(x['post']),

                          ),
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

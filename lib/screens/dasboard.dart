import 'package:chatapp/screens/postlar.dart';
import 'package:chatapp/screens/profile.dart';
import 'package:flutter/material.dart';

import 'chats.dart';

class Dashboards extends StatefulWidget {
  const Dashboards({Key? key}) : super(key: key);

  @override
  _DashboardsState createState() => _DashboardsState();
}

class _DashboardsState extends State<Dashboards> {
  int selectedIndex = 0;

  //list of widgets to call ontap
  final widgetOptions = [
    new Postlar(),
    new Chat(),
    new Profile(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final widgetTitle = ["Posts", "Chats", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.lightBlueAccent,
        //type: BottomNavigationBarType.fixed,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              label: "Posts"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_outlined,
                color: Colors.blue,
              ),
              label: "Chats"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.blue,
              ),
              label: "Profile"),
        ],
        currentIndex: selectedIndex,

        fixedColor: Colors.lightGreenAccent,
        onTap: onItemTapped,
        selectedLabelStyle: TextStyle(color: Colors.red, fontSize: 20),
        unselectedFontSize: 16,
        selectedIconTheme:

        IconThemeData(color: Colors.redAccent, opacity: 1.0, size: 30.0),
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(fontSize: 18, color: Colors.pink),
      ),
    );
  }
}
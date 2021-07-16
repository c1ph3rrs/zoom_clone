import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom/screens/profileScreen.dart';
import 'package:zoom/screens/variables.dart';
import 'package:zoom/screens/videoConference.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int page =0;
  List pageOptions = [
    VideoConference(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[250],
        selectedItemColor: Colors.blue,
        selectedLabelStyle: myStyle(17, Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: myStyle(17, Colors.blue),
        currentIndex: page,
        onTap: (index){
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Video Call"),
              icon: Icon(Icons.video_call, size: 32),
          ),
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(Icons.person, size: 32),
          ),
        ],
      ),
      body: pageOptions[page],
    );
  }
}

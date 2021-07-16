import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:zoom/screens/variables.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController usernameTextController = TextEditingController();

  String username = '';
  bool dataIsThere = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userDoc = await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username = userDoc.get('username');
      dataIsThere = true;
    });
  }

  editProfile() async{
    userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'username': usernameTextController.text
    });

    setState(() {
      username = usernameTextController.text;
    });

    Navigator.pop(context);
  }

  openEditProfileDialog() async {
    return showDialog(
      context: context,
      builder: (context){
        return Dialog(
          child: Container(
            height: 200,
            child: Column(
              children: [
                SizedBox(height: 30.0,),
                Container(
                  margin: EdgeInsets.only(left:30, right: 30),
                  child: TextField(
                    controller: usernameTextController,
                    style: myStyle(18, Colors.black),
                    decoration: InputDecoration(
                      labelText: "Update Username",
                      labelStyle: myStyle(16, Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height:40),
                InkWell(
                  onTap: ()=> editProfile(),
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.cyanAccent),
                    child: Center(
                      child: Text('Update Now!', style: myStyle(17, Colors.white),),

                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: dataIsThere == false ? Center( child: CircularProgressIndicator()) : Stack(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/2.5,
              decoration: BoxDecoration(
                color:Colors.lightBlue,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width/2-64,
              top: MediaQuery.of(context).size.height/3.1
            ),
            child: CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
            )
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 300),
                Text(
                  username,
                  style: myStyle(24, Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height:30),
                InkWell(
                  onTap: ()=> openEditProfileDialog(),
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.cyanAccent),
                    child: Center(
                      child: Text('Edit Profile', style: myStyle(17, Colors.white),),

                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

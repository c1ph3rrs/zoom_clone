import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zoom/screens/variables.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({Key? key}) : super(key: key);

  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {

  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();

  bool isVideoMuted = true;
  bool isAudioMuted = true;
  String username = '';

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
    });
  }

  joinMeeting() async{

    try{

      Map<FeatureFlagEnum, bool> featureFlagEnum = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };

      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlagEnum[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlagEnum[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions(room: roomController.text)

        ..userDisplayName = nameController.text == '' ? username : nameController.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlagEnum);

      await JitsiMeet.joinMeeting(options);

    }catch(e){
      print("Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24,),
              Text("Room Code", style: myStyle(20),),
              SizedBox(height: 20,),
              PinCodeTextField(
                controller: roomController,
                length: 6,
                onChanged: (value){},
                autoDisposeControllers: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline
                ),
                animationDuration: Duration(milliseconds: 300),
                appContext: context,
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name (Leave if you want (username))",
                  labelStyle: myStyle(15)
                )
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                value:isVideoMuted,
                onChanged: (value){
                  setState(() {
                    isVideoMuted = value!;
                  });
                },
                title: Text("Video Muted", style: myStyle(18, Colors.black),),
              ),
              SizedBox(height: 10,),
              CheckboxListTile(
                value:isAudioMuted,
                onChanged: (value){
                  setState(() {
                    isAudioMuted = value!;
                  });
                },
                title: Text("Audio Muted", style: myStyle(18, Colors.black),),
              ),
              SizedBox(height: 20),
              Text("Of course, you can customized setting in the meeting", style: myStyle(15), textAlign: TextAlign.center,),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              InkWell(
                onTap: () => joinMeeting(),
                child: Container(
                  width: double.maxFinite,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                  child: Center(
                    child: Text(
                      "Join Meeting",
                      style: myStyle(
                        20,
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

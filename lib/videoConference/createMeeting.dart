import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zoom/screens/variables.dart';

class CreateMeeting extends StatefulWidget {
  const CreateMeeting({Key? key}) : super(key: key);

  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  String code = '';

  createCode(){
    setState(() {
      code = Uuid().v1().substring(0,6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Create a code and share it",
              style: myStyle(20),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Code: ',
                style: myStyle(30),
              ),
              Text(
                code,
                style: myStyle(30, Colors.purple, FontWeight.w700),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () => createCode(),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Center(
                child: Text(
                  "Create Code",
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zoom/screens/variables.dart';
import 'package:zoom/videoConference/createMeeting.dart';
import 'package:zoom/videoConference/joinMeeting.dart';


class VideoConference extends StatefulWidget {
  const VideoConference({Key? key}) : super(key: key);

  @override
  _VideoConferenceState createState() => _VideoConferenceState();
}

class _VideoConferenceState extends State<VideoConference> with  SingleTickerProviderStateMixin {

  late TabController tabsController;

  buildTab(String name){
    return Container(
      width: 150,
      height: 50,
        child: Card(
          child: Center(
            child: Text(name, style: myStyle(15, Colors.black, FontWeight.w700),
            )
          ),
        ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabsController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text("Zoom", style: myStyle(20, Colors.white, FontWeight.w700),),
        bottom: TabBar(
          controller: tabsController,
          tabs: [
            buildTab("Join Meeting"),
            buildTab("Create Meeting"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabsController,
        children: [
          JoinMeeting(),
          CreateMeeting(),
        ],
      ),
    );
  }
}

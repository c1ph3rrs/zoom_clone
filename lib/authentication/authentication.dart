import 'package:flutter/material.dart';
import 'package:zoom/authentication/loginscreen.dart';
import 'package:zoom/authentication/register.dart';
import 'package:zoom/screens/variables.dart';

class NavigateAuthScreen extends StatefulWidget {
  const NavigateAuthScreen({Key? key}) : super(key: key);

  @override
  _NavigateAuthScreenState createState() => _NavigateAuthScreenState();
}

class _NavigateAuthScreenState extends State<NavigateAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
              // gradient: LinearGradient(colors: GradientColors.blue)
              color: Colors.blueAccent,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.6,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0,3),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder : (context)=> LoginScreen())),
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 60,
                      decoration: BoxDecoration(
                        // gradient: LinearGradient(colors: GradientColors.beautifulGreen),
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "SIGN IN",
                          style: myStyle(30, Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:40),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 60,
                      decoration: BoxDecoration(
                        // gradient: LinearGradient(colors: GradientColors.beautifulGreen),
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "SIGN UP",
                          style: myStyle(30, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

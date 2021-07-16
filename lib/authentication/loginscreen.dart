import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom/main.dart';
import 'package:zoom/screens/variables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailTextEditingController = TextEditingController();
    TextEditingController passwordTextEditingController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
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
              height: MediaQuery.of(context).size.height / 1.6,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
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
                  SizedBox(height: 50),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                        style: myStyle(18, Colors.black),
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            hintStyle:
                                myStyle(20, Colors.green, FontWeight.w700))),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      controller: passwordTextEditingController,
                      style: myStyle(18, Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          hintStyle:
                              myStyle(20, Colors.green, FontWeight.w700)),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      try {
                        int count =0;
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailTextEditingController.text,
                            password: passwordTextEditingController.text).then((auth) {

                          // Navigator.pop(context);
                          // Route route = MaterialPageRoute(builder: (c) => NavigationPage());
                          // Navigator.pushReplacement(context, route);

                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });

                        });

                      // .catchError((onError){
                      // var snackBar = SnackBar(
                      // content: Text(onError.toString(), style: myStyle(20)));
                      // Scaffold.of(context).showSnackBar(snackBar);
                      // }
                      // )

                      } catch (e) {

                        print(e);
                        var snackBar = SnackBar(
                            content: Text(e.toString(), style: myStyle(20)));
                        Scaffold.of(context).showSnackBar(snackBar);

                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      decoration: BoxDecoration(
                        // gradient: LinearGradient(colors: GradientColors.beautifulGreen),
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "SIGN IN",
                          style: myStyle(25, Colors.white),
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


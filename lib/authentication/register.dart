import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom/screens/variables.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController usernameTextEditingController = TextEditingController();

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
              color:Colors.blueAccent,
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
                  SizedBox(height:50),
                  Container(
                    width: MediaQuery.of(context).size.width/1.7,
                    child: TextField(
                        style: myStyle(18, Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailTextEditingController,
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            hintStyle: myStyle(20, Colors.green, FontWeight.w700)
                        )
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.7,
                    child: TextField(
                      style: myStyle(18, Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      controller: passwordTextEditingController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          hintStyle: myStyle(20, Colors.green, FontWeight.w700)
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.7,
                    child: TextField(
                        style: myStyle(18, Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        controller: usernameTextEditingController,
                        decoration: InputDecoration(
                            hintText: "Username",
                            prefixIcon: Icon(Icons.person),
                            hintStyle: myStyle(20, Colors.green, FontWeight.w700)
                        )
                    ),
                  ),
                  SizedBox(height:40),
                  InkWell(
                    onTap: () {

                      try{

                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailTextEditingController.text,
                            password: passwordTextEditingController.text
                        ).then((signedUser) {
                          userCollection.doc(signedUser.user!.uid).set({
                            'username': usernameTextEditingController.text,
                            'password': passwordTextEditingController.text,
                            'email': emailTextEditingController.text,
                            'uid': signedUser.user!.uid,
                          });
                          Navigator.pop(context);
                        });

                      }catch(e){
                        print(e);
                        var snackBar = SnackBar(content: Text(e.toString(), style:myStyle(20)));
                        Scaffold.of(context).showSnackBar(snackBar);
                      }

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 54,
                      decoration: BoxDecoration(
                        // gradient: LinearGradient(colors: GradientColors.beautifulGreen),
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "SIGN UP",
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

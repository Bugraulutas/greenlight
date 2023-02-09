import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectsavinglight/main.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var tfemailForSignIn=TextEditingController();
  var tfpasswordForSignIn=TextEditingController();

  FirebaseAuth auth=FirebaseAuth.instance;

  void SignInEmailAndPassword() async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tfemailForSignIn.text,
          password: tfpasswordForSignIn.text
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AnaEkran()));


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("bu email için kullanıcı yok"),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("hatalı giriş"),
        ));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    var screenInfo=MediaQuery.of(context);
    final double screenHeight=screenInfo.size.height;//yukseklik
    final double screenWidth=screenInfo.size.width;//genislik

    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding:  EdgeInsets.only(top:screenHeight/10),
          child: Column(
            children: [

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Greenlight',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child:  TextField(
                              controller: tfemailForSignIn,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.green,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white30),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Şifre',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child:  TextField(

                              style: TextStyle(color: Colors.white),
                              controller: tfpasswordForSignIn,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                ),

                                hintText: 'Şifre',
                                hintStyle: TextStyle(color: Colors.white30),
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),
                          GestureDetector(
                            onTap: () {
                              SignInEmailAndPassword();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black,
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    ' Giriş yap',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),

                          const SizedBox(height: 20),

                        ],
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

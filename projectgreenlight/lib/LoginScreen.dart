import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projectsavinglight/SignIn.dart';
import 'package:projectsavinglight/main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),

    );
  }

}

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);




  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;


  var tfemail=TextEditingController();
  var tfpassword=TextEditingController();




  LoginEmailAndPassword() async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: tfemail.text,password: tfpassword.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AnaEkran()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("şifre çok kısa"),
        ));

      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("hesap zaten var"),
        ));
      }
    } catch (e) {
      print(e);
    }

  }


  Widget build(BuildContext context) {
  var screenInfo=MediaQuery.of(context);
  final double screenHeight=screenInfo.size.height;//yukseklik
  final double screenWidth=screenInfo.size.width;//genislik

    database.setPersistenceEnabled(true);




    return SafeArea(

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
                              controller: tfemail,
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
                              controller: tfpassword,
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
                              LoginEmailAndPassword();


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
                                    ' Kaydol',
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
                           SizedBox(height: 35),
                           Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                              },
                              child: Text(
                                '- Giriş yap -',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                           SizedBox(height: 20),

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

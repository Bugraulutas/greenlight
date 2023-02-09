import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:projectsavinglight/Cihazlar.dart';
import 'package:projectsavinglight/KayitEkrani.dart';
import 'package:projectsavinglight/LoginScreen.dart';
import 'package:projectsavinglight/lightings.dart';
import 'package:projectsavinglight/settings.dart';
import 'package:projectsavinglight/timer.dart';
import 'analysis.dart';
import 'battery.dart';
import 'details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return AnaEkran();
          }
          return LoginScreen();
        },
      ),
    );

  }
}

class AnaEkran extends StatefulWidget {
  late Cihazlar cihaz;
  final String title="Greenlight";

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {


  FirebaseAuth auth=FirebaseAuth.instance;
  var refCihazlar=FirebaseDatabase.instance.ref().child(FirebaseAuth.instance.currentUser!.uid.toString());

  Map<String,dynamic> switchDurum={};
  var conntected=<bool>[];
  List<bool> deger=[];

  var oooo;



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    refCihazlar.onValue.listen((event) {
      var cihazListesi=<Cihazlar>[];
      var gelenDegerler=event.snapshot.value as dynamic;
      if(gelenDegerler != null ){
        gelenDegerler.forEach((key,nesne){
          var gelenCihaz=Cihazlar.fromJson(key,nesne);

          cihazListesi.add(gelenCihaz);

                if(gelenCihaz.cihaz_calisiyormu==true){

                  switchDurum[gelenCihaz.cihaz_id]=true;
                }


        });
      }
    });


  }






Future<void> guncelle(String cihaz_id,bool cihaz_calisiyormu) async{
  var info=HashMap<String,dynamic>();

  info["cihaz_calisiyormu"]=cihaz_calisiyormu;
  refCihazlar.child(cihaz_id).update(info);
}

      Future<bool> kapat() async{
          await exit(0);
      }

  @override
  Widget build(BuildContext context) {

return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
  IconButton(
    icon: Icon(
      Icons.exit_to_app,
      color: Colors.black,
    ),
    onPressed: () {
      signOut();
      // do something
    },
  )
],
      ),
      body: Column(

        children: [

          Container(
            margin: const EdgeInsets.only(top: 20, left: 30, right: 20),
            alignment: Alignment.topLeft,
            child: const Text('Status', style: TextStyle(color: Colors.black)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black),
                  top: BorderSide(width: 1, color: Colors.black),
                  left: BorderSide(width: 1, color: Colors.black),
                  right: BorderSide(width: 1, color: Colors.black)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: const [
                        Text('8',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                            )),
                        Text('Connected',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      ],
                    ),
                    Column(
                      children:  [
                        Text('2',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                            )),
                        Text('Disconnected',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      ],
                    ),
                    Column(
                      children: const [
                        Text('%55',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                            )),
                        Text('Battery',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ]),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  KayitEkrani()),
                        );
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 29, 29, 29)),
                        child: Column(
                          children: const [
                            Icon(Icons.cast_connected,
                                color: Colors.green, size: 35),
                            Text('Connect',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Lightings()),
                        );
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 29, 29, 29)),
                        child: Column(
                          children: const [
                            Icon(Icons.lightbulb,
                                color: Colors.green, size: 35),
                            SizedBox(height: 7),
                            Text('Lightings',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Battery()),
                        );
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 29, 29, 29)),
                        child: Column(
                          children: const [
                            Icon(Icons.battery_3_bar_sharp,
                                color: Colors.green, size: 35),
                            SizedBox(height: 7),
                            Text('Battery',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    )
                  ])),
          Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Analysis()),
                        );
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 29, 29, 29)),
                        child: Column(
                          children: const [
                            Icon(Icons.add_chart,
                                color: Colors.green, size: 35),
                            SizedBox(height: 7),
                            Text('Analysis',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Details()),
                        );
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 29, 29, 29)),
                        child: Column(
                          children: const [
                            Icon(Icons.info, color: Colors.green, size: 35),
                            SizedBox(height: 7),
                            Text('Details',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Timer()),
                        );
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 29, 29, 29)),
                        child: Column(
                          children: const [
                            Icon(Icons.timer, color: Colors.green, size: 35),
                            SizedBox(height: 7),
                            Text('Timer',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    )
                  ])),
          Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Settings()),
                        );
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 29, 29, 29)),
                        child: Column(
                          children: const [
                            Icon(Icons.app_settings_alt,
                                color: Colors.green, size: 35),
                            SizedBox(height: 7),
                            Text('Settings',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ])),
        ],
      ),
    );
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

  }


}



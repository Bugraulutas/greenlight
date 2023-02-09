import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projectsavinglight/Cihazlar.dart';
import 'package:projectsavinglight/lightings.dart';

class DetayEkran extends StatefulWidget {
  late Cihazlar cihaz;


  DetayEkran({required this.cihaz});

  @override
  State<DetayEkran> createState() => _DetayEkranState();
}

class _DetayEkranState extends State<DetayEkran> {
  FirebaseAuth auth=FirebaseAuth.instance;

  var tfCihazIsim=TextEditingController();
  var tfCihazSeriNo=TextEditingController();

  var refCihazlar=FirebaseDatabase.instance.ref().child(FirebaseAuth.instance.currentUser!.uid.toString());


  Future<void> sil(String cihaz_id) async{
    refCihazlar.child(cihaz_id).remove();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Lightings()));

  }
  Future<void> guncelle(String cihaz_id,String cihaz_isim, String cihaz_serino) async{
    var info=HashMap<String,dynamic>();

    info["cihaz_isim"]=cihaz_isim;
    info["cihaz_serino"]=cihaz_serino;
    refCihazlar.child(cihaz_id).update(info);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Lightings()));

  }
  @override
  void initState() {

    super.initState();
    var c=widget.cihaz;
    tfCihazIsim.text=c.cihaz_isim;
    tfCihazSeriNo.text=c.cihaz_serino;
  }
  @override
  Widget build(BuildContext context) {
    var screenInfo=MediaQuery.of(context);
    final double screenHeight=screenInfo.size.height;//yukseklik
    final double screenWidth=screenInfo.size.width;//genislik

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Greenlight",style: TextStyle(color: Colors.black),),
        actions: [
          TextButton(onPressed: ( ){sil(widget.cihaz.cihaz_id);}, child: Text("Sil" ,style: TextStyle(color: Colors.black),)),
          TextButton(onPressed: ( ){guncelle(widget.cihaz.cihaz_id, tfCihazIsim.text, tfCihazSeriNo.text);}, child: Text("Güncelle" ,style: TextStyle(color: Colors.black),))

        ],
      ),
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
                        const Text(
                          'Cihaz adı',
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
                            controller: tfCihazIsim,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.ad_units_sharp,
                                color: Colors.green,
                              ),
                              hintText: 'Cihaz adı',
                              hintStyle: TextStyle(color: Colors.white30),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Seri no',
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
                            controller: tfCihazSeriNo ,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.abc_rounded,
                                color: Colors.green,
                              ),

                              hintText: 'Seri no',
                              hintStyle: TextStyle(color: Colors.white30),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

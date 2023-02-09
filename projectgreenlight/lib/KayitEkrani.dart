import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


import 'main.dart';

class KayitEkrani extends StatefulWidget {



  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  FirebaseAuth auth=FirebaseAuth.instance;

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }


    if (!mounted) return;

    setState(() {
      var _scanBarcode = barcodeScanRes;
      tfCihazSeriNo.text=_scanBarcode;
    });
  }
      var tfCihazIsim=TextEditingController();
      var tfCihazSeriNo=TextEditingController();

        var refCihazlar=FirebaseDatabase.instance.ref().child(FirebaseAuth.instance.currentUser!.uid.toString());

      Future<void> kayit(String cihaz_isim, String cihaz_serino,bool cihaz_calisiyormu) async{
          var info=HashMap<String,dynamic>();
          info["cihaz_id"]="";
          info["cihaz_isim"]=cihaz_isim;
          info["cihaz_serino"]=cihaz_serino;
          info["cihaz_calisiyormu"]=cihaz_calisiyormu;
          refCihazlar.push().set(info);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AnaEkran()));

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
        title:  Text("Greenlight",style: TextStyle(color: Colors.black),),
      actions: [
        IconButton(onPressed: (){scanQR();},icon: Icon(Icons.qr_code,color: Colors.green,)),

      ],
      ),
      body:Padding(


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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
            kayit(tfCihazIsim.text,tfCihazSeriNo.text,false);

        },
        backgroundColor: Colors.green,
        tooltip: 'Kaydet',
        icon: Icon(Icons.save),
        label: Text("Kaydet"),
      ),

    );
  }




}

import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Cihazlar.dart';
import 'DetayEkran.dart';
import 'KayitEkrani.dart';

class Lightings extends StatefulWidget {
  const Lightings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LightingsState createState() => _LightingsState();
}

class _LightingsState extends State<Lightings> {
  late Cihazlar cihaz;
  FirebaseAuth auth=FirebaseAuth.instance;
  var refCihazlar=FirebaseDatabase.instance.ref().child(FirebaseAuth.instance.currentUser!.uid.toString());
  Map<String,dynamic> switchDurum={};
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

  @override
  Widget build(BuildContext context) {
    var screenInfo=MediaQuery.of(context);
    final double screenHeight=screenInfo.size.height;//yukseklik
    final double screenWidth=screenInfo.size.width;//genislik



    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Greenlight',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body:
           StreamBuilder<DatabaseEvent> (
            stream: refCihazlar.onValue,
            builder: (context,event){
              if(event.hasData){
                var cihazListesi=<Cihazlar>[];
                var gelenDegerler=event.data!.snapshot.value as dynamic;

                if(gelenDegerler != null ){
                  gelenDegerler.forEach((key,nesne){
                    var gelenCihaz=Cihazlar.fromJson(key,nesne);

                    cihazListesi.add(gelenCihaz);



                  });

                }



                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1
                  ),
                  itemCount: cihazListesi.length ,
                  itemBuilder: (context,indeks){
                    var cihaz=cihazListesi[indeks];
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DetayEkran(cihaz: cihaz,)));
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 29, 29, 29),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),elevation:7.0,

                        child: SizedBox(height: screenHeight/7,
                          child: Column(



                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              const SizedBox(height: 10),
                              Icon(

                                Icons.lightbulb,
                                size: 50,
                                color: cihaz.cihaz_calisiyormu? Colors.yellowAccent:Colors.white,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),

                                child: Text(cihaz.cihaz_isim,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),

                                child: Text(cihaz.cihaz_serino, softWrap: false,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              ),

                              Spacer(),
                              Switch(value:switchDurum[cihaz.cihaz_id]==null ? false: switchDurum[cihaz.cihaz_id],

                                onChanged: (switchDegeri){

                                  setState(() {


                                    switchDurum[cihaz.cihaz_id]=switchDegeri;


                                    if(switchDegeri==true){
                                      guncelle(cihaz.cihaz_id, true);



                                    }else if(switchDegeri==false){
                                      guncelle(cihaz.cihaz_id, false);

                                    }


                                  });


                                },





                              )




                            ],

                          ),
                        ),
                      ),
                    );
                  },

                );

              }else{
                return Center();
              }
            },

          ),



    );
  }
}

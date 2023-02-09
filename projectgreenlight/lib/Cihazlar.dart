class Cihazlar{
   String cihaz_id;
   String cihaz_isim;
   String cihaz_serino;
   bool cihaz_calisiyormu;


  Cihazlar(
      this.cihaz_id, this.cihaz_isim, this.cihaz_serino,this.cihaz_calisiyormu);
  factory Cihazlar.fromJson(String key, Map<dynamic,dynamic> json){
    return Cihazlar(key, json["cihaz_isim"] as String, json["cihaz_serino"] as String, json["cihaz_calisiyormu"] as bool);

  }
}
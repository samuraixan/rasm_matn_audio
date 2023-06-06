class Res {
  Res({
      this.heading, 
      this.ready, 
      this.voice, 
      this.translate, 
      this.mus, 
      this.musi,});

  Res.fromJson(dynamic json) {
    heading = json['heading'];
    ready = json['ready'];
    voice = json['voice'];
    translate = json['translate'];
    mus = json['mus'];
    musi = json['musi'];
  }
  String? heading;
  String? ready;
  String? voice;
  String? translate;
  String? mus;
  String? musi;


}
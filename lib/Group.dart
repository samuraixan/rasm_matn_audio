class Group {
  Group({
      this.name, 
      this.id, 
      this.mus, 
      this.musi,});

  Group.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'] != null ? json['id'].cast<String>() : [];
    mus = json['mus'] != null ? json['mus'].cast<String>() : [];
    musi = json['musi'];
  }
  String? name;
  List<String>? id;
  List<String>? mus;
  String? musi;


}
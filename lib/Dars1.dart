import 'Res.dart';

class Dars1 {
  Dars1({
      this.res,});

  Dars1.fromJson(dynamic json) {
    if (json['res'] != null) {
      res = [];
      json['res'].forEach((v) {
        res?.add(Res.fromJson(v));
      });
    }
  }
  List<Res>? res;


}
import 'Group.dart';

class Dars {
  Dars({
      this.group,});

  Dars.fromJson(dynamic json) {
    if (json['group'] != null) {
      group = [];
      json['group'].forEach((v) {
        group?.add(Group.fromJson(v));
      });
    }
  }
  List<Group>? group;


}
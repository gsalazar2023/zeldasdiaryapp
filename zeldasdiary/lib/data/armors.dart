import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//import 'armordetail.dart';

class Armors {
  int ID;
  String name;
  List<String> location;
  String image;

  Armors(this.ID, this.name, this.location, this.image);

   factory Armors.fromJson(Map<String, dynamic> json) {
    return Armors(
      json['id'],
      json['name'],
      List<String>.from(json['location']),
      json['image'],
    );
  }

}
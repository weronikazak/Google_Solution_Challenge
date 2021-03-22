import 'package:flutter/cupertino.dart';

class Shelter {
  String city;
  String postcode;
  String street;

  Shelter(
      {@required this.city, @required this.street, @required this.postcode});

  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
        city: json["city"], street: json["street"], postcode: json["postcode"]);
  }
}

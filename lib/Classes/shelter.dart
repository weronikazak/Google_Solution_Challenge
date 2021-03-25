import 'package:flutter/cupertino.dart';

class Shelter {
  String city;
  String postcode;
  String street;
  double longitude;
  double latitude;

  Shelter(
      {@required this.city,
      @required this.longitude,
      @required this.latitude,
      @required this.postcode});

  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
        city: json["result"]["parliamentary_constituency"],
        postcode: json["result"]["postcode"],
        longitude: (json["result"]["longitude"]).toDouble(),
        latitude: (json["result"]["latitude"]).toDouble());
  }
}

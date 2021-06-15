import 'package:flutter/material.dart';

class BusStops extends ChangeNotifier
{
String name;
String latitude;
String longitude;
String sub;
String regNo;
BusStops();

BusStops.fromMap(Map<String,dynamic> data){
  name = data['name'];
  sub = data['sub'];
  latitude = data['latitude'];
  longitude = data['longitude'];
  regNo = data['regNo'];
  notifyListeners();
}





}
import 'package:flutter/widgets.dart';

class Shuttles extends ChangeNotifier {
  String id;
  String lastMaintenance;
  double latitude;
  double longitude;
  String mileage;
  String model;
  double distance;
  String seats;
  int speed;
  String regNo;
  Shuttles();
  Shuttles get instance => this;
  Shuttles.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    latitude = data['latitude'];
    longitude = data['longitude'];
    mileage = data['mileage'];
    model = data['model'];
    speed = data['speed'];
    seats = data['seats'];
    lastMaintenance = data['lastMaintenance'].toString();
    regNo = data['id'];
    notifyListeners();
  }
}

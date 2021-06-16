import 'package:flutter/widgets.dart';

class Shuttles extends ChangeNotifier {
  String id;
  String lastMaintenance;
  double latitude;
  double longitude;
  String mileage;
  String model;
  String seats;
  String regNo;
  Shuttles();
  Shuttles get instance => this;
  Shuttles.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    latitude = double.parse(data['latitude']);
    longitude = double.parse(data['longitude']);
    mileage = data['mileage'];
    model = data['model'];
    seats = data['seats'];
    lastMaintenance = data['lastMaintenance'].toString();
     regNo = data['regNo'];
    notifyListeners();
  }
}

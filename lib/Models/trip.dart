import 'package:flutter/widgets.dart';
import 'package:shuttleuserapp/Models/BusStops.dart';

class Trip extends ChangeNotifier {
  String shuttle;
  BusStops busStop = BusStops();
  String seat;
  String status;
  String id;
  DateTime timeStamp;
  Trip();
  Trip get instance => this;
  Trip.fromMap(Map<String, dynamic> data) {
    shuttle = data['shuttle'];
    // busStop.latitude = data['latitude'];
    // busStop.longitude = data['longitude'];
    seat = data['seat'];
    status = data['status'];
    timeStamp = data['timeStamp'];
    id = data["id"];
    notifyListeners();
  }
}

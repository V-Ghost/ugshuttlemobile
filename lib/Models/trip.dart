import 'package:flutter/widgets.dart';

class Trip extends ChangeNotifier {
  String shuttle;

  String seat;
  String status;
  String timeStamp;
  Trip();
  Trip get instance => this;
  Trip.fromMap(Map<String, dynamic> data) {
    shuttle = data['shuttle'];
   
    seat = data['seat'];
    status = data['status'];
    timeStamp = data['timeStamp'];

    notifyListeners();
  }
}

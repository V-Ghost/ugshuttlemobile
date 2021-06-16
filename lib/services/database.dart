import 'dart:ffi';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:shuttleuserapp/Models/CoOrdinates.dart';
import 'package:shuttleuserapp/Models/shuttles.dart';
import 'package:shuttleuserapp/Models/trip.dart';

import 'package:shuttleuserapp/Models/userInfo.dart';
import 'package:shuttleuserapp/Models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('shuttleUsers');

  Future<dynamic> updateUserData(Users u) async {
    try {
      
      await userCollection.doc(uid).set({
        'name': u.userName,
        'indexNo': u.uid,
      });
      return true;
    } catch (error) {
      print(error.toString());
      return error.toString();
    }
  }


 Future<dynamic> getBusStops() async {
   var busStopsList = [];
    var busStops =
       await FirebaseFirestore.instance.collection('busStops').get(); 

     busStops.docs.forEach((shuttle) {
       Shuttles temp = Shuttles.fromMap(shuttle.data());
       
      busStopsList.add(temp);
    });

    return busStopsList;
 }
  Future<dynamic> updatelocation(Position position) async {
   
        try {
          
      await userCollection.doc(uid).update({
        'latitude': position.latitude,
        'longitude': position.longitude,
      });
      return true;
    } catch (error) {
      print(error.toString());
      return error.toString();
    }
  }

  // Future<dynamic> getAvaliableShuttle(Array<Shuttle){

  // }

  Future<dynamic> getShuttles() async {
   
    var shuttlesList = [];
    var shuttles =
        await FirebaseFirestore.instance.collection('shuttles').get();
    shuttles.docs.forEach((shuttle) {
       Shuttles temp = Shuttles.fromMap(shuttle.data());
       
      shuttlesList.add(temp);
    });

    return shuttlesList;
  }
  

  Future<dynamic> createTrip(Trip u) async{
       try {
       var uuid = Uuid();
      await userCollection.doc(uid).collection("trips").doc(uuid.v1()).set({
        'shuttle': u.shuttle,
        'seat': u.seat,
        'status': u.status,
         'timestamp': u.timeStamp,
      });
      return true;
    } catch (error) {
      print(error.toString());
      return error.toString();
    }
  }




  Future<void> saveDeviceToken() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = userCollection.doc(uid).collection('tokens').doc("fcmToken");

      await tokens.set({
        'token': fcmToken,
        'platform': Platform.operatingSystem,
        // optional
      });
    }
  }

  
  Future<dynamic> sendNotification(
      String from, String to, String message, String type) async {
    try {
      FirebaseFunctions functions = FirebaseFunctions.instance;
      HttpsCallable callable = functions.httpsCallable('noti');
      print("ookkayyy");
      print(type);
      print(message);
      if (type == "brim") {
        final HttpsCallableResult result = await callable.call(
          <String, dynamic>{
            'to': to,
            'from': from,
            'message': message,
            'type': type,
          },
        );
        print("callable");
        print(result.data);
      } else {
        final HttpsCallableResult result = await callable.call(
          <String, dynamic>{
            'to': to,
            'from': from,
            'message': message,
          },
        );
        print("callable");
        print(result.data);
      }
    } on FirebaseFunctionsException catch (e) {
      print('caught firebase functions exception');
      print(e);
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }
  }
}

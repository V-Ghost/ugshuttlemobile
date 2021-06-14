import 'dart:async';
import 'package:shuttleuserapp/Models/users.dart';
import 'package:shuttleuserapp/pages/landingPages/mainPage.dart';
import 'package:shuttleuserapp/pages/register/loginUi.dart';
import 'package:shuttleuserapp/pages/register/userDetails/registerationPage.dart';
// import 'package:shuttleuserapp/pages/signup.dart';
import 'package:shuttleuserapp/widgets/errorWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
 
  User user;
  bool registered;
  Users u;

  Future<void> getUserDetails() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    
    var query = await FirebaseFirestore.instance.collection('shuttleUsers').get();
  //  query.docs.forEach((data) async{
     
  //   //print(data.data());
  //   print("data");
    //DatabaseService().sendNotification();
    // var now = new DateTime.now();
    // if(data.data().isNotEmpty) {
     //if(DatabaseService().convertUTCToLocalDateTime(data.data()['latest'].toDate()).isBefore(now.subtract(Duration(days: 1))) ){
    //  print("delting here");
    //  print(data.id);
     
    //   var query = await FirebaseFirestore.instance.collection('chats').doc(data.id).collection("messages").get();
    //   query.docs.forEach((doc){
    //  FirebaseFirestore.instance.collection('chats').doc(data.id).collection("messages").doc(doc.id).delete();
    //   });
    //    FirebaseFirestore.instance.collection('chats').doc(data.id).delete();
      // print("eii hun");
      // print(query.;
     
      // query.data().forEach((key,value){
      //     print("ma deletii");
      //     print(key);
      //     print(value);
      // });
    
    //}
   // }
    //var nextCheck = new DateTime(now  .getYear(), now.getMonth(), now.getDate() + 1);
   
  // });
    if (myPrefs.getBool('loggedIn')) {
      Users temp;
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('shuttleUsers')
          .doc(user.uid)
          .get();
  
      if (documentSnapshot.exists) {
        temp = Users.fromMap(documentSnapshot.data());
        u.uid = temp.uid;
        u.userName = temp.userName;
        // u.bio = temp.bio;
        // u.dob = temp.dob;
        // u.gender = temp.gender;
        
        user = FirebaseAuth.instance.currentUser;
        SharedPreferences myPrefs = await SharedPreferences.getInstance();
       
        myPrefs.setBool("isFirstRun", false);
       
        registered = true;
      } else {
        registered = false;
      }
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => LoginUI()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    u = Provider.of<Users>(context, listen: false);
   
    // user = Provider.of<User>(context, listen: false);
    user = FirebaseAuth.instance.currentUser;

    // u = DatabaseService(uid: user.uid).getUserDetails();
    // print(user.uid);
    // _getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // int _selectedIndex = 0;
  // static List<Widget> _widgetOptions = <Widget>[myappPage(), Chats(), Slide()];
  // _getCurrentLocation() {
  //   Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  //  _scaffoldKey.currentState.openDrawer();
  @override
  Widget build(BuildContext context) {
  
    return FutureBuilder(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                  child: ShowError(
                size: 100,
                color: Colors.grey,
                error: snapshot.error.toString(),
              )),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return registered ? MainPage() : RegisterationPage();
          }
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

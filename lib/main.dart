import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';


import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shuttleuserapp/Models/shuttles.dart';
import 'package:shuttleuserapp/Models/users.dart';
import 'package:shuttleuserapp/pages/landingPages/homepage.dart';
import 'package:shuttleuserapp/pages/register/loginUi.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool loggedIn = false;

  Future<dynamic> intialize() async {
    // tz.initializeTimeZones();
      await Firebase.initializeApp();
     
      SharedPreferences myPrefs = await SharedPreferences.getInstance();
       myPrefs.setBool("login", false);
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        loggedIn = false;
          myPrefs.setBool("loggedIn", false);
       
       
      } else {
        loggedIn = true;
          myPrefs.setBool("loggedIn", true);
         
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Users().instance,
        
        ),

        ChangeNotifierProvider.value(
          value: Shuttles().instance,
        
        ),
       
      ],
      child: FutureBuilder(
          future: intialize(),
          builder: (context, snapshot) {
           
            if (snapshot.hasError) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Column(
                    children: [
                      Icon(Icons.error),
                      Text(snapshot.error.toString(),
                      style: TextStyle(fontSize: 15,color: Colors.grey),
                      )
                    ],
                  ),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
             
              return MaterialApp(
               
                // initialRoute: '/',
               
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primaryColor: Colors.purple,
                  accentColor: Colors.purpleAccent,
                  buttonColor: Colors.purple,
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  }),
                  primarySwatch: Colors.purple,
                  fontFamily: 'Merriweather',
                  // visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: loggedIn ? Homepage() : LoginUI(),
                //  home:  UserDetails(),
              );
            }
            return MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.purple,
                accentColor: Colors.purpleAccent,
                buttonColor: Colors.purple,

                primarySwatch: Colors.purple,

                // visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            );
          }),
    );
  }
}

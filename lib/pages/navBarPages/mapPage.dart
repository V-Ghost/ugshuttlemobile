import 'dart:collection';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shuttleuserapp/Models/shuttles.dart';
import 'package:shuttleuserapp/Models/trip.dart';
import 'package:shuttleuserapp/Models/users.dart';
import 'package:shuttleuserapp/pages/navBarPages/ordering/receipt.dart';

import 'package:shuttleuserapp/pages/register/loginUi.dart';
// import 'package:shuttleuserapp/pages/sendBrims.dart';
import 'package:shuttleuserapp/services/auth.dart';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:shuttleuserapp/services/database.dart';
import 'package:shuttleuserapp/widgets/destinationBottomSheet.dart';
import 'package:shuttleuserapp/widgets/raisedGradientButton.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool isLocationServiceEnabled;
  LocationPermission permission;
  GoogleMapController _mapController;
  Map<dynamic, dynamic> users;
  Set<Marker> _markers = HashSet<Marker>();
  // Map<String, Marker> _markers = <String, Marker>{};
  BitmapDescriptor _markerIcon;
  Users u;
  User user;
  String _mapStyle;
  double height;
  double p;
  double width;
  static var _initialPosition;
  double h;
  bool onGoingTrip;
  Shuttles orderedShuttle;
  Position position;
  static var _lastMapPosition = _initialPosition;
  bool hide;
  double opacity;
  bool details;
  Shuttles selectedShuttle;
  String name;
  String bio;
  String user2;
  String gender;
  Uint8List markerIcon;
  var shuttles;
  @override
  void initState() {
    u = Provider.of<Users>(context, listen: false);
    selectedShuttle = Provider.of<Shuttles>(context, listen: false);
    h = 80;
    p = 0;
    name = "";
    bio = "";
    opacity = 0;
    details = false;
    hide = true;
    user2 = "";

    user = FirebaseAuth.instance.currentUser;

    _style();
    _getUserLocation();

    // _getNearbyUsers();

    super.initState();
  }

  void _style() async {
    _mapStyle = await rootBundle.loadString('assets/json_assets/map_style.txt');
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void _onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(_mapStyle);
    _mapController = controller;
    shuttles = await DatabaseService(uid: user.uid).getShuttles();

    markerIcon = await getBytesFromAsset('lib/images/brimPointer.png', 100);
    //showPinsOnMap();
    updatePins();
  }

  updatePins() async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('shuttles');
    reference.snapshots().listen((querySnapshot) {
      _markers.clear();
      querySnapshot.docs.forEach((change) async {
        Shuttles temp = Shuttles.fromMap(change.data());

        var pinPosition = LatLng(temp.latitude, temp.longitude);
        MarkerId m = new MarkerId(temp.id);
        _markers.add(Marker(
            markerId: m,
            position: pinPosition,
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(
                title: "Model : ${temp.model}",
                snippet: "seats Avaliable : ${temp.seats}")));
      });
      if (mounted) {
        setState(() {});
      }
    });
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(1, 1)), 'lib/images/brimPointer.png');
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void showPinsOnMap() async {
    shuttles.forEach((shuttle) {
      MarkerId m = MarkerId(shuttle.id.toString());
      _markers.add(Marker(
          markerId: m,
          position: LatLng(shuttle.latitude, shuttle.longitude),
          icon: BitmapDescriptor.fromBytes(markerIcon)));
    });
  }

  void _getUserLocation() async {
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    Shuttles s = new Shuttles();

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (isLocationServiceEnabled) {
      if (mounted) {
        setState(() {
          _initialPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 12.4746,
          );
          //print('${placemark[0].name}');
        });
      }
    } else {
      permission = await Geolocator.requestPermission();
      if (mounted) {
        setState(() {});
      }
    }
    //List<Placemark> placemark = await Geolocator.placemarkFromCoordinates(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.bodyText2;

    // print(u.position.latitiude);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FabCircularMenu(
          ringColor: Colors.purple,
          fabOpenIcon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          fabOpenColor: Colors.white,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.alarm, size: 35, color: Colors.white),
                onPressed: () async {
                  var t = await DatabaseService(uid: user.uid)
                      .checkIfThereIsPendingOrder();
                  print(t);
                  if (t is Trip) {
                    await DatabaseService(uid: user.uid).triggerBusStop(t);
                  } else {
                    Fluttertoast.showToast(
                        msg: " Sorry :( you have no current trips ongoing.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }),
            IconButton(
                icon: Icon(Icons.receipt, size: 35, color: Colors.white),
                onPressed: () async {
                  var t = await DatabaseService(uid: user.uid)
                      .checkIfThereIsPendingOrder();
                  print(t);
                  if (t is Trip) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Receipt(
                                trip: t,
                              )),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: " Sorry :( you have no current trips ongoing.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }),
            IconButton(
                icon: Icon(Icons.bus_alert_rounded,
                    size: 35, color: Colors.white),
                onPressed: () {
                  int i = 0;
                  double temp = 0;
                  Shuttles tempShuttle;
                  shuttles.forEach((shuttle) {
                    double distancefrom = Geolocator.distanceBetween(
                        position.latitude,
                        position.longitude,
                        shuttle.latitude,
                        shuttle.longitude);
                    if (i == 0) {
                      temp = distancefrom;
                      selectedShuttle = shuttle;
                    }
                    print(distancefrom);
                    if (temp > distancefrom) {
                      temp = distancefrom;
                      selectedShuttle = shuttle;
                      // print(shuttle.id);
                      print(selectedShuttle.id);
                    }
                    i++;
                  });

                  if (temp < 4000) {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return DestinationBottomSheet(
                          shuttle: selectedShuttle,
                        );
                      },
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: " Sorry :( there are buses near you.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }),
          ]),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 2,
              backgroundImage: AssetImage(
                'lib/images/brim0.png',
              ),
              backgroundColor: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text('Shuttler', style: TextStyle(color: Colors.black)),
      ),
      body: _initialPosition == null
          ? Container(
              child: Center(
                child: Text(
                  'loading map..',
                  style: TextStyle(
                      fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                ),
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initialPosition,
                  myLocationEnabled: true,
                  onMapCreated: _onMapCreated,
                  zoomGesturesEnabled: true,
                  markers: _markers,
                  zoomControlsEnabled: false,
                  onTap: (LatLng position) {
                    setState(() {
                      details = false;
                      _mapController.animateCamera(CameraUpdate.zoomOut());
                    });
                  },
                ),
              ],
            ),
    );
  }

  onMarkerTap() {}
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuttleuserapp/Models/BusStops.dart';
import 'package:shuttleuserapp/Models/shuttles.dart';
import 'package:shuttleuserapp/Models/trip.dart';
import 'package:shuttleuserapp/services/database.dart';
import 'package:shuttleuserapp/widgets/busLayout.dart';
import 'package:shuttleuserapp/widgets/raisedGradientButton.dart';

class Ticket extends StatefulWidget {
  final Shuttles shuttle;
  final BusStops busStop;
  Ticket({Key key, @required this.shuttle, @required this.busStop})
      : super(key: key);

  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  Shuttles selectedShuttle;

  @override
  void initState() {
    selectedShuttle = Provider.of<Shuttles>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Row(children: [
                Container(
                  child: Row(children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Ticket",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ]),
                ),
                Expanded(
                  child: Container(),
                ),
              ]),
            ),
            SizedBox(
              height: 15,
            ),
            BusLayout(),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    "Bus Registration Number",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    "Seat Number",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    "${widget.shuttle.regNo}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    "${widget.shuttle.seats}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text(
                  "Estimated Arrival Time : xx",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedGradientButton(
                width: 200,
                child: Text(
                  'Confirm Order',
                  style: TextStyle(color: Colors.white),
                ),
                gradient: LinearGradient(
                  colors: <Color>[Colors.purple[800], Colors.purple],
                ),
                onPressed: () async {
                  // bool okay = false;
                  //await DatabaseService().getSettings();
                  // showDialog<String>(
                  //   context: context,
                  //   builder: (BuildContext context) => AlertDialog(
                  //     title: const Text('This trip carries a charge'),
                  //     content: const Text('You are required'),
                  //     actions: <Widget>[
                  //       TextButton(
                  //         onPressed: () => Navigator.pop(context, 'Cancel'),
                  //         child: const Text('Cancel'),
                  //       ),
                  //       TextButton(
                  //         onPressed: () async {
                  //           okay = true;
                  //           Navigator.pop(context, 'Cancel');
                  //         },
                  //         child: const Text('OK'),
                  //       ),
                  //     ],
                  //   ),
                  // );
                  // if (okay) {
                  print("okay hit");
                  Trip t = new Trip();
                  t.seat = "Br-3";
                  t.shuttle = widget.shuttle.id;
                  t.busStop = widget.busStop;
                  t.status = "booked";

                  t.timeStamp = DateTime.now();
                  await DatabaseService(
                          uid: FirebaseAuth.instance.currentUser.uid)
                      .createTrip(t);
                  Navigator.pop(context);
                  // } else {
                  //   print("nooo");
                  // }
                }),
          ]),
        ),
      ),
    );
  }
}

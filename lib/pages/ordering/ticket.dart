import 'package:flutter/material.dart';
import 'package:shuttleuserapp/Models/shuttles.dart';
import 'package:shuttleuserapp/widgets/seats.dart';

class Ticket extends StatelessWidget {
  final Shuttles shuttle;
  const Ticket({Key key, this.shuttle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Row(children: [
                Container(
                  child: Row(children: [
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
            Seats(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
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
             Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
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
            )
          ]),
        ),
      ),
    );
  }
}

class name extends StatelessWidget {
  const name({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}

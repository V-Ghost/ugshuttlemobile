import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuttleuserapp/Models/shuttles.dart';
import 'package:shuttleuserapp/widgets/raisedGradientButton.dart';
import 'package:shuttleuserapp/widgets/seats.dart';

class Ticket extends StatefulWidget {
  final Shuttles shuttle;
  Ticket({Key key, @required this.shuttle}) : super(key: key);

  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  Shuttles selectedShuttle;
  @override
  void initState() {
    selectedShuttle = Provider.of<Shuttles>(context, listen: false);
    print(widget.shuttle.id);
    super.initState();
  }

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
            RaisedGradientButton(
                width: 200,
                child: Text(
                  'Confirm Order',
                  style: TextStyle(color: Colors.white),
                ),
                gradient: LinearGradient(
                  colors: <Color>[Colors.purple[800], Colors.purple],
                ),
                onPressed: () {
                    
                }),
          ]),
        ),
      ),
    );
  }
}

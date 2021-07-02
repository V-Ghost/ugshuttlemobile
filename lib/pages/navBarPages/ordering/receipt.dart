import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shuttleuserapp/Models/trip.dart';

class Receipt extends StatefulWidget {
  final Trip trip;
  const Receipt({Key key, @required this.trip}) : super(key: key);

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        Icons.receipt,
                        color: Colors.grey,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Receipt",
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
              QrImage(
                data: "pSFs0S5l-azTrfa9",
                version: 1,
                size: 320,
                gapless: false,
                errorStateBuilder: (cxt, err) {
                  return Container(
                    child: Center(
                      child: Text(
                        "error",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

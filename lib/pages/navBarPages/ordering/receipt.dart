import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shuttleuserapp/Models/trip.dart';
import 'package:shuttleuserapp/widgets/customDialogBox.dart';
import 'package:shuttleuserapp/widgets/raisedGradientButton.dart';

class Receipt extends StatefulWidget {
  final Trip trip;
  const Receipt({Key key, @required this.trip}) : super(key: key);

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  bool _supportsNFC = false;

  @override
  void initState() {
    super.initState();
    NFC.isNDEFSupported.then((bool isSupported) {
      setState(() {
        _supportsNFC = isSupported;
      });
    });
  }

  getTripinfo() {}

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
                data: "google.com",
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
                height: 80,
              ),
              // _supportsNFC
              true
                  ? RaisedGradientButton(
                      width: 200,
                      child: Text(
                        'Scan on-board device',
                        style: TextStyle(color: Colors.white),
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[Colors.pink[800], Colors.pink],
                      ),
                      onPressed: () async {
                        NDEFMessage newMessage = NDEFMessage.withRecords(
                            [NDEFRecord.plain("scanned")]);
                        Stream<NDEFTag> stream =
                            NFC.writeNDEF(newMessage, once: true);

                        stream.listen((NDEFTag tag) {
                          print("only wrote to one tag!");
                        });
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Start Trip",
                                descriptions:
                                    "Hold your phone near the on-board device until the blue light blinks",
                                text: "Close",
                                img: Image.asset("lib/images/nfc.png"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              );
                            });
                      })
                  : null,
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuttleuserapp/Models/BusStops.dart';
import 'package:shuttleuserapp/Models/shuttles.dart';
import 'package:shuttleuserapp/Models/users.dart';
import 'package:shuttleuserapp/pages/ordering/ticket.dart';

class DestinationBottomSheet extends StatefulWidget {
  
  DestinationBottomSheet({Key key}) : super(key: key);

  _DestinationBottomSheetState createState() => _DestinationBottomSheetState();
}

class _DestinationBottomSheetState extends State<DestinationBottomSheet> {
  var busStopsList = [];
  Users user;
  @override
  void initState() {
    user = Provider.of<Users>(context, listen: false);
    super.initState();
  }

  getBuses() async {
    var busStops =
        await FirebaseFirestore.instance.collection('busStops').get();

    busStops.docs.forEach((busStop) {
      BusStops temp = BusStops.fromMap(busStop.data());
      print("adeyy");
      print(busStop.data());
      busStopsList.add(temp);
    });
    print(busStopsList.length);
    return busStopsList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),

      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.purple,
              // border: Border(bottom: BorderSide()),
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 30, left: 10, right: 10),
              child: Text(
                "where are you going?",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )),
          ),
          FutureBuilder<dynamic>(
              future: getBuses(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                          itemCount: busStopsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: InkWell(
                                  child: ListTile(
                                      leading: const Icon(Icons.location_on),
                                      title: Text(busStopsList[index].name),
                                      subtitle: Text(busStopsList[index].sub),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => Ticket()),
                                        );
                                      }),
                                ));
                          }),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      Icon(Icons.error),
                      Text(
                        snapshot.error.toString(),
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                );
              }),
        ],
      ),
      // ListView(
      //     children: [

      //       Padding(
      //           padding: const EdgeInsets.only(left: 10, right: 10),
      //           child: ListTile(
      //               leading: const Icon(Icons.location_on),
      //               title: const Text("Jean Nelson Aka Hall"),
      //               subtitle: const Text('Diaspora Halls'),
      //               onTap: () {

      //               })),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Padding(
      //           padding: const EdgeInsets.only(left: 10, right: 10),
      //           child: ListTile(
      //               leading: const Icon(Icons.location_on),
      //               title: const Text("Hilla Limann Hall"),
      //               subtitle: const Text('Diaspora Halls'),
      //               onTap: () => print("ListTile"))),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Padding(
      //           padding: const EdgeInsets.only(left: 10, right: 10),
      //           child: ListTile(
      //               leading: const Icon(Icons.location_on),
      //               title: const Text("Chemistry Department"),
      //               subtitle: const Text('Main Campus'),
      //               onTap: () => print("ListTile"))),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Padding(
      //           padding: const EdgeInsets.only(left: 10, right: 10),
      //           child: ListTile(
      //               leading: const Icon(Icons.location_on),
      //               title: const Text("Business School"),
      //               subtitle: const Text('Main Campus'),
      //               onTap: () => print("ListTile"))),
      //     ],
      //   ),
    );
  }
}

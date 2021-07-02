import 'package:flutter/material.dart';
import 'package:shuttleuserapp/widgets/seats.dart';

class BusLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(),
                    SizedBox(
                      width: 30,
                    ),
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(
                      color: Colors.green,
                    ),
                    Seats(),
                    SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: RotatedBox(quarterTurns: -1, child: Seats()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: RotatedBox(quarterTurns: -1, child: Seats()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: RotatedBox(quarterTurns: -1, child: Seats()),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(),
                    SizedBox(
                      width: 30,
                    ),
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Seats(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(),
                    SizedBox(
                      width: 30,
                    ),
                    Seats(),
                    Seats(),
                    Seats(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(),
                    Seats(),
                    SizedBox(
                      width: 30,
                    ),
                    Seats(),
                    Seats(),
                    Seats(),
                    SizedBox(
                      width: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: RotatedBox(quarterTurns: -1, child: Seats()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: RotatedBox(quarterTurns: -1, child: Seats()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: RotatedBox(quarterTurns: -1, child: Seats()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: RotatedBox(quarterTurns: -1, child: Seats()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

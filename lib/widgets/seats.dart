import 'package:flutter/material.dart';

class Seats extends StatelessWidget {
  final Color color;
  Seats({this.color});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width;
    
    return SafeArea(
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: color == null ? Colors.grey : Colors.green,
          // border: Border(bottom: BorderSide()),
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(100.0),
            bottomLeft: const Radius.circular(100.0),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ReportBox extends StatelessWidget {
  final String title;
  ReportBox({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset.fromDirection(20.0, 3.0),
              spreadRadius: 2.0,
              blurRadius: 5.0,
            ),
          ]),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width - 40,
        minHeight: MediaQuery.of(context).size.height / 4,
      ),
      child: Text(title),
    );
  }
}

import 'package:flutter/material.dart';

class ActionBox extends StatelessWidget {
  final Function onPressed;

  ActionBox({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
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
      child: Center(
        child: RawMaterialButton(
          onPressed: onPressed,
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 40,
            minHeight: MediaQuery.of(context).size.height / 4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            'REPORT A NEW POTHOLE',
            style: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat'),
          ),
        ),
      ),
    );
  }
}

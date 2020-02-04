import 'package:flutter/material.dart';

class LeaderBox extends StatelessWidget {
  final int index;
  final String name;
  final int points;

  LeaderBox({this.name, this.points, this.index});

  Color getColor(int index) {
    if (index == 1) {
      return Color(0xFFD4A437);
    } else if (index == 2) {
      return Color(0xFFAAA9AD);
    } else if (index == 3) {
      return Color(0xFFCD7F32);
    } else
      return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 10,
        minWidth: MediaQuery.of(context).size.width - 40,
      ),
      decoration: BoxDecoration(
        color: getColor(index),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
          ),
          Text(
            index.toString(),
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 25.0),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name ?? 'Name',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
              ),
              Text(
                'Points: $points',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';

class AnimCar extends StatefulWidget {
  @override
  _AnimCarState createState() => _AnimCarState();
}

class _AnimCarState extends State<AnimCar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 350,
      ),
      child: FlareLoading(
        name: 'assets/pothole1.flr',
        onSuccess: null,
        onError: null,
        startAnimation: 'start',
        loopAnimation: 'loop',
      ),
    );
  }
}

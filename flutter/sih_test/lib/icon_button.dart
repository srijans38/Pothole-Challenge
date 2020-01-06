import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color color;
  final String image;
  final String text;

  CustomIconButton({
    @required this.onPressed,
    this.icon,
    this.image,
    @required this.text,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 20.0,
      onPressed: onPressed,
      fillColor: color,
      constraints: BoxConstraints(
        minHeight: 70.0,
        minWidth: 200.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 30.0,
          ),
          Material(
            borderRadius: BorderRadius.circular(50.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (image == null)
                  ? Icon(
                      icon,
                      size: 30.0,
                    )
                  : Image.asset(
                      image,
                      height: 30,
                      width: 30,
                    ),
            ),
          ),
          SizedBox(
            width: 30.0,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}

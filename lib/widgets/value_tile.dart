import 'package:flutter/material.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final String description;
  final IconData iconData;

  ValueTile(this.label, this.value, this.description, {this.iconData});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        this.iconData != null
            ? Icon(
          iconData,
          color: Colors.yellow,
          size: 50,
        )
            : Container(),
        Column(
            children: <Widget>[
              Text(
                this.label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                this.description,
                style: TextStyle(
                    color: Colors.black),
              ),
            ]
        ),
        Text(
          this.value,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ],
    );
  }
}
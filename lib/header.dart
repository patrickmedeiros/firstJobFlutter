import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Image.network(
          "https://portalbr.akamaized.net/brasil/uploads/2019/01/17170613/shutterstock_793868884.jpg",
          height: 120,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Informe a tarefa",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
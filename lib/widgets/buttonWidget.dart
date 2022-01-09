import 'package:flutter/material.dart';
import 'package:project_consultas/config.dart';

class ButtonWidget extends StatelessWidget {
  
  final String text;
  final double horizontal;
  final double vertical;
  final String route;

  const ButtonWidget({
    Key? key, 
    required this.text, 
    required this.horizontal, 
    required this.vertical, 
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        Navigator.pushNamed(context, this.route);
      }, 
      style: TextButton.styleFrom(
        side: BorderSide(
          color: primaryColorText
        ),
        padding: EdgeInsets.symmetric(horizontal: this.horizontal, vertical: this.vertical)
      ),
      child: Text(
        this.text.toUpperCase(),
        style: TextStyle(
          color: primaryColorText,
          fontWeight: FontWeight.bold,
          fontSize: 17
        ),
      )
    );
  }
}
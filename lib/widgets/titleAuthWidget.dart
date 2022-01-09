import 'package:flutter/material.dart';
import 'package:project_consultas/config.dart';

class TitleAuthWidget extends StatelessWidget {

  final String text;

  const TitleAuthWidget({
    Key? key, 
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: primaryColorText,
        fontSize: 28,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
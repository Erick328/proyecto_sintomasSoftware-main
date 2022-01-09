import 'package:flutter/material.dart';
import 'package:project_consultas/config.dart';

class TextAuthRedirectWidget extends StatelessWidget {

  final String text;
  final String url;

  const TextAuthRedirectWidget({
    Key? key, 
    required this.text, 
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        Navigator.pushNamed(context, this.url);
      }, 
      child: Text(
        this.text,
        style: TextStyle(
          color: primaryColorText,
          fontSize: 15
        ),
      )
    );
  }
}
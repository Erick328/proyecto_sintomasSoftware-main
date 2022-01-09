import 'package:flutter/material.dart';
import 'package:project_consultas/config.dart';

class TextFormWidget extends StatelessWidget {

  final bool contrasenia;
  final TextEditingController textController;
  final String inputText;

  const TextFormWidget({
    Key? key, 
    this.contrasenia = false, 
    required this.textController, 
    required this.inputText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: this.inputText,
        labelStyle: TextStyle(
          color: primaryColorText
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColorText
          )
        ),
      ),
      style: TextStyle(
        color: primaryColorText
      ),
      obscureText: this.contrasenia,
      controller: this.textController,
    );
  }
}
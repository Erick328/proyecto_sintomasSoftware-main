import 'package:flutter/material.dart';
import 'package:project_consultas/config.dart';

class ButtonEnfermedadesWidget extends StatelessWidget {
  
  final String text;

  const ButtonEnfermedadesWidget({
    Key? key, 
    required this.text, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (text=='Cancer')? primaryColor: Colors.white,
      width: double.infinity,
      child: TextButton(
        onPressed: (){
          if (
            this.text == 'Coronavirus' ||
            this.text == 'Dengue' ||
            this.text == 'Varicela'
          ) {
            Navigator.pushNamed(context, 'sintomas', arguments: {'text' : this.text});
          }else if(this.text == 'Cancer'){
            Navigator.pushNamed(context, 'cancer', arguments: {'text' : this.text});
          }else{
            print(this.text);
          }
        }, 
        style: TextButton.styleFrom(
          side: BorderSide(
            color: primaryColor
          ),
          padding: EdgeInsets.symmetric(vertical: 16)
        ),
        child: Text(
          this.text.toUpperCase(),
          style: TextStyle(
            color: (text!='Cancer')? primaryColor: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
        )
      ),
    );
  }
}
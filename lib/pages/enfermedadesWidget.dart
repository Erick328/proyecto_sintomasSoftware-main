import 'package:flutter/material.dart';
import 'package:project_consultas/widgets/buttonEnfermedadWidget.dart';

class EnfermedadesWidgets extends StatelessWidget {
  const EnfermedadesWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: TextButton(
        onPressed: (){},
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(

            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ButtonEnfermedadesWidget(
                  text: 'Coronavirus'
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ButtonEnfermedadesWidget(
                  text: 'Dengue'
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ButtonEnfermedadesWidget(
                  text: 'Varicela'
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ButtonEnfermedadesWidget(
                  text: 'Chagas'
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ButtonEnfermedadesWidget(
                  text: 'Gastritis'
                ),
              ),
              Expanded(child: Container()),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ButtonEnfermedadesWidget(
                  text: 'Cancer'
                ),
              ),
              
            ],

          ),
        ),
      ),

    );
  }
}
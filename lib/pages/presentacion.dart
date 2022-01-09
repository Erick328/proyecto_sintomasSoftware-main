import 'package:flutter/material.dart';
import 'package:project_consultas/config.dart';
import 'package:project_consultas/widgets/buttonWidget.dart';


class PresentacionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [

              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  image: DecorationImage(
                    image: AssetImage("assets/santa_cruz.jpg"), 
                    scale: 0.2,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop)
                  )
                ),
              ),

              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    padding: EdgeInsets.only(top: 125),
                    width: double.infinity,
                    child: Text(
                      textTitlePrimay,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColorText,
                        fontSize: 26,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    padding: EdgeInsets.only(top: 95),
                    width: double.infinity,
                    child: Text(
                      textTitleSecondary,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColorText,
                        fontSize: 14
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 155),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: ButtonWidget(
                              text: 'Login', 
                              horizontal: 84, 
                              vertical: 14, 
                              route: 'login', 
                              
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: ButtonWidget(
                              text: 'Registro', 
                              horizontal: 68, 
                              vertical: 14, 
                              route: 'register', 
                              
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}

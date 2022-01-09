import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_consultas/config.dart';
import 'package:project_consultas/pages/centrosMedicosWidget.dart';
import 'package:project_consultas/pages/enfermedadesWidget.dart';
import 'package:project_consultas/pages/historialWidget.dart';
import 'package:project_consultas/services/user_services.dart';
import 'package:project_consultas/widgets/buttonWidget.dart';


class IndexPage extends StatefulWidget {

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  
  final user = UserServices.usuario;

  int _selectedItem = 0;

  List<Widget> _widgetOptions = [
    EnfermedadesWidgets(),
    HistorialWidget(),
    CentrosMedicosWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        this.user.nombre.toUpperCase(),
                        style: TextStyle(
                          color: primaryColorText,
                          fontSize: 15
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: ButtonWidget(
                        text: 'Cerrar Sesion', 
                        horizontal: 64, 
                        vertical: 14, 
                        route: 'login'
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child:  this._widgetOptions.elementAt(this._selectedItem),
              )
            ],
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.notesMedical),
              label: 'Enfermedades',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bookMedical),
              label: 'Historial Clinico',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.map),
              label: 'Mapa',
            ),

          ],

          currentIndex: this._selectedItem,
          selectedItemColor: secondaryColor,
          backgroundColor: primaryColor,
          unselectedItemColor: neutroColor,
          onTap: _onItemTapped,
        )
       ),
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedItem = index;
    });
  }
}
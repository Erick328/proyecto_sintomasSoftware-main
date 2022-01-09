import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_consultas/config.dart';
import 'package:project_consultas/services/user_services.dart';
import 'package:project_consultas/widgets/textAuthRedirectWidget.dart';
import 'package:project_consultas/widgets/textFormWidget.dart';
import 'package:project_consultas/widgets/titleAuthWidget.dart';


class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final userPassController = TextEditingController();
  final userEmailController = TextEditingController();
  final userFechaNacimientoController = TextEditingController();
  String userSexoController = 'Seleccione un sexo';
  final userSangreController = TextEditingController();

  final userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 35),
                  child: TitleAuthWidget(
                    text: 'Registro',
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 35),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColorText
                    ),
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                        padding: EdgeInsets.only(top: 15),
                        child: TextFormWidget(
                          textController: this.userNameController, 
                          inputText: 'Nombre',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                        padding: EdgeInsets.only(top: 15),
                        child: TextFormWidget(
                          textController: this.userEmailController, 
                          inputText: 'Email',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                        padding: EdgeInsets.only(top: 15),
                        child: DateTimePicker(

                          firstDate: DateTime(1800),
                          lastDate: DateTime(2100),
                          onSaved: (val) => print(val),
                            decoration: InputDecoration(
                              labelText: "Fecha Nacimiento",
                              labelStyle: TextStyle(
                                color: primaryColorText
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColorText
                                )
                              )
                            ),

                            style: TextStyle(
                              color: primaryColorText
                            ),

                            controller: this.userFechaNacimientoController,

                        ),
                        
                        // TextFormWidget(
                        //   textController: this.userFechaNacimientoController, 
                        //   inputText: 'Fecha Nacimiento',
                        // ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                        padding: EdgeInsets.only(top: 15),
                        child: DropdownButton<String>(

                          value: userSexoController,
                          items: <String>['Seleccione un sexo','Hombre', 'Mujer',].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              if (value!=null){
                                userSexoController = value;
                              }
                            });
                          },
                          underline: Container(
                            height: 1,
                            color: primaryColorText,
                          ),
                          style: TextStyle(
                            color: primaryColorText
                          ),
                          iconDisabledColor: primaryColorText,
                          iconEnabledColor: primaryColorText,
                          isExpanded: true,
                          dropdownColor: primaryColor,
                          disabledHint: Text(
                            'sexo',
                            style: TextStyle(
                              color: primaryColorText
                            ),
                          ),
                          hint: Text(
                            'sexo',
                            style: TextStyle(
                              color: primaryColorText
                            ),
                          ),
                        )
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                        padding: EdgeInsets.only(top: 15),
                        child: TextFormWidget(
                          textController: this.userSangreController, 
                          inputText: 'Tipo Sangre',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                        padding: EdgeInsets.only(top: 15, bottom: 35),
                        child: TextFormWidget(
                          textController: this.userPassController, 
                          inputText: 'Contraseña',
                        )
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    
                    this._register(context);

                  }, 
                  style: TextButton.styleFrom(
                    side: BorderSide(
                      color: primaryColorText
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 84, vertical: 14)
                  ),
                  child: Text(
                    'Registrar'.toUpperCase(),
                    style: TextStyle(
                      color: primaryColorText,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),
                  )
                ),
                TextAuthRedirectWidget(
                  text: 'Si ya tienes una cuenta, ingresa aqui', url: 'login',
                )
              ],
            ),
          ),
        )
       ),
    );
  }

  void _register(context)async{

    var nombre = this.userNameController.text;
    var email = this.userEmailController.text;
    var fechaNacimiento = this.userFechaNacimientoController.text;
    var sexo = this.userSexoController;
    var tipoSangre = this.userSangreController.text;
    var contrasenia = this.userPassController.text;

    if (
      nombre.length > 0 &&
      email.length > 0 &&
      fechaNacimiento.length > 0 &&
      sexo != 'Seleccione un sexo' &&
      tipoSangre.length > 0 &&
      contrasenia.length > 0
    ){

      var data = {
        "Nombre"          : nombre,
        "Email"           : email,
        "FechaNacimiento" : fechaNacimiento,
        "Sexo"            : sexo,
        "TipoSangre"      : tipoSangre,
        "Contrasenia"     : contrasenia
      };

      bool estado = await userServices.registro(data);

      if (estado){
        Navigator.pushNamed(context, 'main');
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("El Email ya existe"))
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rellene los espacios en blanco"))
      );
    }

  }
}

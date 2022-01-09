import 'package:flutter/material.dart';
import 'package:project_consultas/config.dart';
import 'package:project_consultas/services/user_services.dart';
import 'package:project_consultas/widgets/textAuthRedirectWidget.dart';
import 'package:project_consultas/widgets/textFormWidget.dart';
import 'package:project_consultas/widgets/titleAuthWidget.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController(text: 'maria@gmail.com');

  final userPassController = TextEditingController(text: '123456');

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
                  margin: EdgeInsets.only(top: 55),
                  child: TitleAuthWidget(
                    text: 'Login',
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 55),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColorText
                    ),
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(25),
                        padding: EdgeInsets.only(top: 25),
                        child: TextFormWidget(
                          contrasenia: false, 
                          textController: this.userNameController, 
                          inputText: 'Email',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(25),
                        padding: EdgeInsets.only(top: 25, bottom: 45),
                        child: TextFormWidget(
                          textController: this.userPassController, 
                          contrasenia: true, 
                          inputText: 'Password',
                        )
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    
                    this._login(context);

                  }, 
                  style: TextButton.styleFrom(
                    side: BorderSide(
                      color: primaryColorText
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 84, vertical: 14)
                  ),
                  child: Text(
                    'Login'.toUpperCase(),
                    style: TextStyle(
                      color: primaryColorText,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),
                  )
                ),
                TextAuthRedirectWidget(
                  text: 'Si no tienes una cuenta, ingresa aqui', 
                  url: 'register',
                )
              ],
            ),
          ),
        )
       ),
    );
  }

  void _login(context) async{

    var email = this.userNameController.text;
    var password = this.userPassController.text;

    if (email.length > 0 && password.length > 0){
      
      var data = {
        "Email"       : email,
        "Contrasenia" : password
      };

      var estado =await this.userServices.login(data);

      if (estado){
        Navigator.pushNamed(context, 'main');
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Datos incorrectos"))
        );
      }

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rellene los espacios en blanco"))
      );
    }


  }
}


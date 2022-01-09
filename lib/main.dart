import 'package:flutter/material.dart';
import 'package:project_consultas/constant/speechToText.dart';
import 'package:project_consultas/pages/cancer.dart';
import 'package:project_consultas/pages/login.dart';
import 'package:project_consultas/pages/presentacion.dart';
import 'package:project_consultas/pages/register.dart';
import 'package:project_consultas/pages/index.dart';
import 'package:project_consultas/pages/sintomas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    SpeechToTextConst();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'presentacion',
      routes: {
        'presentacion'  : (_) => PresentacionPage(),
        'login'         : (_) => LoginPage(),
        'register'      : (_) => RegisterPage(),
        'main'          : (_) => IndexPage(),
        'sintomas'      : (_) => SintomasPage(),
        'cancer'        : (_) => CancerPage(),
      },
    );
  }
}

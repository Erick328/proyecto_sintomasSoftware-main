// import 'package:project_consultas/models/user_model.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:project_consultas/models/user_model.dart';

class UserServices{

  static var usuario = new UserModel();
  var ref;

  UserServices(){
    final referenceDatabase = FirebaseDatabase.instance;
    this.ref = referenceDatabase.reference();
  }

  Future<bool> registro(data) async{

    bool estado = true;

    var resp = await this.ref.child('Usuarios').get();
    var mapa = Map<String, dynamic>.from(resp.value);
    mapa.forEach((key, value) {
      if(value["Email"] == data["Email"]){
        estado = false;
      }
    });

    if (estado){
      await this.ref.child('Usuarios').push().set(data).asStream();

      var resp = await this.ref.child('Usuarios').get();
      var mapa = Map<String, dynamic>.from(resp.value);
      mapa.forEach((key, value) {
        if(value["Email"] == data["Email"]){
          usuario.id = key;
          usuario.nombre = value["Nombre"];
        }
      });

    }
    print(usuario);
    return estado;
  }

  Future<bool> login(data) async{

    bool estado = false;

    var resp = await this.ref.child('Usuarios').get();


    var mapa = Map<String, dynamic>.from(resp.value);
    mapa.forEach((key, value) {
      
      print(data["Contrasenia"]);

      if(value["Email"] == data["Email"] && value["Contrasenia"] == data["Contrasenia"]){
        usuario.id = key;
        usuario.nombre = value["Nombre"];

        estado = true;
      }
    });

    return estado;
  }



}
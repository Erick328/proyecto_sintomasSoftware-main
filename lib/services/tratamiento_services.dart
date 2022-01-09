import 'package:firebase_database/firebase_database.dart';
import 'package:project_consultas/models/tratamiento_model.dart';

class TratamientoServices{

  var ref;

  TratamientoServices(){
    final referenceDatabase = FirebaseDatabase.instance;
    this.ref = referenceDatabase.reference();
  }

  Future<TratamientoModel> getTratamiento(String enfermedad) async{

    TratamientoModel listaTratamientos = TratamientoModel();
    var resp = await this.ref.child('Tratamiento').get();
    var mapa = Map<String, dynamic>.from(resp.value);
    mapa.forEach((key, value) {
      if (key == enfermedad){
        value.forEach((element) => {
          if (element != null){
            listaTratamientos.tratamiento.add(element)
          }
        });
      }

    });

    return listaTratamientos;
  }

}
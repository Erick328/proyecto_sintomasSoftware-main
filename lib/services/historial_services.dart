import 'package:firebase_database/firebase_database.dart';
import 'package:project_consultas/models/historiales_model.dart';

class HistorialServices{

  var ref;

  HistorialServices(){
    final referenceDatabase = FirebaseDatabase.instance;
    this.ref = referenceDatabase.reference();
  }

  Future<List<HistorialModel>> getHistorial(String idUser) async{

    List<HistorialModel> historialModel = [];

    var respHistorial = await this.ref.child('Agenda').get();
    var respEspecialistas = await this.ref.child('Especialistas').get();

    var mapaHistorial = Map<String, dynamic>.from(respHistorial.value);
    var especialistas = Map<String, dynamic>.from(respEspecialistas.value);
    
    mapaHistorial.forEach((key, value) {
      
      if(value["IdUsuario"] == idUser){
        HistorialModel historial = HistorialModel();
        historial.enfermedad = value["Enfermedad"];
        historial.fecha = value["Fecha"];
        historial.fechaReserva = value["FechaReserva"];
        if (value["Historial"] != null) historial.historial = value["Historial"];
        else historial.historial = 'none';
        // print(value["IdEspecialista"]);
        historial.nombreEspecialista = getNombreEspecialista(value["IdEspecialista"], especialistas);
        // print('${getNombreEspecialista(value["idEspecialista"], especialistas)} <-----');
        historialModel.add(historial);
      }

    });

    return historialModel;
  }


  String getNombreEspecialista(idEspecialista, especialistas){
    // print(idEspecialista);
    var nombre = '';

    especialistas.forEach((key, value) {
      if (key == idEspecialista) nombre = value['nombre'];
    });
    
    return nombre;
  }

}
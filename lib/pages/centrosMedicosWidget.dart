import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_map/flutter_map.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:latlong/latlong.dart';

class CentrosMedicosWidget extends StatefulWidget {
  const CentrosMedicosWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CentrosMedicosWidgetState createState() => _CentrosMedicosWidgetState();
}

class _CentrosMedicosWidgetState extends State<CentrosMedicosWidget> {
  @override
  Widget build(BuildContext context) {

    var nombreController = TextEditingController();
    var telefonoController = TextEditingController();

    return Container(
      child: new FlutterMap(
        options: new MapOptions(
          minZoom: 10.0,
          center: new LatLng(
            -17.7844813, -63.1934366
          )
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a','b','c']
          ),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 65.0,
                height: 65.0,
                point: new LatLng(-17.765829210400412, -63.17018306290623),
                builder: (context)=> new Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print('Prosalud Alemana, telefono none');
                      setState(() {
                        nombreController.text = 'Prosalud Alemana';
                        telefonoController.text = '3 3334515';
                      });
                    }
                  ),
                )
              ),
              new Marker(
                width: 65.0,
                height: 65.0,
                point: new LatLng(-17.774221031846924, -63.18365162053654),
                builder: (context)=> new Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print('Hospital de Clínicas Santa Cruz Teléfono: 71563567');
                      setState(() {
                        nombreController.text = 'Hospital de Clínicas Santa Cruz';
                        telefonoController.text = '71563567';
                      });
                    }
                  ),
                )
              ),
              new Marker(
                width: 65.0,
                height: 65.0,
                point: new LatLng(-17.780622539646636, -63.18649323299946),
                builder: (context)=> new Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print('Hospital de Niños Dr. Mario Ortíz Suárez telefonoController 3 3371110');
                      setState(() {
                        nombreController.text = 'Hospital de Niños Dr. Mario Ortíz Suárez';
                        telefonoController.text = '3 3371110';
                      });
                    }
                  ),
                )
              ),
              new Marker(
                width: 65.0,
                height: 65.0,
                point: new LatLng(-17.78379705739407, -63.187105146751556),
                builder: (context)=> new Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print('Hospital Cossmil telefonoController 3 3324411');
                      setState(() {
                        nombreController.text = 'Hospital Cossmil';
                        telefonoController.text = '3 3324411';
                      });
                    }
                  ),
                )
              ),
              new Marker(
                width: 65.0,
                height: 65.0,
                point: new LatLng(-17.802032964559416, -63.18352197074815),
                builder: (context)=> new Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print('Centro Médico Elvira Wunderlich telefonoController 3 3579524');
                      setState(() {
                        nombreController.text = 'Centro Médico Elvira Wunderlich';
                        telefonoController.text = '3 3579524';
                      });
                    }
                  ),
                )
              ),
              new Marker(
                width: 65.0,
                height: 65.0,
                point: new LatLng(-17.772521846510603, -63.155016567707385),
                builder: (context)=> new Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print('Hospital Japonés de Tercer Nivel telefonoController 3 3462031');
                      setState(() {
                        nombreController.text = 'Hospital Japonés de Tercer Nivel';
                        telefonoController.text = '3 3462031';
                      });
                    }
                  ),
                )
              ),
              new Marker(
                width: 65.0,
                height: 65.0,
                point: new LatLng(-17.783511712065536, -63.17242163711923),
                builder: (context)=> new Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print('Clinica Niño Jesus 2 telefonoController 3 3342883');
                      setState(() {
                        nombreController.text = 'Clinica Niño Jesus 2';
                        telefonoController.text = '3 3342883';
                      });
                    }
                  ),
                )
              ),
              new Marker(
                width: 65.0,
                height: 65.0,
                point: new LatLng(-17.79023194003584, -63.1728300787574),
                builder: (context)=> new Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print('Clínica Santa María telefonoController 3 3352001');
                      setState(() {
                        nombreController.text = 'Clínica Santa María';
                        telefonoController.text = '3 3352001';
                      });
                    }
                  ),
                )
              ),
              new Marker(
                width: 65.0,
                height: 65.0,
                point: new LatLng(-17.781825922499568, -63.200582531157565),
                builder: (context)=> new Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print('Centro De Salud San Luis telefonoController 3 3538270');
                      setState(() {
                        nombreController.text = 'Centro De Salud San Luis';
                        telefonoController.text = '3 3538270';
                      });
                    }
                  ),
                )
              ),
            ]
          )
        ]
      ),
    );
  }
}
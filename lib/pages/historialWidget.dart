import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:project_consultas/config.dart';
import 'package:project_consultas/models/historiales_model.dart';
// import 'package:project_consultas/pages/pdfPreviewScreen.dart';
import 'package:project_consultas/services/historial_services.dart';
import 'package:project_consultas/services/user_services.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart' as ps;
import 'mobile.dart';

import 'package:intl/intl.Dart';

class HistorialWidget extends StatefulWidget {
  const HistorialWidget({
    Key? key,
  }) : super(key: key);

  @override
  _HistorialWidgetState createState() => _HistorialWidgetState();
}

class _HistorialWidgetState extends State<HistorialWidget> {

  final user = UserServices.usuario;

  List<HistorialModel> listaHistorial = [];


  @override
  Widget build(BuildContext context){

    var historialServices = HistorialServices();

    return Container(
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              
              future: historialServices.getHistorial(this.user.id),
              
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData){
                  this.listaHistorial = snapshot.data;
                  return _historialWidget(snapshot.data);
                } else{
                  return Container(
                    child: Center(
                      child: Text(
                        'Cargando...',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                    ),
                  );
                }
              },
              
            )
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: TextButton(
              onPressed: () async{

                this._createPDF(this.listaHistorial);

              },
              style: TextButton.styleFrom(
                side: BorderSide(
                  color: primaryColor
                ),
                padding: EdgeInsets.symmetric(horizontal: 84, vertical: 14)
              ),
              child: Text(
                'Descargar'.toUpperCase(),
                style: TextStyle(
                  color: primaryColor
                ),
              ),
            )
          )
        ],
      )
    );
  }

  ListView _historialWidget(List<HistorialModel> historial) {

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: historial.length,
      itemBuilder: (BuildContext context, int index) => Card(
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: FaIcon(FontAwesomeIcons.calendarPlus),
              title: Text(
                historial[index].enfermedad
              ),
              subtitle: Text(
                'Especialista: ' + historial[index].nombreEspecialista
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children:[
                  SizedBox(width: 8),
                  
                  Text(historial[index].fechaReserva),
                  Expanded(child: Container()),
                  
                  (historial[index].historial != 'none') 
                    ? TextButton(
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Historial'),
                            content: Text(historial[index].historial),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                        child: Text('Ver Historial')
                      )
                    : Container(),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<void> _createPDF(List<HistorialModel> historial) async{

    ps.PdfDocument document = ps.PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString(
      'Historial', 
      ps.PdfStandardFont(ps.PdfFontFamily.helvetica, 30)
    );

    ps.PdfGrid grid = ps.PdfGrid();
    grid.columns.add(count: 4);
    grid.headers.add(1);

    ps.PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Fecha';
    header.cells[1].value = 'Enfermedad';
    header.cells[2].value = 'Nombre del Especialista';
    header.cells[3].value = 'Historial';

    
    ps.PdfGridRow row = grid.rows.add();
    
    historial.forEach((HistorialModel element) {

      if (element.historial != 'none'){
        row = grid.rows.add();
        row.cells[0].value = element.fecha;
        row.cells[1].value = element.enfermedad;
        row.cells[2].value = element.nombreEspecialista;
        row.cells[3].value = element.historial;
      }

    });

    grid.draw(
      page: page,
      bounds: const Rect.fromLTWH(0, 70, 0, 0)
    );

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Historial.pdf');
  }

}
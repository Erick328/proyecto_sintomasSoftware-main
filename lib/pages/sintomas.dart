import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_consultas/config.dart';
import 'package:project_consultas/constant/speechToText.dart';
import 'package:project_consultas/services/dialogflow.dart';
import 'package:project_consultas/services/user_services.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;


class SintomasPage extends StatefulWidget {

  @override
  _SintomasPageState createState() => _SintomasPageState();
}

class _SintomasPageState extends State<SintomasPage> {

  final mensajeControlador = TextEditingController();

  final textController = TextEditingController();
  
  List<Map> mensajes = [];
  bool controlEscuchar = false;


  final speech = SpeechToTextConst.speechToText;

  
  FlutterTts _flutterTts = FlutterTts();
  final dialogFlowService = DialogFlow();
  bool _isListening = false;
  bool _loading = false;
  bool _isPlaying = false;

  // final primerMensaje = 'Hola, ¿me puede decir que síntomas presenta por favor?';
  final primerMensaje = 'Hola, ¿cuales son los sintomas?';

  final user = UserServices.usuario;

  @override
  void initState() {
    super.initState();
    this.mensajes.insert(0, {
      'enviado': 'asistente',
      'text': primerMensaje
    });
    this._initializateTts();  

    this._speak(primerMensaje);
  }

  @override
  void dispose() {
    super.dispose();
    this._flutterTts.stop();

  }

  @override
  Widget build(BuildContext context) {


    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String text = arguments['text'];


    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 35),
                width: double.infinity,
                color: primaryColor,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: IconButton(
                          iconSize: 24,
                          alignment: Alignment.centerLeft,
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          icon: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: primaryColorText,
                          ),
                        )
                      ),
                    ),
                    Text(
                      text.toUpperCase(),
                      style: TextStyle(
                        color: primaryColorText,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              Expanded(

                child: Container(
                  
                  margin: EdgeInsets.all(25),

                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    reverse: false,
                    itemCount: this.mensajes.length,
                    itemBuilder: (context, index) => Container(
                        child: Align(
                          
                          alignment: (
                            (this.mensajes[index]["enviado"] == "user") 
                              ? Alignment.centerRight
                              : Alignment.centerLeft
                          ),
    
                          child: Container(
                            margin: (
                              (this.mensajes[index]["enviado"] == "user") 
                                ? EdgeInsets.only(
                                  top: 4, 
                                  bottom: 4, 
                                  left: 60
                                )
                                : EdgeInsets.only(
                                  top: 4, 
                                  bottom: 4, 
                                  right: 60
                                )
                            ),
    
                            padding: EdgeInsets.symmetric(
                              horizontal: 16, 
                              vertical: 8
                            ),
                            
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.blue,
                                width: 1.8
                              ),
                              borderRadius: (
                                this.mensajes[index]["enviado"] == "user" 
                                  
                                  ? BorderRadius.only(
                                    bottomLeft: Radius.circular(15), 
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)
                                  ) 
                                  
                                  : BorderRadius.only(
                                    bottomRight: Radius.circular(15), 
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)
                                  )
                              )
                            ),
                            child: Column(
                              children: [
                                Text(
                                  this.mensajes[index]["text"].toString()
                                ),

                                ( this.mensajes[index]["alerta"] == true ) ?
                                TextButton(
                                  onPressed: (){

                                    var enfermedad = '';
                                    if (text == 'Síntomas Coronavirus'){
                                      enfermedad = 'Coronavirus';
                                    }else if(text == 'Síntomas Dengue'){
                                      enfermedad = 'Dengue';
                                    }else{
                                      enfermedad = 'Varicela';
                                    }
                                    Navigator.popAndPushNamed(context, 'tratamiento', arguments: {'enfermedad': enfermedad});
                                  }, 
                                  child: Text('Ver tratamiento')
                                ) : Container(
                                  width: 0,
                                  height: 0,
                                )
                              ],
                            ),
                          ),
                        )
                    )
                  ),
                )

              ),


              Container(
                padding: EdgeInsets.only(top: 10, bottom: 80, right: 10, left: 10),
                color: primaryColor,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                      ),
                    ),
                    IconButton(
                      onPressed: (){

                        int cantidad = this.mensajes.length;

                        setState(() {
                          this.mensajes.insert(cantidad, {
                            "enviado": "user",
                            "text": this.textController.text,
                            "alerta": false
                          });
                        });

                        this._enviarMensaje('${this.textController.text}', text);
                        this.textController.text = '';
                      }, 
                      icon: Icon(Icons.send, color: Colors.white,)
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            this._flutterTts.stop();
            this.escuchar(text);
          },
          backgroundColor: Colors.white,
          
          child: Icon(
            (!this._isListening)? Icons.mic : Icons.mic_off,
            color: primaryColor,
          ),
        ),
      ),
    );
  }


  void escuchar(String text) async{
    if (!this._isListening){
      bool available = await this.speech.initialize( onStatus: (val){}, onError: (err) {print(err);});
      if ( available ) {
        
        this._isListening = true;

        this.speech.listen( onResult: (val) {
          this.mensajeControlador.text = val.recognizedWords;
          if(this.speech.isNotListening){
            if (this.mensajeControlador.text.trim().length > 0){

              this._isListening = false;

              int cantidad = this.mensajes.length;

              setState(() {
                this.mensajes.insert(cantidad, {
                  "enviado": "user",
                  "text": this.mensajeControlador.text,
                  "alerta": false
                });
              });

              this._enviarMensaje('${this.mensajeControlador.text}', text);
            }
          }
        });


      }
      else {
          print("The user has denied the use of speech recognition.");
      }

    }else{

      this.speech.stop();
      this._isListening = false;

    }

  }

  void _enviarMensaje(String texto, text) async{
    this._loading = true;
    String textoCompleto = text + ' ' + texto;
    print(textoCompleto);

    var textResp = await this.dialogFlowService.sendMessage(textoCompleto, this.user.id);

    this._loading = false;

    int cantidad = this.mensajes.length;
    
    var alerta = false;

    setState(() {
      this.mensajes.insert(cantidad, {
        "enviado": "bot",
        "text": textResp,
        "alerta": alerta
      });
      
      this._speak(textResp);
      
    });


  }

  

  void _initializateTts() {

    this._setTtsLanguaje();
    this._speechSetting();

    this._flutterTts.setStartHandler(() {
      setState(() {
        _isPlaying = true;
      });
    });

    this._flutterTts.setCompletionHandler(() {
      setState(() {
        this._isPlaying = false;
      });
    });

    this._flutterTts.setErrorHandler((err) {
      setState(() {
        print("error ocurred" + err);
        this._isPlaying = false;
      });
    });
  }



  void _setTtsLanguaje() async{
    this._flutterTts.setLanguage("es-ES");
    // print(await this._flutterTts.getVoices);
  }



  void _speechSetting() {
    this._flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    
    this._flutterTts.setPitch(1.0);
    this._flutterTts.setSpeechRate(0.6);
  }


  Future _speak(String text) async{
    if (text.length > 0){
      var result = await _flutterTts.speak(text);
      if (result == 1){
        setState(() {
          this._isPlaying = true;
        });
      }
    }
  }

  Future _stop() async{
    var result = await this._flutterTts.stop();
    if (result == 1){
      setState(() {
        this._isPlaying = false;
      });
    }
  }

}
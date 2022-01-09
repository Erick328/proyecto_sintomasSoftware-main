// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_dialogflow_v2/flutter_dialogflow_v2.dart';

class DialogFlow{

  DialogFlow();

  Future<String> sendMessage(String texto, String idUsuario) async{

    AuthGoogle authGoogle = await AuthGoogle(
      fileJson: 'assets/services.json'
    ).build();

    Dialogflow dialogFlow = Dialogflow(authGoogle: authGoogle);


    Map<String, String> payload = {
      "IdUsuario": idUsuario
    };


    DetectIntentResponse aiResponse = await dialogFlow.detectIntent(
      DetectIntentRequest(
        queryInput: QueryInput(
          text: TextInput(
            text: texto,
            languageCode: Language.spanish,
          ),
        ),
        queryParams: QueryParameters(
          resetContexts: false,
          payload: payload
        ),
      ),
    );

    String respuesta = aiResponse.queryResult.fulfillmentText;

    return respuesta;
  }

}
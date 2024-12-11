import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey =
      'tu_clave_de_api_aqui'; // Coloca tu clave de API de OpenAI
  final String _url = 'https://api.openai.com/v1/completions';

  Future<String> obtenerInformacionNutricional(String query) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: json.encode({
        'model': 'gpt-4', // Puedes usar otros modelos si lo deseas
        'prompt': 'Cuáles son los valores nutricionales de $query?',
        'max_tokens': 100,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['text'].toString();
    } else {
      throw 'Error en la solicitud: ${response.statusCode}';
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fep/config/index.dart';
import 'package:http_parser/http_parser.dart';

// ignore: constant_identifier_names
enum Method { GET, POST, PUT, DELETE }

class ImageData {
  final String
      fileKey; // Nombre del campo para el archivo en el formulario POST
  final String filePath; // Ruta del archivo

  ImageData({required this.fileKey, required this.filePath});
}

class ApiService {
  final String? baseUrl;

  ApiService({this.baseUrl = API_URL});

  Future<dynamic> fetchData(
    String endpoint, {
    Method method = Method.GET,
    Map<String, dynamic>? body,
    String? authorization,
  }) async {
    try {
      http.Response response;

      final url = Uri.parse('$baseUrl/$endpoint');

      final headers = {
        "Content-Type": "application/json",
      };

      if (authorization != null) {
        headers['Authorization'] = authorization;
      }

      switch (method) {
        case Method.GET:
          response = await http.get(
            url,
            headers: headers,
          );
          break;
        case Method.POST:
          response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          break;
        case Method.PUT:
          response =
              await http.put(url, headers: headers, body: jsonEncode(body));
          break;
        case Method.DELETE:
          response = await http.delete(url, headers: headers);
          break;
      }

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 422) {
        final error = jsonDecode(response.body);
        String errorMessage = '';

        for (var key in error.keys) {
          errorMessage += error[key] + '\n';
        }
        errorMessage = errorMessage.trimRight();
        throw (errorMessage);
      } else if (response.statusCode == 500) {
        final error = jsonDecode(response.body);
        throw (error['error']);
      } else {
        // return jsonDecode(response.body);
        final error = jsonDecode(response.body);

        throw (error['error']);
      }
    } on Exception catch (_) {
      return Future.error(_);
    }
  }

  Future<dynamic> uploadImages(
    String endpoint,
    List<ImageData> images, {
    String? authorization,
    Map<String, String>? extraFields, // Parámetros adicionales
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint');
      final request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'Authorization': authorization ?? '',
          'Content-Type': 'multipart/form-data',
        });

      // Agregar parámetros adicionales (si los hay) al cuerpo de la solicitud
      if (extraFields != null) {
        extraFields.forEach((key, value) {
          request.fields[key] = value;
        });
      }

      // Iterar sobre la lista de imágenes y agregar cada una al request
      for (var image in images) {
        final file = File(image.filePath);
        final fileKey = image
            .fileKey; // Usamos fileKey como nombre del campo en el formulario

        // Añadir la imagen al cuerpo de la solicitud con el nombre del campo dinámico
        request.files.add(await http.MultipartFile.fromPath(
          fileKey, // Usar el valor de fileKey como el nombre del campo
          file.path,
          filename: file.uri.pathSegments
              .last, // Nombre del archivo (puedes ajustarlo si lo necesitas)
          contentType:
              MediaType('image', 'jpeg'), // Ajusta según el tipo de imagen
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        print("Imágenes enviadas correctamente");
        // Obtener el cuerpo de la respuesta
        final responseBody = await response.stream.bytesToString();

        // Convertir el cuerpo de la respuesta a un objeto JSON
        final jsonResponse = jsonDecode(responseBody);

        return jsonResponse; // Devuelve el objeto JSON
      } else {
        print("Error al enviar las imágenes: ${response.statusCode}");
        final responseBody = await response.stream.bytesToString();
        print("Respuesta: $responseBody");
        return null; // O puedes devolver un valor predeterminado en caso de error
      }
    } catch (e) {
      print("Error al enviar las imágenes: $e");
      return null;
    }
  }
}

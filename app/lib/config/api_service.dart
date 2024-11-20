import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fep/config/index.dart';

// ignore: constant_identifier_names
enum Method { GET, POST, PUT, DELETE }

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
        return jsonDecode(response.body);
      }
    } on Exception catch (_) {
      // ignore: no_wildcard_variable_uses
      return Future.error(_);
    }
  }
}

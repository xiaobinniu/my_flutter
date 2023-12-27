import 'dart:async';

import './api.dart' as config;
import 'package:http/http.dart' as http;
import 'dart:convert'; // json解析库

class HttpClient {
  String apiKey = config.apiKey;
  final String endpoint;

  HttpClient(this.endpoint);

  Future<Map<String, dynamic>> postRequest(
      Map<String, dynamic> requestData) async {
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(requestData),
      );

      print(response.body);

      return jsonDecode(response.body);
    } catch (error) {
      // 捕获其他异常，返回包含错误消息的响应
      throw {
        'error': 'catch HttpClient Error: $error',
      };
    }
  }

  Future<Map<String, dynamic>> getRequest(
      Map<String, String> queryParams) async {
    try {
      final response = await http.get(
        Uri.parse(_buildUrlWithQueryParams(endpoint, queryParams)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            "Error: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (error) {
      throw Exception("Error: $error");
    }
  }
}

String _buildUrlWithQueryParams(
    String endpoint, Map<String, String> queryParams) {
  if (queryParams.isEmpty) {
    return endpoint;
  }

  final uri = Uri.parse(endpoint);
  final uriWithParams = uri.replace(queryParameters: queryParams);
  return uriWithParams.toString();
}

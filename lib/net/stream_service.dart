import 'dart:async';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

// ignore: constant_identifier_names
const String Base = "http://192.168.0.252:3000/stream";

class StreamService {
  late final String serverUrl;
  late http.Client _client;

  StreamService(this.serverUrl) {
    _client = http.Client();
  }

  Future<void> sendStreamMessage(
      String? message, void Function(String) onDataReceived) async {
    final http.Request request = http.Request('POST', Uri.parse(serverUrl));
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode({'message': message});
    final http.StreamedResponse response = await _client.send(request);
    if (response.statusCode == 200) {
      response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen((String line) {
        onDataReceived(line);
        if (line == "done") {
          dispose();
        }
      });
    } else {
      debugPrint(
        'Failed to connect to the server. Status code: ${response.statusCode}',
      );
    }
  }

  void dispose() {
    _client.close();
  }
}

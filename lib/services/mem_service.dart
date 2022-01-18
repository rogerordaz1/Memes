import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizacionversion2/models/now_response.dart';

class MemService extends ChangeNotifier {
  final String _baseUrl = "78.108.216.56:1338";
  final String apiToken = "";
  List<Imagen> ondisplay = [];

  MemService() {
    getMemes();
  }

  getMemes() async {
    String memeUrl = '';
    final url = Uri.http(_baseUrl, '/memes');

    final response = await http.get(url);

    final List<dynamic> decodedResp = json.decode(response.body);
    for (var i = 0; i < decodedResp.length; i++) {
      final Map<String, dynamic> resp = decodedResp[i];
      final respuesta = Memes.fromMap(resp);
      ondisplay.addAll(respuesta.image);
    }

    print(ondisplay.length);
  }
}

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizacionversion2/models/now_response.dart';

class MemService extends ChangeNotifier {
  final String _baseUrl = "78.108.216.56:1338";
  final String apiToken = "";
  List<Imagen> ondisplay = [];
  final storage = const FlutterSecureStorage();
  bool navegar = false;

  MemService() {
    getMemes();
    print('Servicio inicializado');
    print(ondisplay);
  }

  Future<List<Imagen>> getMemes() async {
    final url = Uri.http(_baseUrl, '/memes');

    final response = await http.get(url);

    final List<dynamic> decodedResp = json.decode(response.body);
    for (var i = 0; i < decodedResp.length; i++) {
      final Map<String, dynamic> resp = decodedResp[i];
      final respuesta = Memes.fromMap(resp);
      ondisplay = [...ondisplay, ...respuesta.image];
    }

    notifyListeners();
    return ondisplay;
  }

  subirMemes(var path) async {
    var headers = {
      'Authorization':
          'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjQyNjA2NjQ5LCJleHAiOjE2NDUxOTg2NDl9.4cl5y1L-c10BTsl3xf7DNoYpfmvCwZcakpO1h3a8qJ0'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://78.108.216.56:1338/memes'));
    request.fields.addAll({'data': '{ }'});
    request.files.add(await http.MultipartFile.fromPath('files.image', path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //   print(await response.stream.bytesToString());
    } else {
      //  print(response.reasonPhrase);
    }
  }
}

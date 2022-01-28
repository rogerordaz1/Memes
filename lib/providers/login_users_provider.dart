import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginUsersPoriver extends ChangeNotifier {
  bool navegar = false;
  final storage = const FlutterSecureStorage();

  final String _baseUrl = "78.108.216.56:1338";

  Future<String?> loginUser(String correo, String password) async {
    final Map<String, dynamic> authData = {
      "identifier": correo,
      "password": password,
    };

    final url = Uri.http(_baseUrl, '/auth/local');

    final response = await http.post(url, body: {
      'identifier': authData['identifier'],
      'password': authData['password']
    });

    if (response.statusCode == 200) {
      navegar = true;
    }

    final Map<String, dynamic> decodedResp = json.decode(response.body);

    if (decodedResp.containsKey('jwt')) {
      await storage.write(key: 'token', value: decodedResp['jwt']);
      return null;
    } else {
      return 'Usuario o Contraseña mal escrita.';
    }

    //  print(x);
  }

  Future<String?> register(
      String username, String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://78.108.216.56:1338/auth/local/register'));
    request.body = json
        .encode({"username": username, "email": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    notifyListeners();
  }
}

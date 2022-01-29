import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizacionversion2/models/now_response.dart';
import 'package:localizacionversion2/providers/login_form_provider.dart';
import 'package:localizacionversion2/providers/login_users_provider.dart';
import 'package:provider/provider.dart';

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

      print(respuesta.idUser['username']);
      ondisplay = [...ondisplay, ...respuesta.image];
    }

    notifyListeners();
    return ondisplay;
  }

  subirMemes(var img, BuildContext context) async {
    final authService = Provider.of<LoginUsersPoriver>(context, listen: false);
    String id = await authService.readDataFromStorage('id_user');
    String jwt = await authService.readDataFromStorage('token');
    int iduser = int.parse(id);

    var headers = {'Authorization': 'bearer $jwt'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://78.108.216.56:1338/memes'));
    request.fields.addAll({'data': '{ "title":"adonys","id_user": "$iduser"}'});
    request.files.add(await http.MultipartFile.fromPath('files.image', img));
    request.headers.addAll(headers);

    EasyLoading.show(status: 'Uploading...');
    http.StreamedResponse response = await http.Client().send(request);

    if (response.statusCode == 200) {
      EasyLoading.showSuccess('Done!');
      Navigator.pop(context);
      EasyLoading.dismiss();
      Navigator.pushNamed(context, 'home');
    } else {
      print("error al subir imagen");
    }
  }
}

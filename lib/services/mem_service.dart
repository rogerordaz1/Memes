import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizacionversion2/models/now_response.dart';
import 'package:localizacionversion2/providers/login_users_provider.dart';
import 'package:provider/provider.dart';

class MemService extends ChangeNotifier {
  final String _baseUrl = "78.108.216.56:1338";
  final String apiToken = "";
  List<Imagen> ondisplay = [];
  List<User> user = [];
  List<int> idmeme = [];
  List<int> likes = [];
  int i = 0;
  final storage = const FlutterSecureStorage();
  bool navegar = false;
  bool isliked = false;
  int cont = 0;
  List<dynamic> li = [];

  MemService() {
    getMemes();
    print('Servicio inicializado');
    print(ondisplay);
  }

  Future<List> getResponse() async {
    final url = Uri.http(_baseUrl, '/memes');
    final response = await http.get(url);
    final List<dynamic> decodedResp = json.decode(response.body);
    li = decodedResp;
    return decodedResp;
  }

  Future<List<Imagen>> getMemes() async {
    List<dynamic> decodedResp = await getResponse();
    for (var i = 0; i < decodedResp.length; i++) {
      final Map<String, dynamic> resp = decodedResp[i];
      final respuesta = Memes.fromMap(resp);

      //print(respuesta.idUser.username);
      ondisplay = [...ondisplay, ...respuesta.image];
      user = [...user, respuesta.idUser];
      // likes[i] = respuesta.likees;
      print(respuesta.likees.length);
      likes = [...likes, respuesta.likees.length];
      idmeme = [...idmeme, respuesta.id];
      print('Este es el id del meme' + idmeme[i].toString());
      print(likes[i]);
      print(user[i].username);
      print(user[i].id);
      print("La longitud de la lista de likes" +
          respuesta.likees.length.toString());
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

  Future<bool> verificarLiked(Future<int> id, int index) async {
    List<dynamic> decodedResp = li;

    final Map<String, dynamic> resp = decodedResp[index];
    final respuesta = Memes.fromMap(resp);
    isliked = false;
    for (var j = 0; j < respuesta.likees.length; j++) {
      if (await id == respuesta.likees[j].idUser) {
        isliked = true;
      }
    }
    cont++;
    print('Este es el index ' "$index");
    return isliked;
  }
}

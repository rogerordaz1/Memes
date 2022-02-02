import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'package:like_button/like_button.dart';
import 'package:localizacionversion2/models/now_response.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:localizacionversion2/providers/login_users_provider.dart';
import 'package:localizacionversion2/services/mem_service.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatefulWidget {
  final Imagen image;
  final User user;
  final int cantlikes;
  final int idmeme;

  const CustomCard(
      {Key? key,
      required this.image,
      required this.user,
      required this.cantlikes,
      required this.idmeme})
      : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool color = false;
  final storage = const FlutterSecureStorage();

  @override
  Widget build(
    BuildContext context,
  ) {
    final memService = Provider.of<MemService>(context);
    final authService = Provider.of<LoginUsersPoriver>(context);
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.45,
          child: GestureDetector(
            onTap: () {},
            child: FadeInImage.assetNetwork(
              fit: BoxFit.fill,
              placeholder: 'assets/cargando.gif',
              image: 'http://78.108.216.56:1338' + widget.image.url,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.supervised_user_circle_outlined),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.user.username),
                  const Text('Seguir'),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              FutureBuilder(
                future: memService.verificarLiked(authService.iduser),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data == true) {
                    return LikeButton(
                      isLiked: true,
                      likeCount: widget.cantlikes,
                    );
                  } else {
                    return LikeButton(
                      isLiked: false,
                      likeCount: widget.cantlikes,
                      onTap: (isLiked) => _agregarLikes(authService.iduser),
                    );
                  }
                },
              ),
              LikeButton(
                likeCount: 50,
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.share,
                    color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                    size: 30,
                  );
                },
              ),
              LikeButton(
                likeBuilder: (bool isLiked) {
                  return GestureDetector(
                    child: Icon(
                      Icons.downloading_sharp,
                      color: color ? Colors.blue : Colors.grey,
                      size: 30,
                    ),
                    onTap: () {
                      var http = 'http://78.108.216.56:1338' + widget.image.url;
                      _saveNetworkImage(http);
                    },
                  );
                },
                animationDuration: const Duration(seconds: 0),
              )
            ],
          ),
        ),
        const Divider(
          height: 5,
          color: Colors.black,
        ),
      ],
    );
  }

  // _actualizarValor(BuildContext context) async {
  //   final authService = Provider.of<LoginUsersPoriver>(context, listen: false);
  //   authService.iduser =
  //       int.parse(await authService.readDataFromStorage('id_user'));
  // }

  void _saveNetworkImage(var http) async {
    String path = http;
    GallerySaver.saveImage(path, albumName: 'Memeland Albun').then((success) {
      setState(() {
        color = true;
      });
    });
  }

  Future<bool> _agregarLikes(int idlogin) async {
    var headers = {
      '': '',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjQzNDY0MTM4LCJleHAiOjE2NDYwNTYxMzh9.OQxsFv1JH4tFzpH0Nq3M-0aajgWhWRc70dH-zRZCl-s',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('http://78.108.216.56:1338/likes'));
    request.body = json
        .encode({"action": 1, "id_user": idlogin, "id_meme": widget.idmeme});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}

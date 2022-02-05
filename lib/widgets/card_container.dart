import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final int index;
  final bool isliked = false;

  const CustomCard({
    Key? key,
    required this.index,
    required this.image,
    required this.user,
    required this.cantlikes,
    required this.idmeme,
  }) : super(key: key);

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
                future: memService.verificarLiked(
                    memService.verificarusuariologueado(), widget.index),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data == true) {
                    return LikeButton(
                      isLiked: true,
                      likeCount: widget.cantlikes,
                      onTap: (isLiked) => memService.eliminarLike(
                          memService.verificarusuariologueado(), widget.index),
                    );
                  } else {
                    return LikeButton(
                      isLiked: false,
                      likeCount: widget.cantlikes,
                      onTap: (isLiked) => memService.agregarLikes(
                          memService.verificarusuariologueado(), widget.idmeme),
                    );
                  }
                },
              ),
              LikeButton(
                likeCount: 50,
                likeBuilder: (isLiked) {
                  return Icon(
                    Icons.share,
                    color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                    size: 30,
                  );
                },
              ),
              LikeButton(
                likeBuilder: (isLiked) {
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

  void _saveNetworkImage(var http) async {
    String path = http;
    GallerySaver.saveImage(path, albumName: 'Memeland Albun').then((success) {
      setState(() {
        color = true;
      });
    });
  }
}

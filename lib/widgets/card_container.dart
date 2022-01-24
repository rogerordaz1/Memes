import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:localizacionversion2/models/now_response.dart';

//paquete de descargar imagenes.
import 'package:image_downloader/image_downloader.dart';

class CustomCard extends StatelessWidget {
  final Imagen image;

  const CustomCard({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
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
              image: 'http://78.108.216.56:1338' + image.url,
            ),
          ),
        ),
        // ignore: sized_box_for_whitespace
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.supervised_user_circle_outlined),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Javier Diaz'),
                  Text('Seguir'),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              const LikeButton(
                likeCount: 0,
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
                  return Icon(
                    Icons.downloading_sharp,
                    color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                    size: 30,
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
}

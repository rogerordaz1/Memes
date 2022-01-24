import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_editor/image_editor.dart' as editor;

import 'package:localizacionversion2/services/mem_service.dart';
import 'package:provider/provider.dart';

class SubirFoto extends StatefulWidget {
  const SubirFoto({Key? key}) : super(key: key);

  @override
  State<SubirFoto> createState() => _SubirFotoState();
}

class _SubirFotoState extends State<SubirFoto> {
  File? image;
  double progress = 0;
  Future selectedImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      // Future<File> testCompressAndGetFile(File file, String targetPath) async {
      //   var result = await FlutterImageCompress.compressAndGetFile(
      //     file.absolute.path,
      //     targetPath,
      //     quality: 95,
      //   );
      //   print(file.lengthSync());
      //   print(result!.lengthSync().bitLength);
      //   return result;
      // }

      final pathfoto = image.path;
      // final imagenRecortada = await testCompressAndGetFile(
      //     File(image.path), pathfoto + "local.jpg");
      _cutImage(File(image.path));
    } on PlatformException catch (e) {
      print('Fallo al cargar la imgen');
    }
  }

  _cutImage(imagen) async {
    File? cortado = await ImageCropper.cropImage(
        sourcePath: imagen.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Editar',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (cortado != null) {
      setState(() {
        image = cortado;
      });
    }
  }

  // Future<void> cropImage(File image) async {
  //   await ImageCropper.cropImage(
  //       sourcePath: image.path,
  //       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  //       aspectRatioPresets: [CropAspectRatioPreset.square]);
  // }

  @override
  Widget build(BuildContext context) {
    final memService = Provider.of<MemService>(context);

    return Scaffold(
      appBar: AppBar(
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            image == null
                ? Container(
                    width: 380,
                    height: 380,
                    color: Colors.grey[350],
                    child: GestureDetector(
                      onTap: () => selectedImage(),
                      child: const Icon(
                        Icons.upload_file_outlined,
                        color: Colors.blue,
                        size: 80,
                      ),
                    ),
                  )
                : Container(
                    width: 380,
                    height: 380,
                    color: Colors.grey[350],
                    child: Image.file(
                      image!,
                      fit: BoxFit.fill,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                    color: Colors.blue,
                    child: Text("Subir Meme"),
                    onPressed: () {
                      setState(() {
                        subirMemes(image!);
                      });
                    }),
                MaterialButton(
                    color: Colors.blue,
                    child: Text("Editar"),
                    onPressed: () => _cutImage(image)),
                MaterialButton(
                    color: Colors.blue,
                    child: Text("Add Texto"),
                    onPressed: () => _addText(image!)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    color: Colors.blue,
                    child: Text("Descartar Cambios"),
                    onPressed: () {
                      setState(() {
                        image = null;
                      });
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 20,
                  child: LinearPercentIndicator(
                    width: 140.0,
                    lineHeight: 14.0,
                    percent: progress,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                ),
                Text((progress * 100).toStringAsFixed(1)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  subirMemes(File img) async {
    var headers = {
      'Authorization':
          'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjQyNjA2NjQ5LCJleHAiOjE2NDUxOTg2NDl9.4cl5y1L-c10BTsl3xf7DNoYpfmvCwZcakpO1h3a8qJ0'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://78.108.216.56:1338/memes'));
    request.fields.addAll({'data': '{ }'});
    request.files
        .add(await http.MultipartFile.fromPath('files.image', img.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await http.Client().send(request);

    print(request.contentLength);
    List bytes = <int>[];

    // final contentLength = response.contentLength;

    // response.stream.listen((value) {
    //   print(value);
    //   bytes.addAll(value);

    //   setState(() {
    //     progress = bytes.length / contentLength!;
    //     print(contentLength);
    //   });
    // }, onDone: () async {
    //   setState(() {
    //     progress = 1;
    //   });
    // });
  }

  _addText(File image) async {
    File? newFoto = image;
    final editorOption = editor.ImageEditorOption();

    editorOption.addOption(editor.RotateOption(180));

    newFoto = await editor.ImageEditor.editFileImageAndGetFile(
        file: newFoto, imageEditorOption: editorOption);

    setState(() {
      image = newFoto!;
    });
  }
}

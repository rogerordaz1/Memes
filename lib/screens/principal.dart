import 'package:flutter/material.dart';
import 'package:localizacionversion2/services/mem_service.dart';
import 'package:localizacionversion2/widgets/card_container.dart';
import 'package:provider/provider.dart';

class Principal extends StatelessWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memService = Provider.of<MemService>(context);

    return ListView.builder(
        itemCount: memService.ondisplay.length,
        itemBuilder: (context, index) {
          return CustomCard(image: memService.ondisplay[index]);
        });
  }
}

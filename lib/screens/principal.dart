import 'package:flutter/material.dart';
import 'package:localizacionversion2/services/mem_service.dart';
import 'package:localizacionversion2/widgets/card_container.dart';
import 'package:provider/provider.dart';

class Principal extends StatefulWidget {
  final Function load;
  const Principal({Key? key, required this.load}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        widget.load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final memService = Provider.of<MemService>(context);

    return ListView.builder(
        controller: scrollController,
        itemCount: memService.ondisplay.length,
        itemBuilder: (context, index) {
          return CustomCard(image: memService.ondisplay[index]);
        });
  }
}

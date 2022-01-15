import 'package:flutter/material.dart';

class Barra extends StatelessWidget {
  const Barra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Text('hi'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:localizacionversion2/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvaider = Provider.of<Uiprovaider>(context);

    int currentIndex = uiProvaider.seleccionMenu;

    return BottomNavigationBar(
      onTap: (int i) => uiProvaider.selectOpcion = i,
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.house),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.toll_sharp),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: '',
        ),
      ],
    );
  }
}

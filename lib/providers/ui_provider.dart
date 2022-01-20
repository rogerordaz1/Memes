import 'package:flutter/material.dart';

class Uiprovaider extends ChangeNotifier {
  int seleccionMenu = 0;

  Uiprovaider() {
    seleccionMenu = 0;
  }

  int get selectOpcion {
    return seleccionMenu;
  }

  set selectOpcion(int i) {
    seleccionMenu = i;
    notifyListeners();
  }

  String devolverTitulo() {
    String x = '';

    if (seleccionMenu == 0) x = 'Sin limites';
    if (seleccionMenu == 1) x = 'Los mas Populares';
    if (seleccionMenu == 2) x = 'Tus Favoritos';

    return x;
  }
}

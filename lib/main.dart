import 'package:flutter/material.dart';
import 'package:localizacionversion2/screens/home.dart';
import 'package:localizacionversion2/screens/subir_foto.dart';
import 'package:localizacionversion2/services/mem_service.dart';
import 'package:provider/provider.dart';
import 'providers/ui_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Uiprovaider()),
        ChangeNotifierProvider(create: (_) => MemService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const HomePage(),
          'subir_foto': (BuildContext context) => const SubirFoto(),
        },
      ),
    );
  }
}

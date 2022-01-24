import 'package:flutter/material.dart';
import 'package:localizacionversion2/screens/home.dart';
import 'package:localizacionversion2/Login/login.dart';
import 'package:localizacionversion2/screens/subir_foto.dart';
import 'package:localizacionversion2/services/mem_service.dart';
import 'package:provider/provider.dart';
import 'providers/ui_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  configLoading();
  runApp(const Apptate());
}

class Apptate extends StatelessWidget {
  const Apptate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MemService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => Uiprovaider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const HomePage(),
        'subir_foto': (BuildContext context) => const SubirFoto(),
        'Login_page': (BuildContext context) => const LoginPage(),
        'home': (BuildContext context) => const HomePage(),
      },
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..toastPosition = EasyLoadingToastPosition.top
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 25.0
    ..radius = 10.0
    ..progressColor = Colors.yellow[200]
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.green
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

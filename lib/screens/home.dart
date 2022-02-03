import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localizacionversion2/providers/login_users_provider.dart';
import 'package:localizacionversion2/providers/ui_provider.dart';
import 'package:localizacionversion2/screens/principal.dart';
import 'package:localizacionversion2/screens/top_ten.dart';
import 'package:localizacionversion2/services/mem_service.dart';
import 'package:localizacionversion2/widgets/custom_navbar.dart';
import 'package:provider/provider.dart';
import 'favoritos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();
  late bool logueado;
  String? datos;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginUser = Provider.of<LoginUsersPoriver>(context);
    final uprovaider = Provider.of<Uiprovaider>(context);

    setState(() {
      logueado = loginUser.logueado;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          uprovaider.devolverTitulo(),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        // backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.cloud_upload_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                  onTap: () {
                    _showdialog();
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  child: FutureBuilder(
                    future: loginUser.readDataFromStorage('token'),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      datos = snapshot.data;
                      if (snapshot.data == "" || snapshot.hasData == false) {
                        return const Icon(
                          Icons.supervised_user_circle,
                          color: Colors.black,
                          size: 35,
                        );
                      } else {
                        return const Icon(Icons.logout_rounded,
                            color: Colors.black, size: 35);
                      }
                    },
                  ),
                  onTap: () {
                    if (datos != "") {
                      loginUser.logout();
                      Navigator.pushReplacementNamed(context, 'Login_page');
                    } else {
                      Navigator.pushReplacementNamed(context, 'Login_page');
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            Text(
              'Subir Imagen',
            ),
            Text('Crear Imagen'),
            Text(''),
            Text(''),
          ],
        ),
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const NavBar(),
    );
  }

  _showdialog() {
    final loginUser = Provider.of<LoginUsersPoriver>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: (datos != "")
              ? const Center(child: Text('Add Meme'))
              : const Center(child: Text('Log in for use the options')),
          content: SizedBox(
            height: 200,
            width: 100,
            child: FutureBuilder(
              future: loginUser.readDataFromStorage('token'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.data == "" || snapshot.hasData == false) {
                  return listViewOptions(Colors.grey, datos);
                } else {
                  return listViewOptions(Colors.blue[200]!, datos);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget listViewOptions(Color color, String? datos) {
    return ListView(
      children: [
        GestureDetector(
          onTap: () {
            if (datos != "") {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'subir_foto');
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.add_a_photo, color: color),
              const SizedBox(
                width: 10,
              ),
              const Text('Subir foto'),
            ],
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            if (datos != "") {
              //TODO:Here Put Code;
            }
          },
          child: Row(
            children: [
              Icon(Icons.add_circle, color: color),
              const SizedBox(
                width: 10,
              ),
              const Text('Crear foto'),
            ],
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            if (datos != "") {
              //TODO:Here Put Code;
              print('has tocado el menu');
            }
          },
          child: Row(
            children: [
              Icon(Icons.coffee, color: color),
              const SizedBox(
                width: 10,
              ),
              const Text('Donar'),
            ],
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            if (datos != "") {
              //TODO:Here Put Code;
            }
          },
          child: Row(
            children: [
              Icon(Icons.settings, color: color),
              const SizedBox(
                width: 10,
              ),
              const Text('Ajustes'),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiprovaider = Provider.of<Uiprovaider>(context);
    final memservice = Provider.of<MemService>(context);

    switch (uiprovaider.seleccionMenu) {
      case 0:
        return Principal(
          load: () {
            print("desde el home");
            // memservice.getMemes();
          },
        );

      case 1:
        return const TopTen();

      case 2:
        return const Favoritos();

      default:
        return const Favoritos();
    }
  }
}

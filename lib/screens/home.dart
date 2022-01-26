import 'package:flutter/material.dart';
import 'package:localizacionversion2/providers/ui_provider.dart';
import 'package:localizacionversion2/screens/principal.dart';
import 'package:localizacionversion2/screens/top_ten.dart';
import 'package:localizacionversion2/services/mem_service.dart';
import 'package:localizacionversion2/widgets/custom_navbar.dart';
import 'package:provider/provider.dart';
import 'favoritos.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uprovaider = Provider.of<Uiprovaider>(context);

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
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Center(child: Text('Add Meme')),
                          content: SizedBox(
                            height: 200,
                            width: 100,
                            child: ListView(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, 'subir_foto');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        color: Colors.blue[200],
                                      ),
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
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_circle,
                                        color: Colors.blue[200],
                                      ),
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
                                    print('has tocado el menu');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.coffee,
                                        color: Colors.blue[200],
                                      ),
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
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        color: Colors.blue[200],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text('Ajustes'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  child: const Icon(
                    Icons.supervised_user_circle,
                    color: Colors.black,
                    size: 35,
                  ),
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.pushNamed(context, 'Login_page');
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

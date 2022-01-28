import 'package:flutter/material.dart';
import 'package:localizacionversion2/providers/login_form_provider.dart';
import 'package:localizacionversion2/providers/login_users_provider.dart';
import 'package:localizacionversion2/services/mem_service.dart';
import 'package:localizacionversion2/services/notifications_service.dart';
import 'package:localizacionversion2/widgets/memscontainer.dart';
import 'package:localizacionversion2/widgets/auth_background.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool isHidden = true;
  bool controlcmail = false;
  bool controlcontrsena = false;
  bool respuestahttp = false;

  @override
  Widget build(BuildContext context) {
    final memService = Provider.of<MemService>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 100,
                left: 125,
                child: Container(
                    height: 140,
                    width: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                          image: AssetImage("assets/meme3.jpg"),
                          fit: BoxFit.fill),
                    )),
              ),
              Column(
                children: [
                  CardContainer(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ChangeNotifierProvider(
                          create: (_) => LoginFormProvider(),
                          child: const _LoginForm(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  bool isHidden = true;
  double? value = 1;
  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Column(
      children: [
        Stack(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 85, top: 100),
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  image: DecorationImage(
                      image: AssetImage("assets/gato1.jpg"), fit: BoxFit.fill),
                )),
            Container(
              margin: const EdgeInsets.only(top: 100, left: 1),
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                image: DecorationImage(
                    image: AssetImage("assets/perro2.jpg"), fit: BoxFit.fill),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: const Text(
            "Register",
            style: TextStyle(fontSize: 25),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        Form(
            key: loginForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) => loginForm.email = value,
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = RegExp(pattern);
                      return regExp.hasMatch(value ?? '')
                          ? null
                          : 'el valor no luce como un correo valido';
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        hintText: 'jhondo@gmail.com',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'Usuario o Correo electronico',
                        labelStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.supervised_user_circle_rounded,
                            color: Color.fromRGBO(93, 96, 239, 1))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) => loginForm.password = value,
                    validator: (value) {
                      if ((value != null && value.length > 5)) {
                        // controlcontrsena = true;
                        return null;
                      } else {
                        // controlcontrsena = false;
                        return "La contrasena debe tener 6 caracteres";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        hintText: '******',
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color.fromRGBO(93, 96, 239, 1),
                        ),
                        suffixIcon: IconButton(
                          onPressed: toggleVisibility,
                          icon: isHidden
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Color.fromRGBO(93, 96, 239, 1),
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Color.fromRGBO(93, 96, 239, 1),
                                ),
                        )),
                    obscureText: isHidden,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) => loginForm.username = value,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      hintText: 'John Doe',
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Color.fromRGBO(93, 96, 239, 1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: const Color.fromRGBO(93, 96, 239, 1),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            child: const Text(
                              'Get Access',
                              style: TextStyle(color: Colors.white70),
                            )),
                        onPressed: () async {
                          final authService = Provider.of<LoginUsersPoriver>(
                              context,
                              listen: false);

                          FocusScope.of(context).unfocus();

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              });

                          if (!loginForm.isValidForm()) {
                            Navigator.pop(context);
                          } else {
                            try {
                              final String? errorMesage = await authService
                                  .register(loginForm.username, loginForm.email,
                                      loginForm.password)
                                  .timeout(
                                const Duration(seconds: 10),
                                onTimeout: () {
                                  Navigator.pop(context);
                                  NotificationService.showSnackBar(
                                      context, "No hay conexion con el API");
                                },
                              );

                              if (!(errorMesage == null)) {
                                NotificationService.showSnackBar(
                                    context, errorMesage);
                                Navigator.pop(context);
                              } else {
                                Navigator.pushReplacementNamed(context, 'home');
                              }
                            } catch (e) {
                              Navigator.pop(context);
                              NotificationService.showSnackBar(
                                  context, "Revise su conexion a internet");
                            }
                          }
                        }),
                  ],
                ),
                const SizedBox(
                  height: 170,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "If you have an account",
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(" Login",
                          style:
                              TextStyle(color: Color.fromRGBO(93, 96, 239, 1))),
                    ),
                  ],
                )
              ],
            )),
      ],
    );
  }
}

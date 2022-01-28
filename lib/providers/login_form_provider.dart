import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = "";

  String password = "";

  String username = "";

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}

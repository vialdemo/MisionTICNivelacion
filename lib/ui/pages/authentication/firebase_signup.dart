import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/domain/controller/authentication_controller.dart';

class FirebaseSignUp extends StatefulWidget {
  @override
  _FirebaseSignUpState createState() => _FirebaseSignUpState();
}

class _FirebaseSignUpState extends State<FirebaseSignUp> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  AuthenticationController authenticationController = Get.find();

  _signup(theEmail, thePassword) async {
    try {
      await authenticationController.signUp(theEmail, thePassword);
      Get.back();
      Get.snackbar(
        "Sign Up",
        'OK',
        icon:
            Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (err) {
      Get.snackbar(
        "Sign Up",
        err.toString(),
        icon:
            Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Informacion para registro",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: this.controllerEmail,
                          decoration:
                              InputDecoration(labelText: "Correo electronico"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ingrese email";
                            } else if (!value.contains('@')) {
                              return "Ingrese un email valido";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: this.controllerPassword,
                          decoration: InputDecoration(labelText: "Contraseña"),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ingrese contraseña";
                            } else if (value.length < 6) {
                              return "La contraseña debe tener al menos 6 caracteres";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () async {
                              final form = _formKey.currentState;
                              form!.save();
                              // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formKey.currentState!.validate()) {
                                await _signup(controllerEmail.text,
                                    controllerPassword.text);
                              }
                            },
                            child: const Text("Enviar")),
                      ]),
                ))));
  }
}

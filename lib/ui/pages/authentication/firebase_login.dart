import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/domain/controller/authentication_controller.dart';
import 'firebase_signup.dart';

class FirebaseLogIn extends StatefulWidget {
  @override
  _FirebaseLogInState createState() => _FirebaseLogInState();
}

class _FirebaseLogInState extends State<FirebaseLogIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthenticationController _authController = Get.find();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_formKey.currentState!.validate()) return;
    try {
      await _authController.login(_emailController.text, _passwordController.text);
    } catch (err) {
      Get.snackbar(
        'Login',
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Loguearse con correo',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey('loginEmail'),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration:
                      const InputDecoration(labelText: 'Correo electronico'),
                  validator: (value) {
                    if (value!.isEmpty) return 'Ingrese email';
                    if (!value.contains('@')) return 'Ingrese un correo valido';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey('loginPassword'),
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) return 'Ingrese contraseña';
                    if (value.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  key: const ValueKey('loginAction'),
                  onPressed: _login,
                  child: const Text('Ingresar'),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirebaseSignUp()),
              );
            },
            child: const Text('Crea una cuenta'),
          ),
        ],
      ),
    );
  }
}

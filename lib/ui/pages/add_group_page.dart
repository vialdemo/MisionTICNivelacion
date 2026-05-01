import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({Key? key}) : super(key: key);

  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  final FirestoreController _firestoreController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _groupIdController = TextEditingController();
  final _student1Controller = TextEditingController();
  final _student2Controller = TextEditingController();

  @override
  void dispose() {
    _groupIdController.dispose();
    _student1Controller.dispose();
    _student2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir grupo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey('groupId'),
                  controller: _groupIdController,
                  decoration: const InputDecoration(labelText: 'ID del grupo'),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese ID del grupo' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey('groupUser1'),
                  controller: _student1Controller,
                  decoration: const InputDecoration(labelText: 'Estudiante 1'),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese Estudiante 1' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey('groupUser2'),
                  controller: _student2Controller,
                  decoration: const InputDecoration(labelText: 'Estudiante 2'),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese Estudiante 2' : null,
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  key: const ValueKey('groupAction'),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_formKey.currentState!.validate()) {
                      _firestoreController.addGroup(
                        _groupIdController.text,
                        _student1Controller.text,
                        _student2Controller.text,
                      );
                      Get.back();
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

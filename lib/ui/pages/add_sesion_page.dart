import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';

class AddSesionPage extends StatefulWidget {
  const AddSesionPage({Key? key}) : super(key: key);

  @override
  State<AddSesionPage> createState() => _AddSesionPageState();
}

class _AddSesionPageState extends State<AddSesionPage> {
  final FirestoreController _firestoreController = Get.find();
  late List<String> _groupIds;
  late String _selectedGroupId;
  bool _student1 = false;
  bool _student2 = false;

  @override
  void initState() {
    super.initState();
    _groupIds = _firestoreController.groupIds();
    if (_groupIds.isNotEmpty) {
      _selectedGroupId = _groupIds.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_groupIds.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Añadir nueva sesion')),
        body: const Center(child: Text('No hay grupos disponibles')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir nueva sesion'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            key: const ValueKey('sesionDrop'),
            value: _selectedGroupId,
            items: _groupIds.map((String val) {
              return DropdownMenuItem<String>(
                key: ValueKey(val),
                value: val,
                child: Text(val),
              );
            }).toList(),
            hint: const Text('Seleccione un grupo'),
            onChanged: (value) {
              setState(() {
                _selectedGroupId = value!;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Estudiante 1'),
              Switch(
                key: const ValueKey('sesionUser1'),
                value: _student1,
                onChanged: (value) => setState(() => _student1 = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Estudiante 2'),
              Switch(
                key: const ValueKey('sesionUser2'),
                value: _student2,
                onChanged: (value) => setState(() => _student2 = value),
              ),
            ],
          ),
          ElevatedButton(
            key: const ValueKey('actionSesion'),
            onPressed: () {
              _firestoreController.addSesion(
                  _selectedGroupId, _student1, _student2);
              Get.back();
            },
            child: const Text('Guardar sesion'),
          ),
        ],
      ),
    );
  }
}

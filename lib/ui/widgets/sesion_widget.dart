import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/data/model/sesion.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';
import 'package:misiontic_team_management/ui/pages/add_sesion_page.dart';

class SesionWidget extends StatelessWidget {
  SesionWidget({Key? key}) : super(key: key);

  final FirestoreController _firestoreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: _firestoreController.sesions.length,
          itemBuilder: (context, index) =>
              _buildItem(context, _firestoreController.sesions[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('addSesionAction'),
        child: const Icon(Icons.add),
        onPressed: () {
          if (_firestoreController.groupIds().isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddSesionPage()),
            );
          } else {
            Get.snackbar(
              'Aun no has creado ningun grupo',
              'Crea un grupo para continuar...',
            );
          }
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, Sesion sesion) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        key: const ValueKey('sesionCard'),
        elevation: 2,
        child: ListTile(
          leading: Icon(
            Icons.access_time_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            sesion.groupId,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            sesion.date.toDate().toString(),
            textAlign: TextAlign.center,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(sesion.student1.toString()),
              Text(sesion.student2.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

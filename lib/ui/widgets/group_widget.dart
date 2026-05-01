import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/data/model/group.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';
import 'package:misiontic_team_management/ui/pages/add_group_page.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirestoreController firestoreController = Get.find();
    return Scaffold(
      key: const ValueKey('groupsScaffold'),
      body: Obx(
        () => ListView.builder(
          itemCount: firestoreController.groups.length,
          itemBuilder: (context, index) =>
              _buildItem(context, firestoreController.groups[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('addGroupAction'),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGroupPage()),
          );
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, Group group) {
    return Padding(
      key: ValueKey(group.groupId),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        key: const ValueKey('groupCard'),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(
              Icons.group_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              group.groupId,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text(group.student1), Text(group.student2)],
            ),
          ),
        ),
      ),
    );
  }
}

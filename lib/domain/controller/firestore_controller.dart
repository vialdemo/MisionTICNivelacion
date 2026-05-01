import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:misiontic_team_management/data/model/group.dart';
import 'package:misiontic_team_management/data/model/sesion.dart';

class FirestoreController extends GetxController with UiLoggy {
  final _groups = <Group>[].obs;
  final _sesions = <Sesion>[].obs;

  final CollectionReference _groupCollection =
      FirebaseFirestore.instance.collection('groups');
  final Stream<QuerySnapshot> _groupStream = FirebaseFirestore.instance
      .collection('groups')
      .orderBy('groupId')
      .snapshots();
  late StreamSubscription<QuerySnapshot> _groupSubscription;

  final CollectionReference _sesionCollection =
      FirebaseFirestore.instance.collection('sesions');
  final Stream<QuerySnapshot> _sesionStream = FirebaseFirestore.instance
      .collection('sesions')
      .orderBy('date')
      .snapshots();
  late StreamSubscription<QuerySnapshot> _sesionSubscription;

  void subscribeUpdates() {
    loggy.info('subscribeUpdates');
    _groupSubscription = _groupStream.listen((event) {
      loggy.info('Groups snapshot received');
      _groups.value = event.docs.map((e) => Group.fromSnapshot(e)).toList();
      loggy.info('Groups count: ${_groups.length}');
    });

    _sesionSubscription = _sesionStream.listen((event) {
      loggy.info('Sesions snapshot received');
      _sesions.value = event.docs.map((e) => Sesion.fromSnapshot(e)).toList();
      loggy.info('Sesions count: ${_sesions.length}');
    });
  }

  void unsubscribeUpdates() {
    _groupSubscription.cancel();
    _sesionSubscription.cancel();
  }

  List<Group> get groups => _groups;
  List<Sesion> get sesions => _sesions;

  List<String> groupIds() {
    return _groups.map((g) => 'Grupo ${g.groupId}').toList();
  }

  void addGroup(String groupId, String student1, String student2) {
    _groupCollection
        .add({'groupId': groupId, 'student1': student1, 'student2': student2})
        .then((_) => loggy.info('Group added'))
        .catchError((e) => loggy.error('Failed to add group: $e'));
  }

  void addSesion(String groupId, bool student1, bool student2) {
    _sesionCollection
        .add({
          'date': DateTime.now(),
          'groupId': groupId,
          'student1': student1,
          'student2': student2,
        })
        .then((_) => loggy.info('Sesion added'))
        .catchError((e) => loggy.error('Failed to add sesion: $e'));
  }
}

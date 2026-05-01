import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/domain/controller/authentication_controller.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';
import 'package:misiontic_team_management/domain/controller/theme_controller.dart';
import 'package:misiontic_team_management/ui/widgets/appbar.dart';
import 'package:misiontic_team_management/ui/widgets/group_widget.dart';
import 'package:misiontic_team_management/ui/widgets/sesion_widget.dart';

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  int _selectedIndex = 0;
  final AuthenticationController _authController = Get.find();
  final FirestoreController _firestoreController = Get.find();
  final ThemeController _themeController = Get.find();

  static final List<Widget> _pages = <Widget>[
    const GroupWidget(),
    SesionWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    try {
      await _authController.logOut();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _firestoreController.subscribeUpdates();
  }

  @override
  void dispose() {
    _firestoreController.unsubscribeUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        controller: _themeController,
        tile: Text('Bienvenido ${_authController.userEmail()}'),
        context: context,
        onLogout: _logout,
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined, key: ValueKey('groupsTab')),
            label: 'Grupos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_time_outlined, key: ValueKey('sesionsTab')),
            label: 'Sesiones',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

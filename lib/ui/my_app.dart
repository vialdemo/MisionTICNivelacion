import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:misiontic_team_management/domain/controller/authentication_controller.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';
import 'package:misiontic_team_management/domain/controller/theme_controller.dart';
import 'package:misiontic_team_management/domain/theme_management.dart';
import 'package:misiontic_team_management/ui/theme/theme.dart';

import 'firebase_central.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with UiLoggy {
  late final Future<FirebaseApp> _initialization;
  late final ThemeController _themeController;
  late final ThemeManager _themeManager;

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp();
    _themeController = Get.put(ThemeController());
    _themeManager = ThemeManager();

    ever(_themeController.reactiveDarkMode, (bool isDarkMode) {
      _themeManager.changeTheme(isDarkMode: isDarkMode);
    });

    _initializeTheme();
  }

  Future<void> _initializeTheme() async {
    _themeController.darkMode = await _themeManager.storedTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase demo - MisionTIC',
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              loggy.error('Firebase init error: ${snapshot.error}');
              return const _ErrorView();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Get.put(FirestoreController());
              Get.put(AuthenticationController());
              return FirebaseCentral();
            }
            return const _LoadingView();
          },
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Something went wrong'));
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

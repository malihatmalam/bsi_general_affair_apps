import 'package:bsi_general_affair_apps/presentation/core/services/auth_services.dart';
import 'package:bsi_general_affair_apps/presentation/core/services/dropdown_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'presentation/core/router/router.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  if(!kIsWeb){
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }
  await Hive.openBox('userdata');

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext context) => AuthService()),
          ChangeNotifierProvider(create: (BuildContext context) => DropdownService())
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BSI General Affair',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      color: Colors.white,
      routerConfig: RouterNavigation().getRoute(),
      debugShowCheckedModeBanner: false,
    );
  }
}

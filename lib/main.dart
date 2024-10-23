import 'package:dg_mini_app/presentation/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

import 'dependency_injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injectDependency();
  runApp(const DGMiniApp());
}

class DGMiniApp extends StatelessWidget {
  const DGMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expedition to the Moon',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubetech/config/theme/theme.dart';
import 'package:scubetech/pages/view_projects.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: FlexTheme().lightTheme,
      darkTheme: FlexTheme().darkTheme,
      themeMode: ThemeMode.system,
      home: const ViewProjects(),
    );
  }
}

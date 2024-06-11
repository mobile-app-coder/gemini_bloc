import 'package:flutter/material.dart';
import 'package:gemini_app/core/config/root_binding.dart';
import 'package:gemini_app/data/datasources/local/no_sql.dart';
import 'package:gemini_app/presentation/pages/starter_page.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StarterPage(),
      initialBinding: RootBinding(),
    );
  }
}

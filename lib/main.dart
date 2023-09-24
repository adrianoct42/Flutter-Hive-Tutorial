import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_todo_app/screens/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Initialize Hive:
  await Hive.initFlutter();
  // Open a box:
  var box = await Hive.openBox("mybox");
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.yellow),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

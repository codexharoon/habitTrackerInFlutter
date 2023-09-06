import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/home_page.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {

  //init hive
  await Hive.initFlutter();

  // opening thehive box
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/ui/page/login_page.dart';
import 'package:sharetravel_frontend/ui/page/trip_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 252, 163, 17)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/ui/page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sharetravel proyect',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 252, 163, 17)),
          useMaterial3: true,
          fontFamily: 'Nunito'),
      home: const LoginPage(),
    );
  }
}

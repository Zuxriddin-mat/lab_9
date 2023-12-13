import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'main_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Registration Screen'),
            ),
            body: const RegistrationScreen(),
          ),
      '/main': (context) => const MainScreen(),
    },
  ));
}

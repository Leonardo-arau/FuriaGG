import 'package:flutter/material.dart';
import 'package:furiagg/telas/login.dart';

void main() {

  runApp(
    MaterialApp(
      home: Login(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0),
          primary: const Color.fromARGB(255, 0, 0, 0),
          secondary: const Color.fromARGB(255, 0, 0, 0),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

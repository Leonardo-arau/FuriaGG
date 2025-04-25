import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furiagg/telas/home.dart';

void main() async {

    WidgetsFlutterBinding.ensureInitialized(); // garante a inicialização correta
    await Firebase.initializeApp();

  FirebaseFirestore.instance.collection("usuarios").doc("001").set({
    "nome": "Luana",
  });

  runApp(MaterialApp(home: Home(), debugShowCheckedModeBanner: false));
}

import 'package:flutter/material.dart';
import '../src/screens/home.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'Cat in a Box Animation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}

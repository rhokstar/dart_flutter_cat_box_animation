import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  Widget build(context) {
    // Get cat image from the internet
    return Image.network(
      'https://i.imgur.com/QwhZRyL.png'
    );
  }
}

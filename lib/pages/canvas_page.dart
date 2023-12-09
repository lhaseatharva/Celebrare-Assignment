import 'package:flutter/material.dart';
import 'package:project/components/canvas_app.dart';

// ignore: use_key_in_widget_constructors
class CanvasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Canvas App'),
      ),
      body: CanvasApp(),
    );
  }
}

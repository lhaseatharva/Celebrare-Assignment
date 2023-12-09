import 'package:flutter/material.dart';
import 'package:project/components/canvas_app.dart';

class CanvasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canvas App'),
      ),
      body: CanvasApp(),
    );
  }
}

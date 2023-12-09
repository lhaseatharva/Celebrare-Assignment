import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/pages/canvas_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CanvasPage(),
    );
  }
}

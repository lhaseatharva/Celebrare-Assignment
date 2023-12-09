import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final ValueChanged<Color> onColorChanged;

  ColorPicker({required this.onColorChanged});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (Color color in [
            Colors.black,
            Colors.red,
            Colors.green,
            Colors.blue,
            Colors.yellow,
            Colors.orange,
            Colors.purple,
          ])
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = color;
                });
                widget.onColorChanged(color);
              },
              child: Container(
                width: 30.0,
                height: 30.0,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  border: Border.all(
                    color: selectedColor == color ? Colors.white : Colors.transparent,
                    width: 2.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

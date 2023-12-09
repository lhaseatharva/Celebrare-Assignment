import 'package:flutter/material.dart';
import 'package:project/components/text_data.dart';

class DraggableText extends StatelessWidget {
  final TextData textData;
  final bool isSelected;
  final Function(Offset) onDragEnd;
  final Function onTap;

  const DraggableText({Key? key, required this.textData, required this.isSelected, required this.onDragEnd, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: textData.position.dx,
      top: textData.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          onDragEnd(textData.position + details.delta);
        },
        onTap: () {
          onTap();
        },
        child: Text(
          textData.text,
          style: TextStyle(
            fontSize: textData.fontSize,
            color: textData.textColor,
            fontStyle: textData.fontStyle == 'Italic' ? FontStyle.italic : FontStyle.normal,
            fontWeight: textData.fontStyle == 'Bold' ? FontWeight.bold : FontWeight.normal,
            decoration: textData.underline ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

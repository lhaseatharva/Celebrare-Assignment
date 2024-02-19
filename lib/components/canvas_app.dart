import 'package:flutter/material.dart';
import 'package:project/components/color_picker.dart';
import 'package:project/components/draggable_text.dart';
import 'package:project/components/text_data.dart';

// ignore: use_key_in_widget_constructors
class CanvasApp extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CanvasAppState createState() => _CanvasAppState();
}

class _CanvasAppState extends State<CanvasApp> {
  List<TextData> texts = [];
  List<TextData> redotxt = [];
  int selectedTextIndex = -1;
  double fontSize = 20.0;
  Color textColor = Colors.black;

  TextEditingController newTextController = TextEditingController();

  String selectedFontStyle = 'Normal';
  List<String> fontStyles = ['Normal', 'Bold', 'Italic', 'Underline'];

  void addText(String newText) {
    setState(() {
      texts.add(TextData(newText, const Offset(50.0, 50.0), fontSize, textColor));
    });
    Navigator.pop(context);
  }

  void updateText(String newText, double newFontSize, Color newColor,
      {String? fontStyle}) {
    // ignore: avoid_print
    print(
        "Updating text: $newText, Size: $newFontSize, Color: $newColor, Style: $fontStyle");

    setState(() {
      if (selectedTextIndex != -1) {
        texts[selectedTextIndex].text = newText;
        texts[selectedTextIndex].fontSize = newFontSize;
        texts[selectedTextIndex].textColor = newColor;
        texts[selectedTextIndex].fontStyle =
            fontStyle ?? 'Normal';
      }
    });
  }

  void deleteText() {
    setState(() {
      if (selectedTextIndex != -1) {
        texts.removeAt(selectedTextIndex);
        selectedTextIndex = -1;
      }
    });
  }

  void undo() {
    setState(() {
      if (texts.isNotEmpty) {
        var last = texts[texts.length - 1];
        texts.removeLast();
        redotxt.add(last);
      }
    });
  }

  void redo() {
    setState(() {
      if (redotxt.isNotEmpty) {
        texts.add(redotxt[redotxt.length-1]);
        redotxt.removeAt(redotxt.length-1);
      }
    });
  }

  Future<void> showAddTextPopup() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter New Text'),
          content: TextField(
            controller: newTextController,
            decoration: const InputDecoration(labelText: 'New Text'),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade100),
              onPressed: () => addText(newTextController.text),
              child: const Text('Submit',style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Material(
                color: Colors.blue,
                child: InkWell(
                  splashColor: Colors.red,
                  onTap: undo,
                  child:
                      const SizedBox(width: 56, height: 56, child: Icon(Icons.undo)),
                ),
              ),
            ),
            
            const SizedBox(
              height: 4,
            ),

            ClipOval(
              child: Material(
                color: Colors.blue,
                child: InkWell(
                  splashColor: Colors.red,
                  onTap: redo,
                  child:
                      const SizedBox(width: 56, height: 56, child: Icon(Icons.redo)),
                ),
              ),
            ),
           
          ],
        ),
        Expanded(
          child: GestureDetector(
            onTapUp: (details) {
              setState(() {
                selectedTextIndex = -1;
              });
            },
            child: Container(
              color: Colors.grey[200],
              child: Stack(
                children: [
                  for (int i = 0; i < texts.length; i++)
                    DraggableText(
                      textData: texts[i],
                      isSelected: i == selectedTextIndex,
                      onDragEnd: (offset) {
                        setState(() {
                          texts[i].position = offset;
                        });
                      },
                      onTap: () {
                        setState(() {
                          selectedTextIndex = i;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
        selectedTextIndex != -1
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: selectedFontStyle,
                    items: fontStyles.map((style) {
                      return DropdownMenuItem<String>(
                        value: style,
                        child: Text(style),
                      );
                    }).toList(),
                    onChanged: (newStyle) {
                      setState(() {
                        selectedFontStyle = newStyle!;
                        updateText(
                          texts[selectedTextIndex].text,
                          fontSize,
                          textColor,
                          fontStyle: selectedFontStyle,
                        );
                      });
                    },
                  ),

                  Slider(
                    value: fontSize,
                    min: 10.0,
                    max: 40.0,
                    onChanged: (newSize) {
                      setState(() {
                        fontSize = newSize;
                      });
                      updateText(
                          texts[selectedTextIndex].text, newSize, textColor,fontStyle: selectedFontStyle);
                    },
                  ),
                  ColorPicker(
                    onColorChanged: (newColor) {
                      setState(() {
                        textColor = newColor;
                      });
                      updateText(
                          texts[selectedTextIndex].text, fontSize, newColor,fontStyle: selectedFontStyle);
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue.shade100),
                    onPressed: deleteText,
                    child: const Text('Delete Text'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue.shade100),
                    onPressed: showAddTextPopup,
                    child: const Text('Add Text',style: TextStyle(color: Colors.black)),
                  ),
                ],
              )
      ],
    );
  }
}

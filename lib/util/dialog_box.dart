import 'package:flutter/material.dart';
import 'package:todo_app/util/button_util.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintName;
  final bool isEdit;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.hintName,
    required this.isEdit
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: isEdit ? hintName : "Add new task",
              ),
            ), //user input

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonUtil(text: "Save", onPressed: onSave),
                
                ButtonUtil(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:hive_todo_app/util/my_button.dart";

class DialogBox extends StatelessWidget {
  DialogBox(this.controller, this.onSave, this.onCancel, {super.key});

  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green[300],
      content: Container(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add a new task!"),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton("Save", onSave),
                const SizedBox(
                  width: 16,
                ),
                MyButton("Cancel", onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}

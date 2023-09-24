import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  MyButton(this.text, this.onPressed, {super.key});

  final String text;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(text),
    );
  }
}

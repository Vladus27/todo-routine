import 'package:flutter/material.dart';

class AndroidShowDialog extends StatelessWidget {
  const AndroidShowDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text("Invalid input"),
      content: const Text(
        "Please make sure a valid title, amountm date and category was entered",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Okay"),
        ),
      ],
    );
  }
}

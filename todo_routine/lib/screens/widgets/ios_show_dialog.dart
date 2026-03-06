import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosShowDialog extends StatelessWidget {
  const IosShowDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Invalid input"),
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

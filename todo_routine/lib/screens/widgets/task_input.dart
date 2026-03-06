import 'package:flutter/material.dart';

class TaskInput extends StatelessWidget {
  const TaskInput({
    super.key,
    required this.titleField,
    required this.task,
    required this.onAddTask,
  });
  final String titleField;
  final TextEditingController task;
  final void Function() onAddTask;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(16),
      child: TextField(
        controller: task,
        keyboardType: TextInputType.text,
        maxLength: 50,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onAddTask,
            icon: Icon(Icons.add_circle_outline_outlined),
          ),
          // suffixIcon: Icon(Icons.add_circle_outline_outlined),
          label: Text(titleField),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainer,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: theme.colorScheme.primaryContainer),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.primary),
          ),
        ),
      ),
    );
  }
}

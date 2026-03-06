import 'package:flutter/material.dart';

import 'package:todo_routine/models/task.dart';
import 'package:todo_routine/screens/tasks_list/tasks_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.task,
    required this.onRemoveTask,
    required this.onCompletedtask,
  });

  final List<Task> task;

  final void Function(Task task) onRemoveTask;
  final void Function(Task task) onCompletedtask;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: task.length,
      itemBuilder:
          (ctx, index) => Dismissible(
            key: ValueKey(task[index]),

            // right swipe - delete
            background: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              color: Colors.green.withValues(alpha: 0.75),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
              child: const Icon(Icons.check, color: Colors.white),
            ),

            // left swipe - mask as completed
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              color: Theme.of(
                context,
              ).colorScheme.error.withValues(alpha: 0.75),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
              child: const Icon(Icons.delete, color: Colors.white),
            ),

            direction: DismissDirection.horizontal,

            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                onCompletedtask(task[index]);
              } else if (direction == DismissDirection.endToStart) {
                onRemoveTask(task[index]);
              }
            },

            child: TaskItem(task[index]),
          ),
    );
  }
}

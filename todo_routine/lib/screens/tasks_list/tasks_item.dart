import 'package:flutter/material.dart';

import 'package:todo_routine/models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      // The widget Card is like Container with shadow behind
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.notes),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                task.task,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,

                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Icon(Icons.event, size: 16,),
                      const SizedBox(width: 14),
                      Text('Start date: '),
                      const SizedBox(width: 14),
                      Text(Task.formatDate(task.startDateTime)),
                    ],
                  ),
                  // const SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(Icons.event_available,size:16),
                      const SizedBox(width: 14),
                      Text('End date:'),
                      const SizedBox(width: 25),
                      Text(Task.formatDate(task.endDateTime)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

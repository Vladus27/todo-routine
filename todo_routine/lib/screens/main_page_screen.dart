import 'package:flutter/material.dart';

import 'package:todo_routine/screens/expenses_screen.dart';
import 'package:todo_routine/screens/task_manager.dart';

class MainPageScreen extends StatelessWidget {
  const MainPageScreen({super.key});

  @override
  Widget build(BuildContext context) {   

    return Scaffold(
      appBar: AppBar(title: Text('ToDo Routine')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select an option to get started',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 48,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  TaskManager(),                          
                        ),
                      );
                    },
                    child: Text('Manage Tasks'),
                  ),
                ),
                SizedBox(width: 12),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ExpensesScreen(),
                        ),
                      );
                    },
                    child: Text('Manage expenses'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



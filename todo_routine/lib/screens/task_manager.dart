import 'package:flutter/material.dart';
import 'package:todo_routine/models/task.dart';
import 'package:todo_routine/screens/tasks_list/tasks_list.dart';
import 'package:todo_routine/screens/widgets/ios_show_dialog.dart';
import 'package:todo_routine/screens/widgets/task_input.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  final List<Task> tasksList = [];
  final _task = TextEditingController();
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _loadTasksFromStorage(); // load task before the build
  }

  Future<void> _addTask() async {
    if (_task.text.isEmpty) {
      return showDialog(context: context, builder: (ctx) => IosShowDialog());
    }

    final isDateSet = await _setTime();
    if (!isDateSet) return;

    setState(() {
      tasksList.add(
        Task(
          task: _task.text,
          isCompleted: false,
          startDateTime: _selectedStartDate,
          endDateTime: _selectedEndDate,
        ),
      );
      _task.clear();
    });

    await _saveTasksToStorage(); // save task after adding
  }

  Future<bool> _setTime() async {
    _selectedStartDate = await presentDatePicker();
    if (_selectedStartDate == null) return false;

    _selectedEndDate = await futureDatePicker();
    return _selectedEndDate != null;
  }

  Future<DateTime?> presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    return await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      helpText: 'Select the start',
    );
  }

  Future<DateTime?> futureDatePicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    return await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastDate,
      helpText: 'Select the end',
    );
  }

  void _removeTask(Task task) {
  final index = tasksList.indexOf(task);
  setState(() {
    tasksList.removeAt(index);
  });

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Task deleted"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            tasksList.insert(index, task);
          });

          // update saves after undo deletion
          _saveTasksToStorage(); 
        },
      ),
    ),
  );

  // update saves after deletion
  _saveTasksToStorage(); 
}


  void _completeTask(Task task) {
    final index = tasksList.indexOf(task);
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);

    setState(() {
      tasksList[index] = updatedTask;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          updatedTask.isCompleted
              ? "Task marked as completed"
              : "Task moved back to active",
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    _saveTasksToStorage(); // Update saves after the update
  }

  Future<void> _loadTasksFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('tasks');
    if (jsonString != null) {
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      final loadedTasks = decoded.map((item) => Task.fromJson(item)).toList();
      setState(() {
        tasksList.clear();
        tasksList.addAll(loadedTasks);
      });
    }
  }

  Future<void> _saveTasksToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = tasksList.map((task) => task.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString('tasks', jsonString);
  }

  @override
  Widget build(BuildContext context) {
    final activeTasks = tasksList.where((task) => !task.isCompleted).toList();
    final completedTasks = tasksList.where((task) => task.isCompleted).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Task')),
      body: Column(
        children: [
          const SizedBox(height: 12),
          TaskInput(
            titleField: 'Enter your task',
            task: _task,
            onAddTask: _addTask,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                if (activeTasks.isEmpty)
                  const Opacity(
                    opacity: 0.5,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          "You have no active tasks. Start adding some!",
                        ),
                      ),
                    ),
                  )
                else
                  TasksList(
                    task: activeTasks,
                    onRemoveTask: _removeTask,
                    onCompletedtask: _completeTask,
                  ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  child: Divider(),
                ),

                if (completedTasks.isEmpty)
                  const Opacity(
                    opacity: 0.5,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text("You have not completed any tasks yet"),
                      ),
                    ),
                  )
                else
                  TasksList(
                    task: completedTasks,
                    onRemoveTask: _removeTask,
                    onCompletedtask: _completeTask,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

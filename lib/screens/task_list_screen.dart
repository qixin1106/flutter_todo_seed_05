import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import '../services/hive_service.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late final ValueNotifier<List<Task>> _tasksNotifier;

  @override
  void initState() {
    super.initState();
    _tasksNotifier = ValueNotifier(HiveService.getAllTasks());
    HiveService.taskBox.watch().listen((event) => _updateTasks());
  }

  @override
  void dispose() {
    _tasksNotifier.dispose();
    super.dispose();
  }

  void _updateTasks() {
    _tasksNotifier.value = HiveService.getAllTasks();
  }

  void _toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    HiveService.updateTask(task);
  }

  void _deleteTask(Task task) {
    HiveService.deleteTask(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('任务列表'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ValueListenableBuilder<List<Task>>(
        valueListenable: _tasksNotifier,
        builder: (context, tasks, child) {
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                '暂无任务',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: Key(task.key.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) => _deleteTask(task),
                child: ListTile(
                  onTap: () => _toggleTaskCompletion(task),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) => _toggleTaskCompletion(task),
                    activeColor: Colors.deepPurple,
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isCompleted ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
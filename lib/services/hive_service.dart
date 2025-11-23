import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/task.dart';

class HiveService {
  static const String _taskBoxName = 'tasks';
  static late Box<Task> _taskBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    _taskBox = await Hive.openBox<Task>(_taskBoxName);
  }

  static Box<Task> get taskBox => _taskBox;

  static Future<void> addTask(Task task) async {
    await _taskBox.add(task);
  }

  static Future<void> updateTask(Task task) async {
    await task.save();
  }

  static Future<void> deleteTask(Task task) async {
    await task.delete();
  }

  static List<Task> getAllTasks() {
    return _taskBox.values.toList();
  }
}
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';
import '../services/hive_service.dart';

class TaskListController extends GetxController {
  final _tasks = <Task>[].obs;
  final _searchQuery = ''.obs;
  final _debouncedSearchQuery = ''.obs;
  late Box<Task> _taskBox;

  List<Task> get tasks => _debouncedSearchQuery.value.isEmpty
      ? _tasks
      : _tasks.where((task) => task.title.toLowerCase().contains(_debouncedSearchQuery.value.toLowerCase())).toList();

  @override
  void onInit() {
    super.onInit();
    _taskBox = HiveService.taskBox;
    _loadTasks();
    _taskBox.watch().listen((event) => _loadTasks());
    
    // 防抖机制，延迟500ms执行搜索
    _searchQuery.listen((query) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _debouncedSearchQuery.value = query;
      });
    });
  }

  void _loadTasks() {
    _tasks.value = HiveService.getAllTasks();
  }

  void updateSearchQuery(String query) {
    _searchQuery.value = query;
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    HiveService.updateTask(task);
  }

  void deleteTask(Task task) {
    HiveService.deleteTask(task);
  }

  void navigateToAddTask() {
    Get.toNamed('/add');
  }
}
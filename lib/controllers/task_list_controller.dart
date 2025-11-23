import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import '../services/hive_service.dart';

class TaskListController extends GetxController {
  final _tasks = <Task>[].obs;
  final _filteredTasks = <Task>[].obs;
  final _searchQuery = ''.obs;
  final _isLoading = false.obs;

  List<Task> get tasks => _filteredTasks;
  String get searchQuery => _searchQuery.value;
  bool get isLoading => _isLoading.value;

  late Box<Task> _taskBox;

  @override
  void onInit() {
    super.onInit();
    _initHive();
    _listenToBoxChanges();
    _setupSearchListener();
  }

  Future<void> _initHive() async {
    _isLoading(true);
    try {
      _taskBox = HiveService.taskBox;
      _loadTasks();
    } catch (e) {
      print('Error initializing Hive: $e');
    } finally {
      _isLoading(false);
    }
  }

  void _loadTasks() {
    final allTasks = _taskBox.values.toList();
    // Sort tasks by created date in descending order
    allTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _tasks.assignAll(allTasks);
    _filterTasks();
  }

  void _listenToBoxChanges() {
    _taskBox.watch().listen((_) {
      _loadTasks();
    });
  }

  void _setupSearchListener() {
    // Debounce search query to avoid excessive filtering
    ever(_searchQuery, (_) {
      _filterTasks();
    }, time: const Duration(milliseconds: 300));
  }

  void setSearchQuery(String query) {
    _searchQuery.value = query;
  }

  void _filterTasks() {
    if (_searchQuery.value.isEmpty) {
      _filteredTasks.assignAll(_tasks);
    } else {
      _filteredTasks.assignAll(
        _tasks.where((task) =>
            task.title.toLowerCase().contains(_searchQuery.value.toLowerCase())),
      );
    }
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    HiveService.updateTask(task);
  }

  void deleteTask(Task task) {
    HiveService.deleteTask(task);
  }

  @override
  void onClose() {
    // Don't close the box here as it's used elsewhere
    super.onClose();
  }
}
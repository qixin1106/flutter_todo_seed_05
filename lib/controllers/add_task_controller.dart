import 'package:get/get.dart';
import '../models/task.dart';
import '../services/hive_service.dart';

class AddTaskController extends GetxController {
  final titleController = ''.obs;

  void saveTask() {
    if (titleController.value.trim().isEmpty) {
      return;
    }

    final newTask = Task(title: titleController.value.trim());
    HiveService.addTask(newTask);
    Get.back();
  }

  void onTitleChanged(String value) {
    titleController.value = value;
  }
}
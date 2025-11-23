import 'package:get/get.dart';
import '../models/task.dart';
import '../services/hive_service.dart';

class AddTaskController extends GetxController {
  final titleController = ''.obs;
  final isLoading = false.obs;

  bool get isTitleValid => titleController.value.trim().isNotEmpty;

  void saveTask() async {
    if (!isTitleValid) {
      Get.snackbar(
        '错误',
        '请输入任务标题',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    isLoading(true);
    try {
      final newTask = Task(title: titleController.value.trim());
      await HiveService.addTask(newTask);
      Get.back();
      Get.snackbar(
        '成功',
        '任务已添加',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } catch (e) {
      Get.snackbar(
        '错误',
        '添加任务失败: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading(false);
      titleController.value = '';
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_list_controller.dart';
import '../models/task.dart';

class TaskListScreen extends GetView<TaskListController> {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('待办事项'),
          bottom: TabBar(
            tabs: [
              Tab(text: '待办'),
              Tab(text: '已办'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _showSearchDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.brightness_6),
              onPressed: () {
                Get.changeThemeMode(
                  Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildTaskList(false),
            _buildTaskList(true),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/add');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTaskList(bool showCompleted) {
    return Obx(() {
      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      final filteredTasks = controller.tasks.where((task) {
        return task.isCompleted == showCompleted;
      }).toList();

      if (filteredTasks.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                showCompleted ? Icons.check_circle_outline : Icons.event_note,
                size: 64,
                color: Get.theme.colorScheme.onBackground.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                showCompleted ? '还没有已完成' : '还没有待办',
                style: TextStyle(
                  fontSize: 18,
                  color: Get.theme.colorScheme.onBackground.withOpacity(0.5),
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        itemCount: filteredTasks.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final task = filteredTasks[index];
          return _buildTaskItem(task);
        },
      );
    });
  }

  Widget _buildTaskItem(Task task) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          controller.toggleTaskCompletion(task);
        },
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            controller.toggleTaskCompletion(task);
          },
          activeColor: Get.theme.colorScheme.primary,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: task.isCompleted
                ? Get.theme.colorScheme.onBackground.withOpacity(0.5)
                : Get.theme.colorScheme.onBackground,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Get.theme.colorScheme.error),
          onPressed: () {
            _showDeleteDialog(task);
          },
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    searchController.text = controller.searchQuery;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('搜索任务'),
        content: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: '输入关键词',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                controller.setSearchQuery('');
              },
            ),
          ),
          onChanged: (value) {
            controller.setSearchQuery(value);
          },
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(Task task) {
    Get.defaultDialog(
      title: '删除任务',
      middleText: '确定要删除这个任务吗？',
      textConfirm: '删除',
      textCancel: '取消',
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteTask(task);
        Get.back();
        Get.snackbar(
          '成功',
          '任务已删除',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      },
    );
  }
}
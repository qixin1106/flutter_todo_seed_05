import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_list_controller.dart';
import '../models/task.dart';

class TaskListScreen extends GetView<TaskListController> {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('任务列表'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          // 搜索框
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: controller.updateSearchQuery,
              decoration: InputDecoration(
                hintText: '搜索任务...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          // 任务列表
          Expanded(
            child: Obx(() {
              if (controller.tasks.isEmpty) {
                return const Center(
                  child: Text(
                    '暂无任务',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  final task = controller.tasks[index];
                  return Dismissible(
                    key: Key(task.key.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) => controller.deleteTask(task),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        onTap: () => controller.toggleTaskCompletion(task),
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) => controller.toggleTaskCompletion(task),
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: task.isCompleted ? Colors.grey : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        subtitle: Text(
                          '创建于: ${task.createdAt.toString().substring(0, 16)}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToAddTask,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
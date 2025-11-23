import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_task_controller.dart';

class AddTaskScreen extends GetView<AddTaskController> {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加任务'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: controller.onTitleChanged,
              decoration: InputDecoration(
                labelText: '任务标题',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              autofocus: true,
              onSubmitted: (_) => controller.saveTask(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.saveTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '保存',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
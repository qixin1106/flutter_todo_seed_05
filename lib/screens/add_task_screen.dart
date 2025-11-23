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
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => TextField(
              onChanged: (value) => controller.titleController.value = value,
              decoration: const InputDecoration(
                labelText: '任务标题',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
              onSubmitted: (_) => controller.saveTask(),
            )),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: controller.saveTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                '保存',
                style: TextStyle(fontSize: 18),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
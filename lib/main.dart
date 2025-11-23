import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/hive_service.dart';
import 'screens/task_list_screen.dart';
import 'screens/add_task_screen.dart';
import 'bindings/task_list_binding.dart';
import 'bindings/add_task_binding.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const TaskListScreen(),
          binding: TaskListBinding(),
        ),
        GetPage(
          name: '/add',
          page: () => const AddTaskScreen(),
          binding: AddTaskBinding(),
        ),
      ],
    );
  }
}

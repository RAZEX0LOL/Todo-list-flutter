import 'package:flutter/material.dart';
import 'task_list_screen.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Список задач',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey[900],
        ),
      ),
      home: TaskListScreen(),
    );
  }
}

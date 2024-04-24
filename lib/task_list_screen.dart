import 'package:flutter/material.dart';
import 'task_model.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Нет задач'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _navigateToAddTaskScreen(context);
            },
          ),
        ],
      ),
      body: _tasks.isEmpty
          ? Center(
        child: Text(
          'Нет задач',
          style: TextStyle(fontSize: 20.0),
        ),
      )
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return _buildTaskCard(_tasks[index]);
        },
      ),
    );
  }

  Widget _buildTaskCard(Task task) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4.0,
      child: ListTile(
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Приоритет: ${_formatPriority(task.priority)}'),
            Text('Дедлайн: ${_formatDate(task.deadline)}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                _completeTask(task);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteTask(task);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    } else {
      return 'Нет дедлайнов';
    }
  }

  String _formatPriority(Priority priority) {
    switch (priority) {
      case Priority.low:
        return 'Низкий';
      case Priority.medium:
        return 'Средний';
      case Priority.high:
        return 'Высокий';
      default:
        return '';
    }
  }

  void _navigateToAddTaskScreen(BuildContext context) async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen(onAddTask: _addTask)),
    );
    if (newTask != null) {
      setState(() {
        _tasks.add(newTask as Task);
        _sortTasks();
      });
    }
  }

  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
      _sortTasks();
    });
  }

  void _completeTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  void _sortTasks() {
    _tasks.sort((a, b) {
      if (a.priority != b.priority) {
        return b.priority.index.compareTo(a.priority.index);
      } else {
        if (a.deadline != null && b.deadline != null) {
          return a.deadline!.compareTo(b.deadline!);
        } else if (a.deadline != null) {
          return -1;
        } else if (b.deadline != null) {
          return 1;
        } else {
          return 0;
        }
      }
    });
  }

}

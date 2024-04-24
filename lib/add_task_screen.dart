import 'package:flutter/material.dart';
import 'task_model.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(Task) onAddTask;
  final Task? task;

  AddTaskScreen({required this.onAddTask, this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _titleController;
  late Priority _priority;
  late DateTime? _deadline;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _priority = widget.task?.priority ?? Priority.medium;
    _deadline = widget.task?.deadline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Добавить новую задачу' : 'Изменить задачу'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.0),
            Text('Приоритет:'),
            DropdownButton<Priority>(
              value: _priority,
              onChanged: (value) {
                setState(() {
                  _priority = value!;
                });
              },
              items: Priority.values
                  .map((priority) => DropdownMenuItem<Priority>(
                value: priority,
                child: Text(_formatPriority(priority)),
              ))
                  .toList(),
            ),
            SizedBox(height: 12.0),
            Row(
              children: [
                Text('Дедлайн:'),
                SizedBox(width: 12.0),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _selectDeadline(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        _deadline != null
                            ? '${_deadline!.day}/${_deadline!.month}/${_deadline!.year}'
                            : 'Выбрать дату',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                final String title = _titleController.text;
                final Task newTask = Task(title: title, priority: _priority, deadline: _deadline);
                widget.onAddTask(newTask);
                Navigator.pop(context);
              },
              child: Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = picked;
      });
    }
  }

  String _formatPriority(Priority priority) {
    switch (priority) {
      case Priority.high:
        return 'Высокий';
      case Priority.medium:
        return 'Средний';
      case Priority.low:
        return 'Низкий';
      default:
        return '';
    }
  }

}

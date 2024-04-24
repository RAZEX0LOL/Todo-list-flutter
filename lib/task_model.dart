enum Priority { low, medium, high }

class Task {
  String title;
  Priority priority;
  DateTime? deadline;

  Task({required this.title, required this.priority, this.deadline});
}

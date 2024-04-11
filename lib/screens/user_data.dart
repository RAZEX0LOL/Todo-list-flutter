import 'package:flutter/material.dart';

class UserData extends InheritedWidget {
  final String name;
  final int age;

  UserData({
    required this.name,
    required this.age,
    required Widget child,
  }) : super(child: child);

  static UserData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserData>()!;
  }

  @override
  bool updateShouldNotify(UserData oldWidget) {
    return name != oldWidget.name || age != oldWidget.age;
  }
}

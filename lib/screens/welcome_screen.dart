import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/screens/age_screen.dart';

class WelcomeScreen extends StatefulWidget {
  final String name;

  WelcomeScreen({required this.name});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добро пожаловать, ${widget.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Выберите вашу дату рождения:'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Выбрать дату'),
            ),
            SizedBox(height: 20.0),
            _selectedDate != null
                ? ElevatedButton(
              onPressed: () {
                DateTime today = DateTime.now();
                int age = today.year - _selectedDate!.year;
                if (today.month < _selectedDate!.month ||
                    (today.month == _selectedDate!.month &&
                        today.day < _selectedDate!.day)) {
                  age--;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgeScreen(
                      userData: {'name': widget.name, 'age': age},
                    ),
                  ),
                );
              },
              child: Text('Продолжить'),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}


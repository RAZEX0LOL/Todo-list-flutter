import 'package:flutter/material.dart';
import 'package:flutter_app/screens/name_input_screen.dart';

class AgeScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  AgeScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    final String name = userData['name'] ?? 'Unknown';
    final int age = userData['age'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ваш возраст'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$name, вам $age лет'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NameInputScreen(),
                  ),
                );
              },
              child: Text('Изменить имя'),
            ),
          ],
        ),
      ),
    );
  }
}

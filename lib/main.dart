// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Odd Disabled List',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: OddDisabledListPage(),
//     );
//   }
// }
//
// class OddDisabledListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Odd Disabled List'),
//       ),
//       body: OddDisabledListView(),
//     );
//   }
// }
//
// class OddDisabledListView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 10, // Change this to the number of items you want to display
//       itemBuilder: (context, index) {
//         // Check if the index is odd
//         bool isOdd = index % 2 == 0;
//
//         // Disable odd items
//         return isOdd
//             ? ListTile(
//           title: Text('Item $index'),
//           leading: Icon(Icons.block),
//           onTap: () {
//             // Add any action you want to perform when tapping disabled item
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Item $index is disabled'),
//               ),
//             );
//           },
//         )
//             : ListTile(
//           title: Text('Item $index'),
//           leading: Icon(Icons.check),
//           onTap: () {
//             // Add any action you want to perform when tapping enabled item
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Item $index is enabled'),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_app/screens/name_input_screen.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: NameInputScreen(), // Установка начальных значений name и age
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class UserData extends InheritedWidget {
  String _name;
  int _age;

  UserData({
    Key? key,
    required String name,
    required int age,
    required Widget child,
  })  : _name = name,
        _age = age,
        super(key: key, child: child);

  String get name => _name;
  int get age => _age;

  void updateName(String newName) {
    _name = newName;
  }

  void updateAge(int newAge) {
    _age = newAge;
  }

  static UserData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserData>();
  }

  @override
  bool updateShouldNotify(UserData oldWidget) {
    return _name != oldWidget.name || _age != oldWidget.age;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserData(
        name: '',
        age: 0,
        child: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    UserData? userData = UserData.of(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Input Page'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if(userData!.name.isNotEmpty) Text(
              "Информация о вас: \n Имя: ${userData?.name}  \n Возраст: ${userData?.age}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Представьтесь',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Введите ваше имя',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _nameController.clear();
                  },
                ),
              ),
            ),


            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if(_nameController.text.isNotEmpty) Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(_nameController.text),
                  ),
                );
              },
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final String name;

  SecondPage(this.name);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Date of Birth Page'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${widget.name}, добро пожаловать!\nУкажите вашу дату рождения',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _dobController,
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Дата рождения',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _selectedDate = null;
                      _dobController.clear();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if(_dobController.text.isNotEmpty) Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdPage(
                      name: widget.name,
                      dob: _dobController.text,
                    ),
                  ),
                );
              },
              child: Text('Рассчитать возраст'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
  }
}



class ThirdPage extends StatelessWidget {
  final String name;
  final String dob;

  ThirdPage({required this.name, required this.dob});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime birthDate = DateTime.parse(dob);
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Result Page'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$name, вам $age лет',
              style: TextStyle(fontSize: 45.0),
            ),
            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserData(name: name, age: age, child: MyHomePage())
                    // MyHomePage(),
                  ),
                );
              },
              child: Text('Вернуться на главную'),
            ),
          ],
        ),
      ),
    );
  }
}











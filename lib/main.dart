import 'package:edit_widget/pages/tab_bar.dart';
import 'package:flutter/material.dart';

import 'data/repository.dart';
import 'model/person.dart';
import 'pages/home_page.dart';
import 'pages/update_data_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Person> listPerson = [];
  Repository repository = Repository();

  getData() async {
    listPerson = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(listPerson: listPerson),
      routes: {
        '/home': (context) => TabBarWidget(),
        '/update': (context) => UpdateData(),
      },
    );
  }
}

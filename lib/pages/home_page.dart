import 'package:flutter/material.dart';

import '../data/repository.dart';
import '../model/person.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    required this.listPerson,
  }) : super(key: key);

  final List<Person> listPerson;
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: listPerson.length,
          itemBuilder: (context, index) {
            Person person = listPerson[index];
            return InkWell(
              onDoubleTap: () {
                Navigator.popAndPushNamed(context, '/update', arguments: [
                  person.id,
                  person.first_name,
                  person.last_name,
                  person.message
                ]);
              },
              child: Card(
                child: Container(
                  child: ListTile(
                    title: Text('${person.first_name} ${person.last_name}'),
                    subtitle: Text(person.message),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

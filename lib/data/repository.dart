import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/person.dart';

class Repository {
  String _baseUrl = 'http://6308255046372013f576f9b5.mockapi.io/person';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Person> albums = it.map((e) => Person.fromJson(e)).toList();
        return albums;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future createData(
    String first_name,
    String last_name,
    String message,
  ) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl), body: {
        'first_name': first_name,
        'last_name': last_name,
        'message': message,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateData(
    String id,
    String first_name,
    String last_name,
    String message,
  ) async {
    try {
      final response = await http.put(Uri.parse('${_baseUrl}/${id}'), body: {
        'first_name': first_name,
        'last_name': last_name,
        'message': message,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

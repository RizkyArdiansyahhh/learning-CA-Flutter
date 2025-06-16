import 'dart:convert';

import 'package:latihan_ca/features/todo/data/models/todo_model.dart';
import 'package:http/http.dart' as http;

abstract class TodoRemoteDatasource {
  Future<List<TodoModel>> getAllTodo();
}

class TodoRemoteDatasourceImplementation implements TodoRemoteDatasource {
  @override
  Future<List<TodoModel>> getAllTodo() async {
    final Uri url = Uri.parse("https://jsonplaceholder.typicode.com/todos");
    final response = await http.get(url);
    List<dynamic> dataBody = jsonDecode(response.body);
    return TodoModel.listFromJson(dataBody);
  }
}

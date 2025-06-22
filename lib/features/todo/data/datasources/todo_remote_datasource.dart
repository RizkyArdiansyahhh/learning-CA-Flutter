import 'dart:convert';

import 'package:latihan_ca/core/error/exception.dart';
import 'package:latihan_ca/features/todo/data/models/todo_model.dart';
import 'package:http/http.dart' as http;

abstract class TodoRemoteDatasource {
  Future<List<TodoModel>> getAllTodo();
}

class TodoRemoteDatasourceImplementation implements TodoRemoteDatasource {
  final http.Client client;

  const TodoRemoteDatasourceImplementation({required this.client});
  @override
  Future<List<TodoModel>> getAllTodo() async {
    final Uri url = Uri.https("jsonplaceholder.typicode.com", "/todos");
    final response = await client.get(url);
    if (response.statusCode == 200) {
      var dataBody = jsonDecode(response.body);
      if (dataBody.isEmpty) {
        throw EmptyException(message: "Data Not Found");
      }
      return TodoModel.listFromJson(dataBody);
    } else if (response.statusCode == 404) {
      throw StatusCodeException(message: "Error 404");
    } else if (response.statusCode == 500) {
      throw ServerException(message: "Internal Server Error");
    } else {
      throw GeneralException(message: "General Exception");
    }
  }
}

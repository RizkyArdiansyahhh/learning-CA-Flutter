import 'package:hive/hive.dart';
import 'package:latihan_ca/features/todo/data/models/todo_model.dart';

abstract class TodoLocalDatasource {
  Future<List<TodoModel>> getAllTodo();
}

class TodoLocalDatasourceImplementation implements TodoLocalDatasource {
  @override
  Future<List<TodoModel>> getAllTodo() {
    final box = Hive.box("todo_box");
    return box.get("getAllTodo");
  }
}

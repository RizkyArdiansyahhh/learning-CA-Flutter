import 'package:latihan_ca/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:latihan_ca/features/todo/data/models/todo_model.dart';

void main() async {
  final TodoRemoteDatasourceImplementation todoRemoteDatasourceImplementation =
      TodoRemoteDatasourceImplementation();

  var result = await todoRemoteDatasourceImplementation.getAllTodo();

  for (var e in result) {
    print(e.toJson());
  }
}

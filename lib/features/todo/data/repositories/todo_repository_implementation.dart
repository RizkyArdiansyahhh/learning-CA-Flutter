import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:latihan_ca/core/error/failure.dart';
import 'package:latihan_ca/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:latihan_ca/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:latihan_ca/features/todo/data/models/todo_model.dart';
import 'package:latihan_ca/features/todo/domain/entities/todo.dart';
import 'package:latihan_ca/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImplementation extends TodoRepository {
  final TodoLocalDatasource todoLocalDatasource;
  final TodoRemoteDatasource todoRemoteDatasource;

  TodoRepositoryImplementation({
    required this.todoLocalDatasource,
    required this.todoRemoteDatasource,
  });
  @override
  Future<Either<Failure, List<Todo>>> getAllTodo() async {
    try {
      final List<ConnectivityResult> connectivityResult = await (Connectivity()
          .checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // panggil datasource local
        List<TodoModel> result = await todoLocalDatasource.getAllTodo();
        return right(result);
      } else {
        List<TodoModel> result = await todoRemoteDatasource.getAllTodo();
        final box = Hive.box("todo_box");
        box.put("getAllTodo", result);
        return right(result);
      }
    } catch (e) {
      return left(Failure());
    }
  }
}

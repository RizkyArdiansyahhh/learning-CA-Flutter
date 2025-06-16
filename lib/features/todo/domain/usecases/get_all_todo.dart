import 'package:dartz/dartz.dart';
import 'package:latihan_ca/core/error/failure.dart';
import 'package:latihan_ca/features/todo/domain/entities/todo.dart';
import 'package:latihan_ca/features/todo/domain/repositories/todo_repository.dart';

class GetAllTodo {
  final TodoRepository todoRepository;
  const GetAllTodo(this.todoRepository);

  Future<Either<Failure, List<Todo>>> execute() async {
    return await todoRepository.getAllTodo();
  }
}

import 'package:dartz/dartz.dart';
import 'package:latihan_ca/core/error/failure.dart';
import 'package:latihan_ca/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getAllTodo();
}

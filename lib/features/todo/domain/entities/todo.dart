import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int userId;
  final int id;
  final String title;
  final bool isCompleted;

  const Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [userId, id, title, isCompleted];
}

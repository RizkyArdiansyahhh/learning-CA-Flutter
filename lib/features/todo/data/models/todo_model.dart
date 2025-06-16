import 'package:latihan_ca/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.isCompleted,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      isCompleted: json["completed"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "id": id,
      "title": title,
      "completed": isCompleted,
    };
  }

  static List<TodoModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((e) => TodoModel.fromJson(e)).toList();
  }
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:latihan_ca/core/error/exception.dart';
import 'package:latihan_ca/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:latihan_ca/features/todo/data/models/todo_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<TodoRemoteDatasource>(), MockSpec<http.Client>()])
import 'todo_remote_datasource_test.mocks.dart';

void main() {
  var remoteDatasource = MockTodoRemoteDatasource();
  var fakeClient = MockClient();
  var todoRemoteDatasourceImplementation = TodoRemoteDatasourceImplementation(
    client: fakeClient,
  );

  Map<String, dynamic> fakeJson = {
    "userId": 1,
    "id": 1,
    "title": "delectus aut autem",
    "completed": false,
  };
  TodoModel fakeListTodoModel = TodoModel.fromJson(fakeJson);

  final Uri url = Uri.https("jsonplaceholder.typicode.com", "/todos");

  group("Todo Remote Datasource", () {
    test("should return List<TodoModel> if success", () async {
      // Stubbing
      when(
        remoteDatasource.getAllTodo(),
      ).thenAnswer((_) async => [fakeListTodoModel]);

      final response = await remoteDatasource.getAllTodo();
      expect(response, [fakeListTodoModel]);
    });
    test("should throw Exception if failed", () {
      when(remoteDatasource.getAllTodo()).thenThrow(Exception());

      expect(
        () async => await remoteDatasource.getAllTodo(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group("Todo Remote Datasource Implementation", () {
    test("should return List<TodoModel> if success", () async {
      when(
        fakeClient.get(url),
      ).thenAnswer((_) async => http.Response(jsonEncode([fakeJson]), 200));

      var response = await todoRemoteDatasourceImplementation.getAllTodo();
      expect(response, [fakeListTodoModel]);
    });
    test("should throw EmptyException if return {}", () async {
      when(
        fakeClient.get(url),
      ).thenAnswer((_) async => http.Response(jsonEncode({}), 200));

      expect(
        () async => await todoRemoteDatasourceImplementation.getAllTodo(),
        throwsA(isA<EmptyException>()),
      );
    });
    test("should throw StatusCodeException if statusCode 404", () async {
      when(
        fakeClient.get(url),
      ).thenAnswer((_) async => http.Response("Not Found", 404));
      expect(
        () async => await todoRemoteDatasourceImplementation.getAllTodo(),
        throwsA(isA<StatusCodeException>()),
      );
    });
    test("should throw ServerException if statusCode 500", () async {
      when(
        fakeClient.get(url),
      ).thenAnswer((_) async => http.Response("Server Error", 500));
      expect(
        () async => await todoRemoteDatasourceImplementation.getAllTodo(),
        throwsA(isA<ServerException>()),
      );
    });
    test("should throw GeneralException", () async {
      when(
        fakeClient.get(url),
      ).thenThrow(const GeneralException(message: "Genral Exception"));
      expect(
        () async => await todoRemoteDatasourceImplementation.getAllTodo(),
        throwsA(isA<GeneralException>()),
      );
    });
  });
}

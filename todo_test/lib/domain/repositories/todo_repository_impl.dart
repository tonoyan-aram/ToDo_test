import 'package:todo_test/domain/models/todo_model.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodoList();
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
}

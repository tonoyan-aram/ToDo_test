import 'package:todo_test/domain/todo_model.dart';

class TodoRepo implements TodoRepository {
  final List<Todo> _storage = [];

  @override
  Future<List<Todo>> getTodoList() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_storage);
  }

  @override
  Future<void> addTodo(Todo todo) async {
    _storage.add(todo);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final index = _storage.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _storage[index] = todo;
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    _storage.removeWhere((t) => t.id == id);
  }

  @override
  Future<void> deleteCompleted() async {
    _storage.removeWhere((t) => t.isCompleted);
  }
}

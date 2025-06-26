import 'package:flutter/foundation.dart';
import 'package:todo_test/domain/models/todo_model.dart';
import 'package:todo_test/domain/repositories/todo_repository_impl.dart';
import 'package:uuid/uuid.dart';

class TodoProvider extends ChangeNotifier {
  final TodoRepository repository;
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  String _filter = 'all';

  TodoProvider(this.repository) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    _todos = await repository.getTodoList();
    notifyListeners();
  }

  void setFilter(String value) {
    _filter = value;
    notifyListeners();
  }

  List<Todo> get filteredTodos {
    switch (_filter) {
      case 'active':
        return _todos.where((t) => !t.isCompleted).toList();
      case 'completed':
        return _todos.where((t) => t.isCompleted).toList();
      default:
        return _todos;
    }
  }

  Future<void> add(String title, String description) async {
    final todo = Todo(
      id: const Uuid().v4(),
      title: title,
      description: description,
    );
    await repository.addTodo(todo);
    _todos = await repository.getTodoList();
    notifyListeners();
  }

  Future<void> setComplete(String id) async {
    final todo = _todos.firstWhere((t) => t.id == id);
    final updated = todo.copyWith(isCompleted: !todo.isCompleted);
    await repository.updateTodo(updated);
    _todos = await repository.getTodoList();
    notifyListeners();
  }

  Future<void> update(String id, String newTitle, String newDescription) async {
    final todo = _todos.firstWhere((t) => t.id == id);
    final updated = todo.copyWith(title: newTitle, description: newDescription);
    await repository.updateTodo(updated);
    await loadTodos();
  }

  Future<void> delete(String id) async {
    await repository.deleteTodo(id);
    _todos = await repository.getTodoList();
    notifyListeners();
  }
}

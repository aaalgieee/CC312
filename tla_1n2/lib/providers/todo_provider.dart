import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tla_1n2/models/todo.dart';

class TodoNotifier extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    final todo = Todo(
      id: DateTime.now().toString(),
      title: title,
    );
    _todos = [..._todos, todo];
    notifyListeners();
  }

  void toggleTodo(String id) {
    _todos = _todos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
    notifyListeners();
  }

  void removeTodo(String id) {
    _todos = _todos.where((todo) => todo.id != id).toList();
    notifyListeners();
  }
}

final todoProvider = ChangeNotifierProvider((ref) => TodoNotifier());

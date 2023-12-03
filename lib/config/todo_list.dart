import '../data/todo_model.dart';

class TodoList {
  static final List<TodoModel> _todos = [
    TodoModel(
        "1",
        "Welcome !",
        "Crud Feature and additional restore feature with awesome design and theme color!",
        "2/12/2023",
        "18:00")
  ];

  static List<TodoModel> get todos => _todos;

  static void addTodo(TodoModel todo) {
    if (_todos.contains(todo)) return;
    _todos.add(todo);
  }

  static void removeTodo(TodoModel todo) {
    _todos.remove(todo);
  }

  static final List<TodoModel> _doneTodos = [];

  static List<TodoModel> get doneTodos => _doneTodos;

  static void addDoneTodo(TodoModel todo) {
    if (_doneTodos.contains(todo)) return;
    _doneTodos.add(todo);
  }

  static void removeDoneTodo(TodoModel todo) {
    _doneTodos.remove(todo);
  }

  static void restoreTodo(TodoModel todo) {
    if (_todos.contains(todo)) return;
    _todos.add(todo);
  }
}

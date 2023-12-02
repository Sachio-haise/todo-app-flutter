import 'package:flutter/material.dart';
import 'package:text_3d/text_3d.dart';
import '../config/todo_list.dart';
import '../data/todo_model.dart';
import '../widgets/task_card.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
    super.key,
    required this.todoList,
    required this.onTodoDone,
    required this.onTodoDelete,
  });

  final List<TodoModel> todoList;
  final Function(TodoModel) onTodoDone;
  final Function(TodoModel) onTodoDelete;

  @override
  Widget build(BuildContext context) {
    /// if [TodoList.todos] list is empty, show a text
    if (TodoList.todos.isEmpty) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/deset.webp'), fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 60.0),
            child: Center(
              child: ThreeDText(
                text: 'Create a Todo Task 📃!',
                textStyle: const TextStyle(
                  fontSize: 30,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
                style: ThreeDStyle.inset,
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/deset.webp'), fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              todoList.length,
              (index) {
                return TaskCard(
                  todo: todoList[index],
                  onDone: () => onTodoDone(todoList[index]),
                  onDelete: () => onTodoDelete(todoList[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

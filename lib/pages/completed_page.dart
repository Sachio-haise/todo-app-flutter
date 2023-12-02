import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_card.dart';
import '../data/todo_model.dart';
import 'package:text_3d/text_3d.dart';
import '../config/todo_list.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage(
      {super.key,
      required this.doneTodoList,
      required this.onTodoRestore,
      required this.onTodoDelete});

  final List<TodoModel> doneTodoList;
  final Function(TodoModel) onTodoRestore;
  final Function(TodoModel) onTodoDelete;

  @override
  Widget build(BuildContext context) {
    /// if [TodoList.doneTodos] list is empty, show a text
    if (TodoList.doneTodos.isEmpty) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/deset.webp'), fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 60.0),
            child: Center(
              child: ThreeDText(
                text: 'No tasks has been completed 🥺!',
                textStyle: const TextStyle(
                  fontSize: 20,
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
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 2.0,
            children: List.generate(
              doneTodoList.length,
              (index) {
                return SizedBox(
                  width: double.maxFinite,
                  height: 300,
                  child: TaskCard(
                    todo: doneTodoList[index],
                    onDone: () {},
                    onRestore: () => onTodoRestore(TodoList.doneTodos[index]),
                    onDelete: () => onTodoDelete(TodoList.doneTodos[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

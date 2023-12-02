import 'package:flutter/material.dart';
import 'package:text_3d/text_3d.dart';
import '../config/todo_list.dart';
import '../data/todo_model.dart';
import '../widgets/info_card.dart';
import 'completed_page.dart';
import 'tasks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController();

  ///[currentPageIndex] indicates current page index in [BottomNavigationBar] class
  int currentPageIndex = 0;

  /// define a [TodoModel] list for maintaining temporary state
  final List<TodoModel> tempTodoList = TodoList.todos;
  final List<TodoModel> tempDoneTodoList = TodoList.doneTodos;

  /// [Widget] list to show based on selected [currentPageIndex]
  void addTodo(TodoModel todo) {
    setState(() {
      tempTodoList.add(todo);
      TodoList.addTodo(todo);
    });
  }

  void doneTodo(TodoModel todo) {
    setState(() {
      tempTodoList.remove(todo);
      TodoList.addDoneTodo(todo.copyWith(
        isDone: true,
      ));
    });
  }

  void restoreTodo(TodoModel todo) {
    setState(() {
      tempDoneTodoList.remove(todo);
      TodoList.restoreTodo(todo.copyWith(
        isDone: false,
      ));
    });
  }

  void deleteTodo(TodoModel todo) {
    setState(() {
      tempTodoList.remove(todo);
      TodoList.removeTodo(todo);
      Navigator.pop(context, 'Yes');
    });
  }

  void deleteDoneTodo(TodoModel todo) {
    setState(() {
      tempDoneTodoList.remove(todo);
      TodoList.removeDoneTodo(todo);
      Navigator.pop(context, 'Yes');
    });
  }

  void showInfoSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.45,
        ),
        builder: (context) {
          return Container(
            width: double.maxFinite,
            color: Colors.orange.shade100,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'TODO Tasks',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.orange,
                          ),
                    )),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close,
                            size: 18, color: Colors.orange))
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Row(
                      children: [
                        InfoCard(
                          label: TodoList.todos.length.toString(),
                          bgColor: Colors.orange.shade200,
                          textColor: Colors.orange,
                          infoLabel: 'todo',
                        ),
                        InfoCard(
                          label: TodoList.doneTodos.length.toString(),
                          bgColor: Colors.green.shade200,
                          textColor: Colors.green,
                          infoLabel: 'done',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.0,
        title: ThreeDText(
          text: 'My Todo Lists',
          textStyle: const TextStyle(fontSize: 40, color: Colors.orange),
          depth: 30,
          style: ThreeDStyle.perspectiveInset,
          angle: 1 / 6,
          perspectiveDepth: 30,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              iconSize: 28,
              foregroundColor: Colors.orange,
            ),
            icon: const Icon(Icons.info),

            /// shows a information bottom sheet
            onPressed: showInfoSheet,
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          /// update [currentPageIndex] when page is scrolled
          setState(() {
            currentPageIndex = index;
          });
        },
        children: [
          TasksPage(
              todoList: tempTodoList,
              onTodoDone: doneTodo,
              onTodoDelete: deleteTodo), // index 0
          CompletedPage(
              doneTodoList: tempDoneTodoList,
              onTodoRestore: restoreTodo,
              onTodoDelete: deleteDoneTodo), // index 1
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          final returnVal = await Navigator.pushNamed(context, '/new_task');
          if (returnVal != null) {
            addTodo(returnVal as TodoModel);
          }
        },
        child: const Icon(
          Icons.add_task_rounded,
          color: Colors.orange,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          pageController.animateToPage(currentPageIndex,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut);
        },
        elevation: 0.0,
        fixedColor: Colors.orange,
        currentIndex: currentPageIndex,
        backgroundColor: Colors.orange.shade50,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.sticky_note_2_rounded),
            icon: Icon(Icons.sticky_note_2_outlined),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.task_rounded),
            icon: Icon(Icons.task_outlined),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}

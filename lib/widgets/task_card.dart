import 'package:flutter/material.dart';
import 'package:todo_app/data/todo_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {super.key,
      required this.todo,
      this.onDone,
      this.onDelete,
      this.onRestore});

  final TodoModel todo;
  final void Function()? onDone;
  final void Function()? onDelete;
  final void Function()? onRestore;

  @override
  Widget build(BuildContext context) {
    void editAction(instance) {
      Navigator.pushReplacementNamed(context, '/edit', arguments: {
        'title': instance.title,
        'description': instance.description,
        'id': instance.id
      });
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 10,
        shadowColor: Colors.orange.shade300,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: BoxConstraints(
            minWidth: 100.0,
            maxWidth: MediaQuery.of(context).size.width,
            minHeight: 300.0,
            maxHeight: MediaQuery.of(context).size.height,
          ),
          padding: EdgeInsets.all(todo.isDone ? 14 : 10),
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade300, width: 2.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!todo.isDone)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            todo.date,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            todo.time,
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        width: !todo.isDone ? 140.0 : 320.0,
                        height: 32.0,
                        child: Text(
                          todo.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ]),
                    Text(
                      todo.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!todo.isDone)
                    Row(
                      children: [
                        ...[
                          SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.blue.shade100,
                              ),
                              iconSize: 12,
                              onPressed: () {
                                editAction(todo);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                            width: 5.0,
                          ),
                          SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: IconButton(
                              iconSize: 14.0,
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.green.shade100,
                              ),
                              onPressed: onDone,
                              icon: const Icon(
                                Icons.task_alt,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  if (todo.isDone)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...[
                          Text(
                            todo.date,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            todo.time,
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  Row(
                    children: [
                      if (todo.isDone) ...[
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: IconButton(
                            iconSize: 14.0,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.yellow[500],
                            ),
                            onPressed: onRestore,
                            icon: const Icon(
                              Icons.restore,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 5.0,
                        width: 5.0,
                      ),
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: IconButton(
                          iconSize: 14.0,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Danger!',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              content: const Text(
                                  'Are you sure you want to permanently delete this note?',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.normal)),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.black),
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white),
                                  onPressed: onDelete,
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          ),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

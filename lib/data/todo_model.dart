class TodoModel {
  String id;
  String title;
  String description;
  String date;
  String time;
  bool isDone;

  TodoModel(this.id, this.title, this.description, this.date, this.time,
      {this.isDone = false});

  /// [copyWith] method copies current [TodoModel] class and update some fields
  TodoModel copyWith(
      {String? id,
      String? title,
      String? description,
      String? date,
      String? time,
      bool isDone = false}) {
    return TodoModel(
      id ?? this.id,
      title ?? this.title,
      description ?? this.description,
      date ?? this.date,
      time ?? this.time,
      isDone: isDone ?? this.isDone,
    );
  }
}

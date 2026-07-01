class TaskModel {
  final int? id;
  final String text;
  final bool isDone;

  TaskModel({this.id, required this.text, required this.isDone});

  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'isDone': isDone ? 1 : 0};
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      text: map['text'],
      isDone: map['isDone'] == 1 ? true : false,
    );
  }
}

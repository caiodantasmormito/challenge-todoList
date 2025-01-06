class TodoModel {
  String? sId;
  String? todoTitle;
  String? todoDescription;
  bool? finished;

  TodoModel({this.sId, this.todoTitle, this.todoDescription, this.finished});

  TodoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    todoTitle = json['todo_title'];
    todoDescription = json['todo_description'];
    finished = json['finished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['todo_title'] = todoTitle;
    data['todo_description'] = todoDescription;
    data['finished'] = finished;
    return data;
  }
}

class TodoModel {
  String? sId;
  String? todoTitle;
  String? todoDescription;
  bool? finished;

  TodoModel({this.sId, this.todoTitle, this.todoDescription, this.finished});

  TodoModel.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    todoTitle = json['title'];
    todoDescription = json['description'];
    finished = json['finished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = sId;
    data['title'] = todoTitle;
    data['description'] = todoDescription;
    data['finished'] = finished;
    return data;
  }
}

import 'package:flutter/material.dart';
import 'package:todo_list/helper/http.dart';
import 'package:todo_list/helper/navigator.dart';
import 'package:todo_list/src/model/todo_model.dart';
import 'package:todo_list/src/view/todo_create.dart';
import 'package:todo_list/src/view/todo_edit.dart';
import 'package:todo_list/src/view/todo_finished.dart';
import 'package:todo_list/src/view/todo_list.dart';

class TodoViewModel extends ChangeNotifier {
  final NavigationService _navigationService;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  List<TodoModel> allTodos = [];
  List<TodoModel> get finishedTodos =>
      allTodos.where((todo) => todo.finished == true).toList();

  TodoViewModel(this._navigationService) {
    getAllTodos();
  }

  navigateToCreate() {
    _navigationService.navigate(const TodoCreate());
  }
  navigateToFinisheds() {
    _navigationService.navigate(const TodoFinished());
  }

  navigateToEdit(TodoModel data) {
    titlecontroller.text = data.todoTitle.toString();
    descriptioncontroller.text = data.todoDescription.toString();

    _navigationService.navigate(TodoEdit(tododata: data));
  }

  getAllTodos() async {
    _navigationService.showLoader();
    var resData = await ApiProvider().get('/caio-todolist');
    allTodos =
        resData.map<TodoModel>((item) => TodoModel.fromJson(item)).toList();
    print(allTodos);
    _navigationService.goBack();
    notifyListeners();
  }

  createTodo() async {
    _navigationService.showLoader();
    var resData = await ApiProvider().post('/caio-todolist', {
      "todo_title": titlecontroller.text,
      "todo_description": descriptioncontroller.text,
      "finished": false
    });
    if (resData) {
      getAllTodos();
      _navigationService.goBack();
      _navigationService.navigate(const TodoList());
      titlecontroller.clear();
      descriptioncontroller.clear();
    }
  }

  editTodo(id, bool isFinished) async {
    _navigationService.showLoader();
    var resData = await ApiProvider().put('/caio-todolist/$id', {
      "todo_title": titlecontroller.text,
      "todo_description": descriptioncontroller.text,
      "finished": isFinished
    });
    if (resData) {
      getAllTodos();
      _navigationService.goBack();
      _navigationService.navigate(const TodoList());
      titlecontroller.clear();
      descriptioncontroller.clear();
    }
  }

  deleteTodo(id, index) async {
    _navigationService.showLoader();
    var resData = await ApiProvider().delete("/caio-todolist/$id");
    _navigationService.goBack();
    if (resData) {
      allTodos.removeAt(index);
      notifyListeners();
    } else {
      print('Não foi possivel excluir');
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/helper/http.dart';
import 'package:todo_list/helper/navigator.dart';
import 'package:todo_list/src/model/todo_model.dart';
import 'package:todo_list/src/view/todo_create.dart';
import 'package:todo_list/src/view/todo_edit.dart';
import 'package:todo_list/src/view/todo_finished.dart';

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
    var resData = await ApiProvider().get('/todos');
    allTodos =
        resData.map<TodoModel>((item) => TodoModel.fromJson(item)).toList();
    if (kDebugMode) {
      print(allTodos);
    }
    _navigationService.goBack();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  getFinishedTodos() async {
    _navigationService.showLoader();
    try {
      var resData = await ApiProvider().get('/todos');
      allTodos =
          resData.map<TodoModel>((item) => TodoModel.fromJson(item)).toList();

      var finishedTodos =
          allTodos.where((task) => task.finished == true).toList();

      if (kDebugMode) {
        print(finishedTodos);
      }
      _navigationService.goBack();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

      return finishedTodos;
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar tasks: $e');
      }
      _navigationService.goBack();
      return [];
    }
  }

  createTodo() async {
    _navigationService.showLoader();
    var resData = await ApiProvider().post('/todos', {
      "title": titlecontroller.text,
      "description": descriptioncontroller.text,
      "finished": false
    });
    if (resData) {
      getAllTodos();
      _navigationService.goBack();
      //_navigationService.navigate(const TodoList());
      titlecontroller.clear();
      descriptioncontroller.clear();
    }
  }

  editTodo(id, bool isFinished) async {
    _navigationService.showLoader();
    var resData = await ApiProvider().put('/todos/$id', {
      "title": titlecontroller.text,
      "description": descriptioncontroller.text,
      "finished": isFinished
    });
    if (resData) {
      getAllTodos();
      _navigationService.goBack();

      titlecontroller.clear();
      descriptioncontroller.clear();
    }
  }

  deleteTodo(id, index) async {
    _navigationService.showLoader();
    var resData = await ApiProvider().delete("/todos/$id");
    _navigationService.goBack();
    if (resData) {
      allTodos.removeAt(index);
      getAllTodos();
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('Não foi possivel excluir');
      }
    }
  }

  deleteAllFinishedTodos() async {
    _navigationService.showLoader();
    try {
      var finishedTasks =
          allTodos.where((task) => task.finished == true).toList();

      if (finishedTasks.isNotEmpty) {
        for (var task in finishedTasks) {
          var resData = await ApiProvider().delete("/todos/${task.sId}");
          if (resData) {
            allTodos.remove(task);
          } else {
            if (kDebugMode) {
              print("Falha ao excluir task com ID: ${task.sId}");
            }
          }
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      } else {
        if (kDebugMode) {
          print("Não há tasks finalizadas para excluir.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao excluir tasks finalizadas: $e");
      }
    } finally {
      _navigationService.goBack();
    }
  }

  void updateTodoStatus(String id, bool isFinished) async {
    _navigationService.showLoader();
    try {
      await ApiProvider().put('/todos/$id', {'finished': isFinished});

      final index = allTodos.indexWhere((todo) => todo.sId == id);
      if (index != -1) {
        allTodos[index].finished = isFinished;
        _navigationService.goBack();
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao atualizar o status da tarefa: $e');
      }
    }
  }
}

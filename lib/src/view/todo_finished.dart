import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/viewmodel/todo_viewmodel.dart';

class TodoFinished extends StatelessWidget {
  const TodoFinished({super.key});

  @override
  Widget build(BuildContext context) {
    final todocontroller = Provider.of<TodoViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("TODO FINALIZADO"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          ListView.builder(
              itemCount: todocontroller.finishedTodos.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.white,
                      title:
                          Text(todocontroller.allTodos[i].todoTitle.toString()),
                      subtitle: Text(todocontroller.allTodos[i].todoDescription
                          .toString()),
                      trailing: PopupMenuButton(
                        child: const Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text("EDITAR"),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text("DELETAR"),
                          )
                        ],
                        onSelected: (String value) {
                          if (value == "edit") {
                            todocontroller
                                .navigateToEdit(todocontroller.allTodos[i]);
                          }
                          if (value == "delete") {
                            todocontroller.deleteTodo(
                                todocontroller.allTodos[i].sId.toString(), i);
                          }
                        },
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

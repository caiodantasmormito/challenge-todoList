import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/helper/widgets/custom_button.dart';
import 'package:todo_list/src/viewmodel/todo_viewmodel.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final todocontroller = Provider.of<TodoViewModel>(context);

    final unfinishedTodos = todocontroller.allTodos
        .where((todo) => todo.finished == false || todo.finished == null)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("TODO LIST"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: unfinishedTodos.length,
                itemBuilder: (BuildContext context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        tileColor: Colors.white,
                        title: Text(unfinishedTodos[i].todoTitle.toString()),
                        subtitle:
                            Text(unfinishedTodos[i].todoDescription.toString()),
                        trailing: PopupMenuButton(
                          color: Colors.white,
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
                              todocontroller.navigateToEdit(unfinishedTodos[i]);
                            }
                            if (value == "delete") {
                              todocontroller.deleteTodo(
                                unfinishedTodos[i].sId.toString(),
                                i,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                todocontroller.navigateToCreate();
              },
              child: CustomButton(label: 'Criar tarefa'),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                todocontroller.navigateToFinisheds();
              },
              child: CustomButton(label: 'Consultar finalizados'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/helper/widgets/custom_button.dart';
import 'package:todo_list/helper/widgets/welcome_user.dart';
import 'package:todo_list/src/viewmodel/todo_viewmodel.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();

    final todocontroller = Provider.of<TodoViewModel>(context, listen: false);
    todocontroller.getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    final todocontroller = Provider.of<TodoViewModel>(context);

    final unfinishedTodos = todocontroller.allTodos
        .where((todo) => todo.finished == false || todo.finished == null)
        .toList();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeUser(),
            const SizedBox(height: 8),
            Text(
              "You've got ${unfinishedTodos.length.toString()} tasks to do.",
              style: GoogleFonts.urbanist(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: unfinishedTodos.length,
                itemBuilder: (context, i) {
                  if (unfinishedTodos.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                        SvgPicture.asset('assets/create_task_vector.svg'),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'You have no task listed.',
                          style: GoogleFonts.urbanist(
                              fontSize: 16, color: const Color(0xFF8D9CB8)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        InkWell(
                            onTap: () {
                              todocontroller.createTodo();
                            },
                            child: CustomButton(label: 'Create Task'))
                      ],
                    );
                  }
                  return Card(
                    color: const Color(0xFFF5F7F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 1,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      title: Text(
                        unfinishedTodos[i].todoTitle.toString(),
                        style:
                            GoogleFonts.urbanist(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        unfinishedTodos[i].todoDescription.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.urbanist(color: Colors.grey),
                      ),
                      leading: Checkbox(
                        value: unfinishedTodos[i].finished ?? false,
                        onChanged: (bool? value) {
                          if (value != null) {
                            todocontroller.updateTodoStatus(
                                unfinishedTodos[i].sId.toString(), value);
                          }
                        },
                      ),
                      trailing: PopupMenuButton<String>(
                        color: const Color(0xFFF5F7F9),
                        onSelected: (String value) {
                          /*if (value == "edit") {
                            todocontroller.navigateToEdit(unfinishedTodos[i]);
                          } else */
                          if (value == "delete") {
                            todocontroller.deleteTodo(
                              unfinishedTodos[i].sId.toString(),
                              i,
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          /*const PopupMenuItem(
                            value: 'edit',
                            child: Text("EDITAR"),
                          ),*/
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text("DELETAR"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

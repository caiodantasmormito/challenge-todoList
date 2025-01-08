import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/viewmodel/todo_viewmodel.dart';

class TodoFinished extends StatefulWidget {
  const TodoFinished({super.key});

  @override
  State<TodoFinished> createState() => _TodoFinishedState();
}

class _TodoFinishedState extends State<TodoFinished> {
  @override
  void initState() {
    super.initState();

    final todocontroller = Provider.of<TodoViewModel>(context, listen: false);

    todocontroller.getFinishedTodos();
  }

  @override
  Widget build(BuildContext context) {
    final todocontroller = Provider.of<TodoViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Completed Tasks, ',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () async {
                  if (todocontroller.finishedTodos.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Não há tasks finalizadas para excluir.",
                          style: GoogleFonts.urbanist(),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } else {
                    await todocontroller.deleteAllFinishedTodos();
                  }
                },
                child: Text(
                  'Delete all',
                  style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF5E5E)),
                ),
              ),
            ],
          ),
          ListView.builder(
              itemCount: todocontroller.finishedTodos.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 1,
                    color: const Color(0xFFF5F7F9),
                    child: ListTile(
                        title: Text(
                            todocontroller.allTodos[i].todoTitle.toString()),
                        subtitle: Text(todocontroller
                            .allTodos[i].todoDescription
                            .toString()),
                        leading: const Icon(
                          Icons.check_box_rounded,
                          color: Color(0xFFC6CFDC),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            todocontroller.deleteTodo(
                                todocontroller.allTodos[i].sId.toString(), i);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )),
                  ),
                );
              })
        ],
      ),
    );
  }
}

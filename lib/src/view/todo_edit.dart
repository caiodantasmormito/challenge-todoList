import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/viewmodel/todo_viewmodel.dart';

class TodoEdit extends StatefulWidget {
  final tododata;
  const TodoEdit({super.key, required this.tododata});

  @override
  State<TodoEdit> createState() => _TodoEditState();
}

class _TodoEditState extends State<TodoEdit> {
  final formKey = GlobalKey<FormState>();
  late bool isFinished; // Variável para armazenar o estado "finalizado"

  @override
  void initState() {
    super.initState();
    // Inicializa `isFinished` com o valor atual da tarefa
    isFinished = widget.tododata.finished ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final todocontroller = Provider.of<TodoViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("EDITAR"),
      ),
      body: Form(
        key: formKey,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 25),
              Container(
                width: 400,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: todocontroller.titlecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Color(0xFF449988)),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Título",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: 400,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: todocontroller.descriptioncontroller,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Color(0xFF449988)),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Descrição",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    checkColor: Color(0xFF449988),
                    activeColor: Colors.white,
                    value: isFinished,
                    onChanged: (value) {
                      setState(() {
                        isFinished = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    "Marcar como finalizado",
                    style: TextStyle(color: Color(0xFF449988), fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    todocontroller.editTodo(widget.tododata.sId, isFinished);
                  }
                },
                child: Container(
                  width: 400,
                  height: 55,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Center(
                    child: Text(
                      "SALVAR",
                      style: TextStyle(
                          color: Color(0xFF449988), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

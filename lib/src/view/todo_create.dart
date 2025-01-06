import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/helper/widgets/custom_button.dart';
import 'package:todo_list/src/viewmodel/todo_viewmodel.dart';

class TodoCreate extends StatefulWidget {
  const TodoCreate({super.key});

  @override
  State<TodoCreate> createState() => _TodoCreateState();
}

class _TodoCreateState extends State<TodoCreate> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final todocontroller = Provider.of<TodoViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("TODO LIST"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
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
                      border: OutlineInputBorder(),
                      hintText: "Digite o título",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: 400,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: todocontroller.descriptioncontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Color(0xFF449988)),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Descrição",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      todocontroller.createTodo();
                    }
                  },
                  child: CustomButton(label: 'SALVAR'))
            ],
          ),
        ),
      ),
    );
  }
}

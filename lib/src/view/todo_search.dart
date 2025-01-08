import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/viewmodel/todo_viewmodel.dart';

class TodoSearch extends StatefulWidget {
  const TodoSearch({super.key});

  @override
  State<TodoSearch> createState() => _TodoSearchState();
}

class _TodoSearchState extends State<TodoSearch> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoController = Provider.of<TodoViewModel>(context);
    final query = _searchController.text.toLowerCase();

    final filteredTasks = query.isEmpty
        ? []
        : todoController.allTodos
            .where((task) => task.todoTitle!.toLowerCase().contains(query))
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          TextFormField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: "Search tasks",
              hintStyle: GoogleFonts.urbanist(),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF007FFF),
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Color(0xFF007FFF),
                      ),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          filteredTasks.isEmpty
              ? Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.193),
                      SvgPicture.asset(
                        'assets/create_task_vector.svg',
                      ),
                      const SizedBox(height: 24),
                      Text(
                        query.isEmpty
                            ? "Type something to search."
                            : "No results found.",
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return Card(
                        color: const Color(0xFFF5F7F9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            task.todoTitle.toString(),
                            style: GoogleFonts.urbanist(),
                          ),
                          subtitle: Text(
                            task.todoDescription ?? "",
                            style: GoogleFonts.urbanist(),
                          ),
                          leading: Checkbox(
                            value: filteredTasks[index].finished ?? false,
                            onChanged: (bool? value) {
                              if (value != null) {
                                todoController.updateTodoStatus(
                                    filteredTasks[index].sId.toString(), value);
                              }
                            },
                          ),
                          /*trailing: task.finished!
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : const Icon(Icons.circle_outlined,
                                  color: Colors.grey),
                          onTap: () {
                            todoController.navigateToEdit(task);
                          },*/
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

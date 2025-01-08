import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/helper/widgets/custom_button.dart';
import 'package:todo_list/helper/widgets/welcome_user.dart';
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
    Provider.of<TodoViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const WelcomeUser(),
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
                _showCreateTaskModal(context);
              },
              child: CustomButton(label: 'Create Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateTaskModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final todocontroller = Provider.of<TodoViewModel>(context);
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Padding(
            padding: EdgeInsets.only(
              left: 34,
              right: 16,
              top: 42,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: todocontroller.titlecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task title';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: "What’s in your mind?",
                    hintStyle: GoogleFonts.urbanist(),
                    prefixIcon: const Icon(
                      Icons.check_box_outline_blank_rounded,
                      color: Color(0xFFC6CFDC),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFC6CFDC)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Color(0xFFC6CFDC), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: todocontroller.descriptioncontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task title';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: "Add a note...",
                    hintStyle: GoogleFonts.urbanist(),
                    prefixIcon: Image.asset(
                      'assets/pencil_vector.png',
                      scale: 1,
                      color: const Color(0xFFC6CFDC),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFC6CFDC)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Color(0xFFC6CFDC), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          todocontroller.createTodo();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Create',
                        style: GoogleFonts.urbanist(
                          color: const Color(0xFF007FFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

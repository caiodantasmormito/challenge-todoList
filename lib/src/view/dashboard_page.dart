import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/src/view/todo_create.dart';
import 'package:todo_list/src/view/todo_finished.dart';
import 'package:todo_list/src/view/todo_list.dart';
import 'package:todo_list/src/view/todo_search.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int currentPage = 0;
  final List<Widget> screens = [
    const TodoList(),
    const TodoCreate(),
    const TodoSearch(),
    const TodoFinished()
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 38),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.check_box, color: Colors.blue, size: 28),
                  const SizedBox(width: 7),
                  Text(
                    'Taski',
                    style: GoogleFonts.urbanist(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                  ),
                  Text(
                    'John',
                    style: GoogleFonts.urbanist(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.png'),
                    radius: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(child: screens[currentPage])
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(31),
            topLeft: Radius.circular(31),
          ),
          child: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: (index) => setState(
              () => currentPage = index,
            ),
            showUnselectedLabels: true,
            unselectedItemColor: const Color(0xFFC6CFDC),
            selectedItemColor: const Color(0xFF007FFF),
            selectedLabelStyle: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF007FFF)),
            ),
            unselectedLabelStyle: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SvgPicture.asset(
                    currentPage == 0
                        ? 'assets/todo_vector.svg'
                        : 'assets/unselected_todo_vector.svg',
                    height: 28,
                  ),
                ),
                label: 'Todo',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SvgPicture.asset(
                    'assets/create_vector.svg',
                    height: 28,
                    color: currentPage == 1
                        ? const Color(0xFF007FFF)
                        : const Color(0xFFC6CFDC),
                  ),
                ),
                label: 'Create',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SvgPicture.asset(
                    'assets/search_vector.svg',
                    height: 28,
                    color: currentPage == 2
                        ? const Color(0xFF007FFF)
                        : const Color(0xFFC6CFDC),
                  ),
                ),
                label: 'Search',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SvgPicture.asset(
                    'assets/done_vector.svg',
                    height: 28,
                    color: currentPage == 3
                        ? const Color(0xFF007FFF)
                        : const Color(0xFFC6CFDC),
                  ),
                ),
                label: 'Done',
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      );
}

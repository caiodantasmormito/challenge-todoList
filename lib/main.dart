import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/helper/navigator.dart';
import 'package:todo_list/src/view/dashboard_page.dart';
import 'package:todo_list/src/viewmodel/todo_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoViewModel>(
            create: (_) => TodoViewModel(NavigationService.instance))
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.instance.navigationKey,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DashBoardPage(),
      ),
    );
  }
}

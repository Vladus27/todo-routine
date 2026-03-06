import 'package:flutter/material.dart';
import 'package:todo_routine/theme/theme.dart';

import 'package:todo_routine/screens/main_page_screen.dart';

class TodoRoutineApp extends StatelessWidget {
  const TodoRoutineApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      darkTheme: themeDark,
      theme: themeLight,
      debugShowCheckedModeBanner: false, // remove Debug label
      home: const MainPageScreen(),      
      //themeMode: ThemeMode.system,
      // this parametr isn `t required because ThemeMode.system setting by default for dark mode
    );
  }
}

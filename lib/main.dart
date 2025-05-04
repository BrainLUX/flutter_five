import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/screens/todo_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем hive
  await Hive.initFlutter();
  // Регистрируем адаптер
  Hive.registerAdapter(TodoAdapter());

  await Hive.openBox<Todo>('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoScreen(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/theme/app_colors.dart';
import 'package:todo/widgets/todo_item_widget.dart';

import '../models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool _isCompletedHidden = false;
  final _textController = TextEditingController();
  late Box<Todo> _todoBox;

  @override
  void initState() {
    super.initState();
    _todoBox = Hive.box<Todo>('todos');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _toggleTodo(int index, bool isCompleted) {
    final current = _todoBox.getAt(index)!;
    final updated = current.setCompleted(isCompleted);
    _todoBox.putAt(index, updated); // обновляем в Hive
  }

  void _removeTodo(int index) {
    _todoBox.deleteAt(index); // удаляем из Hive
  }

  void _addTodo() {
    // Получаем текст задачи
    final taskTitle = _textController.text;

    // Если текстовое поле пустое, то ничего не делаем
    if (taskTitle.isEmpty) return;

    // Создаем новую задачу
    final newTodo = Todo(
      title: taskTitle,
      createdAt: DateTime.now(),
    );

    // Добавляем задачу в список
    _todoBox.add(newTodo); // сохраняем в Hive
    _textController.clear();
  }

  void _toggleActiveVisibility() {
    setState(() {
      _isCompletedHidden = !_isCompletedHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Задачи'),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        titleTextStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: AppColors.titleColor,
            ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              onPressed: _toggleActiveVisibility,
              child: Text(
                _isCompletedHidden ? 'Показать все' : 'Спрятать завершенные',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.textButtonColor,
                    ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _todoBox.listenable(),
                builder: (context, todoList, _) => ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    final todo = todoList.get(index)!;
                    if (todo.isCompleted && _isCompletedHidden) return SizedBox.shrink();
                    return TodoItemWidget(
                      todo: todo,
                      onToggle: (isCompleted) => _toggleTodo(index, isCompleted),
                      onRemove: () => _removeTodo(index),
                    );
                  },
                  separatorBuilder: (context, index) {
                    final todo = todoList.get(index)!;
                    if (todo.isCompleted && _isCompletedHidden) return SizedBox.shrink();
                    return SizedBox(
                      height: 18,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: TextField(
                controller: _textController,
                style: TextStyle(color: AppColors.textColor),
                onSubmitted: (_) {
                  // Добавляем задачу
                  _addTodo();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: AppColors.hintColor),
                  hintText: 'Введите задачу...',
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // Добавляем задачу
                      _addTodo();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

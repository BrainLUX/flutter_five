import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/todo_details_screen.dart';
import 'package:todo/theme/app_colors.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    required this.todo,
    required this.onToggle,
    required this.onRemove,
    super.key,
  });

  // Объект задачи
  final Todo todo;
  final ValueChanged onToggle;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TodoDetailsPage(todo: todo),
            ),
          );
        },
        // Кнопка для переключения статуса задачи
        leading: Transform.scale(
          scale: 1.5,
          child: Checkbox(
            shape: CircleBorder(side: BorderSide()),
            side: WidgetStateBorderSide.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return BorderSide(style: BorderStyle.none);
              } else {
                return BorderSide(
                  color: AppColors.radioButtonColor,
                  width: 1,
                );
              }
            }),
            checkColor: AppColors.radioButtonColor,
            activeColor: AppColors.backgroundColor,
            value: todo.isCompleted,
            onChanged: onToggle,
          ),
        ),
        // Текст с названием задачи
        title: Text(
          todo.title,
          style: TextStyle(
            decorationColor: AppColors.textDisabledColor,
            decoration: todo.isCompleted == true ? TextDecoration.lineThrough : null,
            color: todo.isCompleted == true ? AppColors.textDisabledColor : AppColors.textColor,
          ),
        ),
        // Кнопка для удаления задачи
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: AppColors.textDisabledColor,
          ),
          onPressed: onRemove,
        ),
      );
}

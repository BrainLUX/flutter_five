import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/theme/app_colors.dart';

class TodoDetailsPage extends StatelessWidget {
  final Todo todo;

  const TodoDetailsPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.titleColor,
          ),
          title: const Text('Детали задачи'),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          titleTextStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppColors.titleColor,
              ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Создано: ${todo.createdAt.toString().split(' ')[0]}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textDisabledColor,
                ),
              ),
            ],
          ),
        ),
      );
}

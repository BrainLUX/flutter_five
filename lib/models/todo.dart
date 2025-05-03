import 'package:hive/hive.dart';

part 'todo.g.dart'; // это для генерации адаптера

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime createdAt;

  @HiveField(2)
  final bool isCompleted;

  // Конструктор
  const Todo({
    required this.title,
    required this.createdAt,
    this.isCompleted = false,
  });

  // Метод для отметки задачи как выполненной
  Todo setCompleted(bool isCompleted) => Todo(title: title, createdAt: createdAt, isCompleted: isCompleted);
}

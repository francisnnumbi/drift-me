import 'package:drift_me/database/my_database.dart';

class TodoModel{
  final Todo todo;
  final Category? category;
  TodoModel({required this.todo, this.category});
  get id => todo.id;
  get title => todo.title;
  get content => todo.content;
  get categoryId => todo.category;
  get description => category?.description;

  get shortContent => content.length > 50 ? '${content.substring(0, 50)}...' : content;
}
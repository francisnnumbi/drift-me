import 'package:drift_me/database/my_database.dart';
import 'package:get/get.dart';

import '../main.dart';

class CategoryModel{
  final todos = <Todo>[].obs;
  final Category category;
  CategoryModel({required this.category});
  get id => category.id;
  get description => category.description;

  bool get hasTodos => todos.isNotEmpty;
  List<Todo> get todosList => todos;

  fillTodos() async{
    todos.value = await DB.todosDao.getTodosByCategoryId(id);
  }
}
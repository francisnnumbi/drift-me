import 'dart:developer';

import 'package:drift_me/database/my_database.dart';
import 'package:drift_me/models/category_model.dart';
import 'package:drift_me/models/todo_model.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as d;

import '../main.dart';
import '../routes/routes.dart';

class DataServices extends GetxService {
  // ------- static methods ------- //
  static DataServices get to => Get.find();
  static Future<void> init() async {
    await Get.putAsync<DataServices>(() async => DataServices());
  }
// ------- ./static methods ------- //

  var idx = 0.obs;
  var category = Rxn<CategoryModel>();
  var categories = <CategoryModel>[].obs;
  var todo = Rxn<TodoModel>();
  var todos = <TodoModel>[].obs;

  // ------- Categories ------- //
  openCategory(CategoryModel category) {
    this.category.value = category;
    Get.toNamed(Routes.category);
    this.category.value!.fillTodos();
  }

  saveCategory(Map data) async {
    if (category.value == null) {
      CategoriesCompanion c = CategoriesCompanion(
        description: d.Value(data['description']),
      );
      await DB.categoriesDao.insertCategory(c);
      Get.snackbar('Category', 'Category added successfully');
    } else {
      CategoriesCompanion c = category.value!.category
          .copyWith(
            description: data['description'],
          )
          .toCompanion(true);

      await DB.categoriesDao.updateCategory(c);
      Get.snackbar('Category', 'Category updated successfully');
    }
    category.value = null;
    Get.toNamed(Routes.categories);
  }

  Future<void> getCategoryById(int id) async {
    category.value = CategoryModel(category: await DB.categoriesDao.getCategoryById(id));
  }

  Future<void> deleteCategoryById(int id) async {
    await DB.categoriesDao
        .deleteCategory(await DB.categoriesDao.getCategoryById(id));
    category.value = null;
    Get.snackbar('Category', 'Category deleted successfully');
  }

  Future<void> deleteCategory(Category category) async {
    List<Todo> f = await DB.todosDao.getTodosByCategoryId(category.id);
    if(f.isNotEmpty) {
      Get.snackbar('Category', 'Category has todos, delete them first');
      return;
    }
    Get.defaultDialog(
      title: 'Delete Category',
      middleText: 'Are you sure you want to delete: ${category.description}?',
      textConfirm: 'Yes',
      textCancel: 'No',
      onConfirm: () async {
        await DB.categoriesDao.deleteCategory(category);
        this.category.value = null;
        Get.back();
        Get.snackbar('Category', 'Category deleted successfully');
      },
      onCancel: () {
        //Get.back();
      },
    );
  }
  // ------- ./Categories ------- //

  // ------- Todos ------- //

  openTodoModel(TodoModel todo) {
    this.todo.value = todo;
    Get.toNamed(Routes.todo);
  }

  openTodo(Todo todo) async{
    this.todo.value = await DB.todosDao.getTodoModelById(todo.id);
    Get.toNamed(Routes.todo);
  }

  saveTodo(Map data) async {
    d.Value<int?> dd = const d.Value.absent();
    if(data['category'] != null) {
      int? s = int.tryParse(data['category'].toString());
      dd = s != null?d.Value(s):const d.Value.absent();
    }

    if (todo.value == null) {
      TodosCompanion t = TodosCompanion(
        title: d.Value(data['title']),
        content: d.Value(data['content']),
        category: dd,
      );
      await DB.todosDao.insertTodo(t);
      Get.snackbar('Todo', 'Todo added successfully');
    } else {
      TodosCompanion t = todo.value!.todo
          .copyWith(
            title: data['title'],
            content: data['content'],
            category: dd,
          ).toCompanion(true);

      await DB.todosDao.updateTodo(t);
      Get.snackbar('Todo', 'Todo updated successfully');
    }
    todo.value = null;
    Get.toNamed(Routes.home);
  }

  Future<void> deleteTodo(Todo todo) async {
    Get.defaultDialog(
      title: 'Delete Todo',
      middleText: 'Are you sure you want to delete: ${todo.title}?',
      textConfirm: 'Yes',
      textCancel: 'No',
      onConfirm: () async {
        await DB.todosDao.deleteTodo(todo);
        this.todo.value = null;
        Get.back();
        Get.snackbar('Todo', 'Todo deleted successfully');
        try {
          category.value!.fillTodos();
        } catch (e) {}
      },
      onCancel: () {
        //Get.back();
      },
    );
  }

  // ------- ./Todos ------- //

  @override
  onReady() async {
    DB.categoriesDao.watchAllCategories().listen((event) {
      categories.value = event;
      for (var element in categories) {
        element.fillTodos();
      }
    });
    DB.todosDao.watchAllTodos().listen((event) {
      todos.value = event;
    });
  }
}

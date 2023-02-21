import 'package:drift_me/database/my_database.dart';
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
  var category = Rxn<Category>();
  var categories = <Category>[].obs;
  var todo = Rxn<Todo>();
  var todos = <TodoModel>[].obs;

  // ------- Categories ------- //
  saveCategory(Map data) async {
    if (category.value == null) {
      CategoriesCompanion c = CategoriesCompanion(
        description: d.Value(data['description']),
      );
      await DB.categoriesDao.insertCategory(c);
      Get.snackbar('Category', 'Category added successfully');
    } else {
      CategoriesCompanion c = category.value!
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
    category.value = await DB.categoriesDao.getCategoryById(id);
  }

  Future<void> deleteCategoryById(int id) async {
    await DB.categoriesDao
        .deleteCategory(await DB.categoriesDao.getCategoryById(id));
    category.value = null;
    Get.snackbar('Category', 'Category deleted successfully');
  }

  Future<void> deleteCategory(Category category) async {
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

  saveTodo(Map data) async {
    d.Value<int?> dd = const d.Value.absent();
    if(data['category'] != null) {
      int? s = int.tryParse(data['category']);
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
      TodosCompanion t = todo.value!
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
    });
    DB.todosDao.watchAllTodos().listen((event) {
      todos.value = event;
    });
  }
}

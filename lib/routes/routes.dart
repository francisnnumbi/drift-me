import 'package:drift_me/screens/categories/categories_screen.dart';
import 'package:get/get.dart';

import '../screens/categories/category_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/todos/todo_screen.dart';

class Routes {
  static String home = '/';
  static String categories = '/categories';
  static String category = '/category';
  static String todo = '/todo';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: categories,
      page: () => const CategoriesScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: category,
      page: () =>  CategoryScreen(),
      transition: Transition.zoom,
    ),

    GetPage(
      name: todo,
      page: () =>  TodoScreen(),
      transition: Transition.zoom,
    ),
  ];
}
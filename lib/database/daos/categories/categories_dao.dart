import 'package:drift/drift.dart';
import 'package:drift_me/main.dart';
import 'package:drift_me/models/category_model.dart';

import '../../my_database.dart';
import '../../tables/categories.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<MyDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(MyDatabase db) : super(db);

  Future<List<Category>> getAllCategories() => select(categories).get();

  Stream<List<CategoryModel>> watchAllCategories() => select(categories).map((row) {
        return CategoryModel(category: row);
      }).watch();

  Future<Category> getCategoryById(int id) =>
      (select(categories)..where((t) => t.id.equals(id))).getSingle();
  Future<int> insertCategory(CategoriesCompanion category) =>
      into(categories).insert(category);
  Future<bool> updateCategory(CategoriesCompanion category) =>
      update(categories).replace(category);
  Future<int> deleteCategory(Category category) =>
      delete(categories).delete(category);
}

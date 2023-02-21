
import 'package:drift/drift.dart';

import '../../my_database.dart';
import '../../tables/categories.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<MyDatabase> with _$CategoriesDaoMixin {
  CategoriesDao(MyDatabase db) : super(db);

  Future<List<Category>> getAllCategories() => select(categories).get();
  Stream<List<Category>> watchAllCategories() => select(categories).watch();
  Future<Category> getCategoryById(int id) => (select(categories)..where((t) => t.id.equals(id))).getSingle();
  Future<int> insertCategory(CategoriesCompanion category) => into(categories).insert(category);
  Future<bool> updateCategory(CategoriesCompanion category) => update(categories).replace(category);
  Future<int> deleteCategory(Category category) => delete(categories).delete(category);
}

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift_me/database/tables/categories.dart';
import 'package:drift_me/database/tables/todos.dart';

import 'daos/categories/categories_dao.dart';
import 'daos/todos/todos_dao.dart';

part 'my_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
  tables: [Todos, Categories],
  daos: [TodosDao, CategoriesDao],
)
class MyDatabase extends _$MyDatabase {
MyDatabase() : super(_openConnection());

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

}
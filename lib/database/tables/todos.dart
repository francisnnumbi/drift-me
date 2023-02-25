import 'package:drift/drift.dart';
import 'package:drift_me/database/tables/categories.dart';


@DataClassName('Todo')
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().references(Categories, #id).nullable()();
}


import 'package:drift/drift.dart';
import 'package:drift_me/models/todo_model.dart';

import '../../my_database.dart';
import '../../tables/todos.dart';

part 'todos_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<MyDatabase> with _$TodosDaoMixin {
  TodosDao(MyDatabase db) : super(db);

  Future<List<Todo>> getAllTodos() => (select(todos)..orderBy([(t)=>OrderingTerm.desc(t.priority)])).get();

  Stream<List<TodoModel>> watchAllTodos() => (select(todos)
  .join([
    leftOuterJoin(db.categories, db.categories.id.equalsExp(todos.category)),
  ])..orderBy([OrderingTerm.desc(todos.priority)])).map((row) {
    return TodoModel(
      todo:row.readTable(todos),
     category: row.readTableOrNull(db.categories),
    );
  }).watch();


  Future<Todo> getTodoById(int id) => (select(todos)..where((t) => t.id.equals(id))).getSingle();

  Future<TodoModel> getTodoModelById(int id) => ((select(todos)
    ..where((t) => t.id.equals(id)))
      .join([
    leftOuterJoin(db.categories, db.categories.id.equalsExp(todos.category)),
  ])).map((row) {
    return TodoModel(
      todo:row.readTable(todos),
      category: row.readTableOrNull(db.categories),
    );
  }).getSingle();


  Future<List<Todo>> getTodosByCategoryId(int id) =>
      (select(todos)..where((t) => t.category.equals(id))).get();
  Future<int> insertTodo(TodosCompanion todo) => into(todos).insert(todo);
  Future<bool> updateTodo(TodosCompanion todo) => update(todos).replace(todo);
  Future<int> deleteTodo(Todo todo) => delete(todos).delete(todo);
}
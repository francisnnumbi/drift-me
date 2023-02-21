

import 'package:drift/drift.dart';

import '../../my_database.dart';
import '../../tables/todos.dart';

part 'todos_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<MyDatabase> with _$TodosDaoMixin {
  TodosDao(MyDatabase db) : super(db);

  Future<List<Todo>> getAllTodos() => select(todos).get();
  Stream<List<Todo>> watchAllTodos() => select(todos).watch();
  Future<Todo> getTodoById(int id) => (select(todos)..where((t) => t.id.equals(id))).getSingle();
  Future<int> insertTodo(Todo todo) => into(todos).insert(todo);
  Future<bool> updateTodo(Todo todo) => update(todos).replace(todo);
  Future<int> deleteTodo(Todo todo) => delete(todos).delete(todo);
}
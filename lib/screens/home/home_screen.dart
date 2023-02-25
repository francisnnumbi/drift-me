import 'package:drift_me/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/bottom_menu.dart';
import '../../routes/routes.dart';
import '../../services/data_services.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Home'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: DataServices.to.todos.length,
          itemBuilder: (context, index) {
            TodoModel todo = DataServices.to.todos[index];
            return ListTile(
              leading: CircleAvatar(child: Text((index+1).toString())),
              title: Text(todo.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.content),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5)
                  )
                    ,child: Text("${todo.description??'No category'}", style: const TextStyle(fontSize: 11),)
                  ),
                ],
              ),
              minLeadingWidth: 10,
              onTap: () {
                DataServices.to.todo.value = todo.todo;
                Get.toNamed(Routes.todo);
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  DataServices.to.deleteTodo(todo.todo);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.todo);
          },
          backgroundColor: Get.theme.primaryColor,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60.0)),
          ),
          child: const Icon(Icons.add)
      ),
      bottomNavigationBar:  const BottomMenu(),
    );
  }
}

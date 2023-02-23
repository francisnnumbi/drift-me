import 'dart:developer';

import 'package:drift_me/database/my_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/bottom_menu.dart';
import '../../services/data_services.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({
    Key? key,
  }) : super(key: key) {
    if (DataServices.to.category.value != null) {
      _category = DataServices.to.category.value!.category.toJson();
    }
  }

  final _formKey = GlobalKey<FormState>();
  Map _category = {
    'id': '',
    'description': '',
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DataServices.to.category.value = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(DataServices.to.category.value == null
              ? 'Create Category'
              : 'Update Category'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _category['description'],
                      decoration: const InputDecoration(
                        hintText: 'Enter a description',
                        labelText: 'Category Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (va) {
                        if (va!.isEmpty) {
                          return "La description doit avoir une valeur";
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        _category['description'] = value.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Text('Todos'),
            const Divider(),
            if (DataServices.to.category.value != null)
              Expanded(
                child: Obx(() {
                  return DataServices.to.category.value == null? const SizedBox(): ListView.builder(
                    itemCount: DataServices.to.category.value!.todos.length,
                    itemBuilder: (context, index) {
                      Todo todo = DataServices.to.category.value!.todos[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(todo.title[0].toUpperCase()),
                        ),
                        minLeadingWidth: 10,
                        title: Text(todo.title),
                        subtitle: Text(todo.content),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                          onPressed: () {
                            DataServices.to.deleteTodo(todo);
                          },
                        ),
                        onTap: () {
                          DataServices.to.openTodo(todo);
                        },
                      );
                    },
                  );
                }),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              DataServices.to.saveCategory(_category);
            },
            backgroundColor: Get.theme.primaryColor,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(60.0)),
            ),
            child: const Icon(Icons.save)),
      ),
    );
  }
}

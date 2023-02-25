import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/data_services.dart';


class TodoScreen extends StatelessWidget {
   TodoScreen({Key? key, }) : super(key: key){
     if(DataServices.to.todo.value != null) {
       _todo = DataServices.to.todo.value!.toJson();
       log(_todo.toString());
     }
   }

  final _formKey = GlobalKey<FormState>();
  Map _todo = {
    'id': '',
    'title': '',
    'content': '',
    'category': null,
  };
  @override
  Widget build(BuildContext context) {
    return   WillPopScope(
      onWillPop: () async {
        DataServices.to.todo.value = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Todo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _todo['title'],
                  decoration: const InputDecoration(
                    hintText: 'Enter a title',
                    labelText: 'Todo title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (va) {
                    if (va!.isEmpty) {
                      return "Le champs doit avoir une valeur";
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _todo['title'] = value.toString();
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  initialValue: _todo['content'],
                  decoration: const InputDecoration(
                    hintText: 'Enter content',
                    labelText: 'Todo content',
                    border: OutlineInputBorder(),
                  ),
                  validator: (va) {
                    if (va!.isEmpty) {
                      return "Le champs doit avoir une valeur";
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _todo['content'] = value.toString();
                  },
                ),
                const SizedBox(height: 10,),
                DropdownButtonFormField(
                  value: _todo['category'],
                  decoration: const InputDecoration(
                    hintText: 'Enter content',
                    labelText: 'Todo content',
                    border: OutlineInputBorder(),
                  ),
                  items:
                    DataServices.to.categories.map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.description),
                  )).toList()..insert(0, const DropdownMenuItem(
                      value: null,
                      child: Text('Select a category', style: TextStyle(color: Colors.grey)),
                    ))
                  ,
                  onChanged: (value) {
                    _todo['category'] = value.toString();
                  },
                ),
              ],
            ),),
        ),
        floatingActionButton:  FloatingActionButton(
          onPressed: (){
            if (!_formKey.currentState!.validate()) {
              return;
            }
            _formKey.currentState!.save();
            DataServices.to.saveTodo(_todo);

          },
          backgroundColor: Get.theme.primaryColor,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60.0)),
          ),
          child: const Icon(Icons.save)
        ),
      ),
    );
  }
}

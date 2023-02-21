import 'dart:developer';

import 'package:drift_me/database/my_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/bottom_menu.dart';
import '../../services/data_services.dart';


class CategoryScreen extends StatelessWidget {
   CategoryScreen({Key? key, }) : super(key: key){
     if(DataServices.to.category.value != null) {
       _category = DataServices.to.category.value!.toJson();
       log(_category.toString());
     }

   }
  final _formKey = GlobalKey<FormState>();
   Map _category = {
    'id': '',
    'description': '',
  };

  @override
  Widget build(BuildContext context) {
    return   WillPopScope(
      onWillPop: () async {
        DataServices.to.category.value = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(DataServices.to.category.value == null?'Create Category':'Update Category'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
            children: [
              TextFormField(
                initialValue: _category['description'],
                decoration: const InputDecoration(
                  hintText: 'Enter a name',
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
                validator: (va) {
                  if (va!.isEmpty) {
                    return "Le champs doit avoir une valeur";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _category['description'] = value.toString();
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
            DataServices.to.saveCategory(_category);

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

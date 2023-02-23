import 'package:drift_me/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/bottom_menu.dart';
import '../../routes/routes.dart';
import '../../services/data_services.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Categories'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: DataServices.to.categories.length,
          itemBuilder: (context, index) {
            CategoryModel category = DataServices.to.categories[index];
            return ListTile(
              leading: CircleAvatar(child: Text((index+1).toString())),
              title: Text(category.description),
              minLeadingWidth: 10,
              onTap: () {
                DataServices.to.openCategory(category);
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  DataServices.to.deleteCategory(category.category);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.category);
          },
          backgroundColor: Get.theme.primaryColor,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60.0)),
          ),
          child: const Icon(Icons.add)
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}

import 'package:drift_me/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: DataServices.to.idx.value,
      onTap: (idx) {
        DataServices.to.idx.value = idx;
        switch (idx) {
          case 0:
            Get.toNamed(Routes.home);
            break;
          case 1:
            Get.toNamed(Routes.categories);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categories',
        ),
      ],
    );
  }
}

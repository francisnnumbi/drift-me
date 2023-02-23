import 'package:drift_me/routes/routes.dart';
import 'package:drift_me/screens/home/home_screen.dart';
import 'package:drift_me/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'database/my_database.dart';

final DB = MyDatabase();
void main() async{
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async{
  await DataServices.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Drift Me',
      debugShowCheckedModeBanner: false,
      enableLog: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: Routes.home,
      getPages: Routes.routes,
    );
  }
}

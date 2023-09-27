import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imc_calculator/controller/home_controller.dart';
import 'package:imc_calculator/screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'model/input_form.dart';


Future main() async {

  await Hive.initFlutter();
  await Hive.openBox('user');
  runApp(
    ChangeNotifierProvider(
        create: (context) => HomeController(),
      child: const MyApp(),
    )
  );

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const splashScreen(),
    );
  }
}


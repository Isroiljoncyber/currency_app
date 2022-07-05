import 'package:currency_app/ui/currency_list_page.dart';
import 'package:currency_app/ui/currency_main_page.dart';
import 'package:currency_app/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CurrencyMainPage(),
      onGenerateRoute: (setting) => Routes.generateRoute(setting),
    );
  }
}

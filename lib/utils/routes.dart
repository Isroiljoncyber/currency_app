import 'package:currency_app/ui/currency_list_page.dart';
import 'package:currency_app/ui/currency_main_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const pageList = "/currencyListPage";

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case pageList:
          return MaterialPageRoute(
              builder: (context) => const CurrencyListPage());
          // args?['currencyList']
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}

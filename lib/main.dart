import 'package:currency_app/domain/provider/currency_provider.dart';
import 'package:currency_app/ui/currency_main_page.dart';
import 'package:currency_app/utils/constants.dart';
import 'package:currency_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrencyProvider>(
            create: (_) => CurrencyProvider())
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        home: const CurrencyMainPage(),
        onGenerateRoute: (setting) => Routes.generateRoute(setting),
      ),
    );
  }
}

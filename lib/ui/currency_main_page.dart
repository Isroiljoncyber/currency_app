import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:currency_app/domain/provider/currency_provider.dart';
import 'package:currency_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../components/comp_main_page.dart';
import '../domain/model/currency_model.dart';
import '../utils/routes.dart';

class CurrencyMainPage extends StatefulWidget {
  const CurrencyMainPage({Key? key}) : super(key: key);

  @override
  State<CurrencyMainPage> createState() => _CurrencyMainPageState();
}

class _CurrencyMainPageState extends State<CurrencyMainPage> {
  // final TextEditingController editingControllerTop = TextEditingController();
  // final TextEditingController editingControllerBottom =
  //     TextEditingController();
  // final FocusNode topFocus = FocusNode();
  // final FocusNode bottomFocus = FocusNode();
  //
  // List<CurrencyModel> listCurrency = [];
  // CurrencyModel? currencyModelTop;
  // CurrencyModel? currencyModelBottom;

  @override
  void initState() {
    super.initState();
    Provider.of<CurrencyProvider>(context, listen: false).addingListeners();
  }

  // Builder(builder: (BuildContext context) => context.read<CurrencyProvider>().bottomFocus= 0;);

  //
  // editingControllerTop.addListener(() {
  //   if (topFocus.hasFocus) {
  //     if (editingControllerTop.text.isNotEmpty) {
  //       double sum = double.parse(currencyModelTop?.rate ?? "0") /
  //           double.parse(currencyModelBottom?.rate ?? "0") *
  //           double.parse(editingControllerTop.text);
  //       editingControllerBottom.text = sum.toStringAsFixed(2);
  //     } else {
  //       editingControllerBottom.text = "";
  //     }
  //   }
  // });
  //
  // editingControllerBottom.addListener(() {
  //   if (bottomFocus.hasFocus) {
  //     if (editingControllerBottom.text.isNotEmpty) {
  //       double sum = double.parse(currencyModelBottom?.rate ?? "0") /
  //           double.parse(currencyModelTop?.rate ?? "0") *
  //           double.parse(editingControllerBottom.text);
  //       editingControllerTop.text = sum.toStringAsFixed(2);
  //     } else {
  //       editingControllerTop.text = "";
  //     }
  //   }
  // });
  // }

  @override
  void dispose() {
    Provider.of<CurrencyProvider>(context, listen: false).disposeListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: mainColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: "Hello Isroiljon\n",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "Welcome Back",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white12),
                          ),
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: provider.networkRepoImpl.listCurrency.isEmpty
                        ? provider.networkRepoImpl.loadCurrencyDatesFormWeb()
                        : null,
                    builder: ((context, snapShot) {
                      if (snapShot.hasData) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          margin: const EdgeInsets.symmetric(vertical: 25),
                          decoration: BoxDecoration(
                            color: mainColorContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Exchange",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.settings,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    children: [
                                      itemExchange(
                                        provider.editingControllerTop,
                                        provider
                                            .networkRepoImpl.currencyModelTop,
                                        provider.topFocus,
                                        (() {
                                          Navigator.pushNamed(
                                              context, Routes.pageList,
                                              arguments: {
                                                'currencyList': provider
                                                    .networkRepoImpl
                                                    .listCurrency
                                              }).then(
                                            (value) => {
                                              if (value is CurrencyModel)
                                                {
                                                  setState(
                                                    () {
                                                      provider.networkRepoImpl
                                                              .currencyModelTop =
                                                          value;
                                                    },
                                                  )
                                                }
                                            },
                                          );
                                        }),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      itemExchange(
                                        provider.editingControllerBottom,
                                        provider.networkRepoImpl
                                            .currencyModelBottom,
                                        provider.bottomFocus,
                                        (() {
                                          Navigator.pushNamed(
                                              context, Routes.pageList,
                                              arguments: {
                                                'currencyList': provider
                                                    .networkRepoImpl
                                                    .listCurrency
                                              }).then(
                                            (value) => {
                                              if (value is CurrencyModel)
                                                {
                                                  setState(
                                                    () {
                                                      provider.networkRepoImpl
                                                              .currencyModelBottom =
                                                          value;
                                                    },
                                                  )
                                                }
                                            },
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: mainColorContainer,
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.white12)),
                                    alignment: Alignment.center,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(17.5),
                                        onTap: () {
                                          setState(() {
                                            var model = provider.networkRepoImpl
                                                .currencyModelTop
                                                ?.copyWith();
                                            provider.networkRepoImpl
                                                    .currencyModelTop =
                                                provider.networkRepoImpl
                                                    .currencyModelBottom
                                                    ?.copyWith();
                                            provider.networkRepoImpl
                                                .currencyModelBottom = model;
                                            provider.editingControllerTop
                                                .clear();
                                            provider.editingControllerBottom
                                                .clear();
                                          });
                                        },
                                        child: const SizedBox(
                                          height: 35,
                                          width: 35,
                                          child: Icon(
                                            Icons.currency_exchange,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      } else if (snapShot.hasError) {
                        return const Expanded(
                          child: Center(
                            child: Text(
                              "ERROR",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

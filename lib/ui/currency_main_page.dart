import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:currency_app/domain/provider/currency_provider.dart';
import 'package:currency_app/domain/repos/network_repo_impl.dart';
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
  @override
  void initState() {
    super.initState();
    Provider.of<CurrencyProvider>(context, listen: false)
        .addingMainPageListeners();
  }

  @override
  void dispose() {
    Provider.of<CurrencyProvider>(context, listen: false)
        .disposeMainPageListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyProvider>(builder: (context, provider, child) {
      if (provider.listCurrency.isEmpty) {
        provider.initialLoading();
      }
      return Scaffold(
        backgroundColor: mainColor,
        body: provider.networkRepoImpl.state == ModelState.isSuccess
            ? SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      provider.currencyModelTop,
                                      provider.topFocus,
                                      (() {
                                        provider
                                            .navigateTopListPageToChangeModel(
                                                context, "top");
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    itemExchange(
                                      provider.editingControllerBottom,
                                      provider.currencyModelBottom,
                                      provider.bottomFocus,
                                      (() {
                                        provider
                                            .navigateTopListPageToChangeModel(
                                                context, "bottom");
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
                                      borderRadius: BorderRadius.circular(17.5),
                                      onTap: () {
                                        provider.changeCurrency();
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
                      ),
                    ],
                  ),
                ),
              )
            : SafeArea(
                child: Visibility(
                  visible:
                      provider.networkRepoImpl.state != ModelState.isSuccess,
                  child: const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }
}

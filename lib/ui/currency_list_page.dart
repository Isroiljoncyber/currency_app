import 'package:currency_app/domain/model/currency_model.dart';
import 'package:currency_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../components/comp_list_page.dart';
import '../domain/provider/currency_provider.dart';

class CurrencyListPage extends StatefulWidget {
  const CurrencyListPage({Key? key}) : super(key: key);

  @override
  State<CurrencyListPage> createState() => _CurrencyListPageState();
}

class _CurrencyListPageState extends State<CurrencyListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CurrencyProvider>(context, listen: false)
        .addingListPageListeners();
  }

  @override
  void dispose() {
    // Provider.of<CurrencyProvider>(context, listen: false)
    //     .disposeListPageListeners();
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: provider.searchEditingController,
                      enableSuggestions: false,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            provider.searchEditingController.text = "";
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        fillColor: mainColorContainer,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 20,
                        ),
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: provider.searchList.length,
                      itemBuilder: ((context, index) => itemCurrency(
                            provider.searchList[index],
                            () => {
                              Navigator.pop(context, provider.searchList[index])
                            },
                          )),
                    ),
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

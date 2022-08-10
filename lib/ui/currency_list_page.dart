import 'package:currency_app/domain/model/currency_model.dart';
import 'package:currency_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/comp_list_page.dart';

class CurrencyListPage extends StatefulWidget {
  final List<CurrencyModel> listCurrency;

  const CurrencyListPage(this.listCurrency, {Key? key}) : super(key: key);

  @override
  State<CurrencyListPage> createState() => _CurrencyListPageState();
}

class _CurrencyListPageState extends State<CurrencyListPage> {
  final TextEditingController _searchEditingController =
      TextEditingController();

  late List<CurrencyModel> searchList = [];

  @override
  void initState() {
    super.initState();
    searchList.addAll(widget.listCurrency);
    _searchEditingController.addListener(() {
      if (_searchEditingController.text.isNotEmpty) {
        searchList = [];
        for (var element in widget.listCurrency) {
          if (element.ccyNmEN.toString().toLowerCase().contains(
              _searchEditingController.text.toString().toLowerCase())) {
            searchList.add(element);
          }
        }
      } else {
        searchList = widget.listCurrency;
      }
      setState(() {
        searchList;
      });
    });
  }

  @override
  void dispose() {
    _searchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: _searchEditingController,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    fillColor: mainColorContainer,
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: searchList.length,
                  itemBuilder: ((context, index) => itemCurrency(
                        searchList[index],
                        () => {Navigator.pop(context, searchList[index])},
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

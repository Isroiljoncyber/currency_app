import 'package:currency_app/domain/repos/network_repo_impl.dart';
import 'package:flutter/material.dart';

import '../../utils/routes.dart';
import '../model/currency_model.dart';

class CurrencyProvider extends ChangeNotifier {
  final TextEditingController editingControllerTop = TextEditingController();
  final TextEditingController editingControllerBottom = TextEditingController();
  final TextEditingController searchEditingController = TextEditingController();

  late List<CurrencyModel> searchList = [];
  final FocusNode topFocus = FocusNode();
  final FocusNode bottomFocus = FocusNode();
  late NetworkRepoImpl networkRepoImpl = NetworkRepoImpl();
  late List<CurrencyModel> listCurrency = [];

  CurrencyModel? currencyModelTop;
  CurrencyModel? currencyModelBottom;

  bool isShowSnack = false;
  bool isError = false;
  String snackMessage = '';

  Future initialLoading() async {
    listCurrency.addAll(await networkRepoImpl.loadCurrencyDatesFormWeb());
    for (final item in listCurrency) {
      if (item.ccy == "USD") {
        currencyModelTop = item;
      } else if (item.ccy == "RUB") {
        currencyModelBottom = item;
      }
    }
    notifyListeners();
  }

  addingMainPageListeners() {
    editingControllerTop.addListener(() {
      if (topFocus.hasFocus) {
        if (editingControllerTop.text.isNotEmpty) {
          double sum = double.parse(currencyModelTop?.rate ?? "0") /
              double.parse(currencyModelBottom?.rate ?? "0") *
              double.parse(editingControllerTop.text);
          editingControllerBottom.text = sum.toStringAsFixed(2);
        } else {
          editingControllerBottom.text = "";
        }
      }
    });

    editingControllerBottom.addListener(() {
      if (bottomFocus.hasFocus) {
        if (editingControllerBottom.text.isNotEmpty) {
          double sum = double.parse(currencyModelBottom?.rate ?? "0") /
              double.parse(currencyModelTop?.rate ?? "0") *
              double.parse(editingControllerBottom.text);
          editingControllerTop.text = sum.toStringAsFixed(2);
        } else {
          editingControllerTop.text = "";
        }
      }
    });
  }

  disposeMainPageListeners() {
    editingControllerTop.removeListener(() {});
    editingControllerBottom.removeListener(() {});
    topFocus.dispose();
    bottomFocus.dispose();
  }

  addingListPageListeners() {
    searchList.addAll(listCurrency);
    searchEditingController.addListener(() {
      if (searchEditingController.text.isNotEmpty) {
        searchList = [];
        for (var element in listCurrency) {
          if (element.ccyNmEN.toString().toLowerCase().contains(
              searchEditingController.text.toString().toLowerCase())) {
            searchList.add(element);
          }
        }
      } else {
        searchList = listCurrency;
      }
      notifyListeners();
      // setState(() {
      //   searchList;
      // });
    });
  }

  disposeListPageListeners() {
    searchEditingController.dispose();
  }

  navigateTopListPageToChangeModel(
      BuildContext context, String whichModel) async {
    listCurrency = listCurrency;
    var model = await Navigator.pushNamed(context, Routes.pageList);

    if (model is CurrencyModel) {
      if (whichModel.startsWith("top")) {
        currencyModelTop = model;
      } else {
        currencyModelBottom = model;
      }
      notifyListeners();
    }
  }

  changeCurrency() {
    var model = currencyModelTop?.copyWith();
    currencyModelTop = currencyModelBottom?.copyWith();
    currencyModelBottom = model;
    editingControllerTop.clear();
    editingControllerBottom.clear();
    notifyListeners();
  }
}

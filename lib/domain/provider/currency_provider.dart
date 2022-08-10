import 'package:currency_app/domain/repos/network_repo_impl.dart';
import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier implements SnackInterface {
  final TextEditingController editingControllerTop = TextEditingController();
  final TextEditingController editingControllerBottom = TextEditingController();

  final FocusNode topFocus = FocusNode();
  final FocusNode bottomFocus = FocusNode();
  late NetworkRepoImpl networkRepoImpl;
  bool isShowSnack = false;
  String snackMessage = '';

  CurrencyProvider() {
    networkRepoImpl = NetworkRepoImpl(this);
  }

  @override
  changeSnackState({String message = ""}) {
    isShowSnack = !isShowSnack;
    if (isShowSnack) {
      snackMessage = message;
    }
    notifyListeners();
  }

  addingListeners() {
    editingControllerTop.addListener(() {
      if (topFocus.hasFocus) {
        if (editingControllerTop.text.isNotEmpty) {
          double sum = double.parse(
                  networkRepoImpl.currencyModelTop?.rate ?? "0") /
              double.parse(networkRepoImpl.currencyModelBottom?.rate ?? "0") *
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
          double sum =
              double.parse(networkRepoImpl.currencyModelBottom?.rate ?? "0") /
                  double.parse(networkRepoImpl.currencyModelTop?.rate ?? "0") *
                  double.parse(editingControllerBottom.text);
          editingControllerTop.text = sum.toStringAsFixed(2);
        } else {
          editingControllerTop.text = "";
        }
      }
    });
  }

  disposeListeners() {
    editingControllerTop.removeListener(() {});
    editingControllerBottom.removeListener(() {});
    topFocus.dispose();
    bottomFocus.dispose();
  }
}

class SnackInterface {
  changeSnackState({String message = ""}) {}
}

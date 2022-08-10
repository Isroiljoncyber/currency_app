import 'dart:convert';
import 'dart:io';

import 'package:currency_app/domain/provider/currency_provider.dart';
import 'package:currency_app/domain/repos/network_repository.dart';
import 'package:currency_app/utils/constants.dart';
import 'package:http/http.dart';

import '../model/currency_model.dart';

class NetworkRepoImpl implements NetworkRepository {
  NetworkRepoImpl(this.snackInterface);

  List<CurrencyModel> listCurrency = [];
  CurrencyModel? currencyModelTop;
  CurrencyModel? currencyModelBottom;
  SnackInterface snackInterface;

  @override
  Future<bool> loadCurrencyDatesFormWeb() async {
    try {
      var response = await get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        listCurrency = [];
        for (final item in jsonDecode(response.body)) {
          var model = CurrencyModel.fromJson(item);
          if (model.ccy == "USD") {
            currencyModelTop = model;
          } else if (model.ccy == "RUB") {
            currencyModelBottom = model;
          }
          listCurrency.add(model);
        }
        return true;
      } else {
        snackInterface.changeSnackState(message: "Unknown error");
      }
    } on SocketException {
      snackInterface.changeSnackState(message: "Connection error");
    } catch (e) {
      snackInterface.changeSnackState(message: e.toString());
    }
    return false;
  }
}

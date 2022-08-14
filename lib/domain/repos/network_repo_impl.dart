import 'dart:convert';
import 'dart:io';

import 'package:currency_app/domain/provider/currency_provider.dart';
import 'package:currency_app/domain/repos/network_repository.dart';
import 'package:currency_app/utils/constants.dart';
import 'package:http/http.dart';

import '../../components/comp_main_page.dart';
import '../model/currency_model.dart';

enum ModelState { isLoading, isBusy, isSuccess, isError }

class NetworkRepoImpl implements NetworkRepository {
  late ModelState state = ModelState.isLoading;
  int err = 0;

  @override
  Future<List<CurrencyModel>> loadCurrencyDatesFormWeb() async {
    try {
      List<CurrencyModel> listCurrency = [];
      state = ModelState.isLoading;
      var response = await get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        state = ModelState.isBusy;
        for (final item in jsonDecode(response.body)) {
          var model = CurrencyModel.fromJson(item);
          listCurrency.add(model);
        }
        state = ModelState.isSuccess;
        showMessage(snackMessage: "Successfully downloaded");
        return listCurrency;
      } else {
        state = ModelState.isError;
        showMessage(snackMessage: "Connection error");
        Future.delayed(
            const Duration(seconds: 1), () => loadCurrencyDatesFormWeb());
      }
    } on SocketException {
      state = ModelState.isError;
      checkInternetConnection();
    } catch (e) {
      state = ModelState.isError;
      showMessage(snackMessage: e.toString(), isError: true);
    }
    return [];
  }

  Future checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showMessage(snackMessage: "Internet connected");
        err = 0;
      }
    } on SocketException catch (_) {
      if (err < 3) {
        showMessage(snackMessage: "No internet connection", isError: true);
        err++;
      }
    }
  }
}

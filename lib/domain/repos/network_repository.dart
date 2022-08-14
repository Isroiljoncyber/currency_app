
import '../model/currency_model.dart';

abstract class NetworkRepository {

  Future<List<CurrencyModel>> loadCurrencyDatesFormWeb();

}
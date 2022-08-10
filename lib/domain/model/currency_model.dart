import 'dart:convert';

/// id : 69
/// Code : "840"
/// Ccy : "USD"
/// CcyNm_RU : "Доллар США"
/// CcyNm_UZ : "AQSH dollari"
/// CcyNm_UZC : "АҚШ доллари"
/// CcyNm_EN : "US Dollar"
/// Nominal : "1"
/// Rate : "10836.69"
/// Diff : "-13.41"
/// Date : "05.07.2022"

CurrencyModel currencyModelFromJson(String str) =>
    CurrencyModel.fromJson(json.decode(str));

String currencyModelToJson(CurrencyModel data) => json.encode(data.toJson());

class CurrencyModel {
  CurrencyModel({
    int? id,
    String? code,
    String? ccy,
    String? ccyNmRU,
    String? ccyNmUZ,
    String? ccyNmUZC,
    String? ccyNmEN,
    String? nominal,
    String? rate,
    String? diff,
    String? date,
  }) {
    _id = id;
    _code = code;
    _ccy = ccy;
    _ccyNmRU = ccyNmRU;
    _ccyNmUZ = ccyNmUZ;
    _ccyNmUZC = ccyNmUZC;
    _ccyNmEN = ccyNmEN;
    _nominal = nominal;
    _rate = rate;
    _diff = diff;
    _date = date;
  }

  CurrencyModel.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['Code'];
    _ccy = json['Ccy'];
    _ccyNmRU = json['CcyNm_RU'];
    _ccyNmUZ = json['CcyNm_UZ'];
    _ccyNmUZC = json['CcyNm_UZC'];
    _ccyNmEN = json['CcyNm_EN'];
    _nominal = json['Nominal'];
    _rate = json['Rate'];
    _diff = json['Diff'];
    _date = json['Date'];
  }

  int? _id;
  String? _code;
  String? _ccy;
  String? _ccyNmRU;
  String? _ccyNmUZ;
  String? _ccyNmUZC;
  String? _ccyNmEN;
  String? _nominal;
  String? _rate;
  String? _diff;
  String? _date;

  CurrencyModel copyWith({
    int? id,
    String? code,
    String? ccy,
    String? ccyNmRU,
    String? ccyNmUZ,
    String? ccyNmUZC,
    String? ccyNmEN,
    String? nominal,
    String? rate,
    String? diff,
    String? date,
  }) =>
      CurrencyModel(
        id: id ?? _id,
        code: code ?? _code,
        ccy: ccy ?? _ccy,
        ccyNmRU: ccyNmRU ?? _ccyNmRU,
        ccyNmUZ: ccyNmUZ ?? _ccyNmUZ,
        ccyNmUZC: ccyNmUZC ?? _ccyNmUZC,
        ccyNmEN: ccyNmEN ?? _ccyNmEN,
        nominal: nominal ?? _nominal,
        rate: rate ?? _rate,
        diff: diff ?? _diff,
        date: date ?? _date,
      );

  int? get id => _id;

  String? get code => _code;

  String? get ccy => _ccy;

  String? get ccyNmRU => _ccyNmRU;

  String? get ccyNmUZ => _ccyNmUZ;

  String? get ccyNmUZC => _ccyNmUZC;

  String? get ccyNmEN => _ccyNmEN;

  String? get nominal => _nominal;

  String? get rate => _rate;

  String? get diff => _diff;

  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['Code'] = _code;
    map['Ccy'] = _ccy;
    map['CcyNm_RU'] = _ccyNmRU;
    map['CcyNm_UZ'] = _ccyNmUZ;
    map['CcyNm_UZC'] = _ccyNmUZC;
    map['CcyNm_EN'] = _ccyNmEN;
    map['Nominal'] = _nominal;
    map['Rate'] = _rate;
    map['Diff'] = _diff;
    map['Date'] = _date;
    return map;
  }
}

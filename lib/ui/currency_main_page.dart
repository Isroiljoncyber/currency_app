import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:currency_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

import '../model/currencyModel.dart';
import '../utils/routes.dart';

class CurrencyMainPage extends StatefulWidget {
  const CurrencyMainPage({Key? key}) : super(key: key);

  @override
  State<CurrencyMainPage> createState() => _CurrencyMainPageState();
}

class _CurrencyMainPageState extends State<CurrencyMainPage> {
  final TextEditingController _editingControllerTop = TextEditingController();
  final TextEditingController _editingControllerBottom =
      TextEditingController();
  final FocusNode _topFocus = FocusNode();
  final FocusNode _bottomFocus = FocusNode();
  List<CurrencyModel> _listCurrency = [];
  CurrencyModel? _currencyModelTop;
  CurrencyModel? _currencyModelBottom;

  @override
  void initState() {
    super.initState();
    _editingControllerTop.addListener(() {
      if (_topFocus.hasFocus) {
        if (_editingControllerTop.text.isNotEmpty) {
          double sum = double.parse(_currencyModelTop?.rate ?? "0") /
              double.parse(_currencyModelBottom?.rate ?? "0") *
              double.parse(_editingControllerTop.text);
          _editingControllerBottom.text = sum.toStringAsFixed(2);
        } else {
          _editingControllerBottom.text = "";
        }
      }
    });
    _editingControllerBottom.addListener(() {
      if (_bottomFocus.hasFocus) {
        if (_editingControllerBottom.text.isNotEmpty) {
          double sum = double.parse(_currencyModelBottom?.rate ?? "0") /
              double.parse(_currencyModelTop?.rate ?? "0") *
              double.parse(_editingControllerBottom.text);
          _editingControllerTop.text = sum.toStringAsFixed(2);
        } else {
          _editingControllerTop.text = "";
        }
      }
    });
  }

  @override
  void dispose() {
    _editingControllerTop.removeListener(() {});
    _editingControllerBottom.removeListener(() {});
    _topFocus.dispose();
    _bottomFocus.dispose();
    super.dispose();
  }

  Future<bool> _loadData() async {
    try {
      var response =
          await get(Uri.parse("https://cbu.uz/oz/arkhiv-kursov-valyut/json/"));
      if (response.statusCode == 200) {
        for (final item in jsonDecode(response.body)) {
          var model = CurrencyModel.fromJson(item);
          if (model.ccy == "USD") {
            _currencyModelTop = model;
          } else if (model.ccy == "RUB") {
            _currencyModelBottom = model;
          }
          _listCurrency.add(model);
        }
        return true;
      } else {
        _showMessage("Unknown error");
      }
    } on SocketException catch (e) {
      _showMessage("Connection error");
    } catch (e) {
      _showMessage(e.toString());
    }
    return false;
  }

  _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
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
                future: _listCurrency.isEmpty ? _loadData() : null,
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
                                  _itemExchange(
                                    _editingControllerTop,
                                    _currencyModelTop,
                                    _topFocus,
                                    ((value) {
                                      if (value is CurrencyModel) {
                                        setState(
                                          () {
                                            _currencyModelTop = value;
                                          },
                                        );
                                      }
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  _itemExchange(
                                    _editingControllerBottom,
                                    _currencyModelBottom,
                                    _bottomFocus,
                                    ((value) {
                                      if (value is CurrencyModel) {
                                        setState(
                                          () {
                                            _currencyModelBottom = value;
                                          },
                                        );
                                      }
                                    }),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: mainColorContainer,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white12)),
                                alignment: Alignment.center,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(17.5),
                                    onTap: () {
                                      setState(() {
                                        var model =
                                            _currencyModelTop?.copyWith();
                                        _currencyModelTop =
                                            _currencyModelBottom?.copyWith();
                                        _currencyModelBottom = model;
                                        _editingControllerTop.clear();
                                        _editingControllerBottom.clear();
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      child: const Icon(
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
  }

  Widget _itemExchange(TextEditingController controller,
      CurrencyModel? currencyModel, FocusNode focusNode, Function callBack) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white12,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  focusNode: focusNode,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "0.00",
                    hintStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xff10a4d4),
                    borderRadius: BorderRadius.circular(15)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.pageList,
                              arguments: {'currencyList': _listCurrency})
                          .then((value) => callBack(value));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _picture(currencyModel!),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: Text(
                              currencyModel!.ccy ?? "UNK",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            currencyModel!.rate!,
            style: const TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Widget _picture(CurrencyModel currencyModel) {
    String imgPath =
        "assets/${currencyModel.ccy?.substring(0, 2).toLowerCase()}.svg";
    // if (file.existsSync()) {
    return SvgPicture.asset(
      imgPath,
      height: 20,
      width: 20,
    );
    // } else {
    //   return Container(
    //     height: 20,
    //     width: 20,
    //     decoration:
    //         const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
    //     child: Center(
    //       child: Text(
    //         "${currencyModel.ccy?.substring(0, 2)}",
    //         style: const TextStyle(
    //           fontSize: 10,
    //           color: Colors.black,
    //           fontWeight: FontWeight.w600,
    //         ),
    //       ),
    //     ),
    //   );
    // }
  }
}

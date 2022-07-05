import 'package:currency_app/model/currencyModel.dart';
import 'package:currency_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrencyListPage extends StatefulWidget {
  final List<CurrencyModel> listCurrency;

  const CurrencyListPage(this.listCurrency, {Key? key}) : super(key: key);

  @override
  State<CurrencyListPage> createState() => _CurrencyListPageState();
}

class _CurrencyListPageState extends State<CurrencyListPage> {
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
                      ), onPressed: () {  },
                    ),
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.listCurrency.length,
                  itemBuilder: ((context, index) =>
                      _itemCurrency(widget.listCurrency[index])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemCurrency(CurrencyModel currencyModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: mainColorContainer,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.pop(context, currencyModel);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SvgPicture.asset(
                          "assets/${currencyModel.ccy?.substring(0, 2).toLowerCase()}.svg",
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              currencyModel.ccyNmEN!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              currencyModel.rate!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _rateChange(currencyModel.diff!),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _rateChange(String changeRate) {
    String isPositive = "1";
    if (changeRate.contains("-")) isPositive = "2";
    if (changeRate == "0") isPositive = "0";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          changeRate,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: isPositive == "0"
                  ? Colors.grey
                  : isPositive == "1"
                      ? Colors.green
                      : Colors.red),
        ),
        isPositive == "0"
            ? const Icon(
                Icons.trending_flat,
                color: Colors.grey,
              )
            : isPositive == "1"
                ? const Icon(
                    Icons.trending_up,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.trending_down,
                    color: Colors.red,
                  ),
      ],
    );
  }
}

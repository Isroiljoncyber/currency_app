import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../domain/model/currency_model.dart';
import '../utils/constants.dart';

Widget itemCurrency(CurrencyModel currencyModel, Function callback) {
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
          onTap: () => callback(),
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
                  child: rateChange(currencyModel.diff!),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget rateChange(String changeRate) {
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
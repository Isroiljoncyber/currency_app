import 'package:currency_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../domain/model/currency_model.dart';
import '../domain/provider/currency_provider.dart';

Widget itemExchange(TextEditingController controller,
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
                  onTap: () => callBack(),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    height: 30,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: pictureAssets(currencyModel!),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: Text(
                            currencyModel.ccy ?? "UNK",
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
          currencyModel.rate!,
          style: const TextStyle(
            color: Colors.white54,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
  );
}

Widget pictureAssets(CurrencyModel currencyModel) {
  String imgPath =
      "assets/${currencyModel.ccy?.substring(0, 2).toLowerCase()}.svg";
  return SvgPicture.asset(
    imgPath,
    height: 20,
    width: 20,
  );
}

showMessage({required String snackMessage, bool isError = false}) {
  // if (provider.isShowSnack) {
  final ScaffoldMessengerState scaffoldMessengerState =
      scaffoldMessengerKey.currentState!;

  scaffoldMessengerState.showSnackBar(
    SnackBar(
      backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
      duration: Duration(seconds: isError ? 10:2),
      content: Text(
        snackMessage,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
  // provider.changeSnackState();
  // }
}

import 'package:FurEverHome/helpers/widgets_and_attributes.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Toast {
  static void normal(String msg, {Alignment align = const Alignment(0, 0.85)}) {
    _buildCustomToast(msg, const Color.fromARGB(255, 71, 211, 49),
        align: align, isSuccessType: true);
  }

  static void info(String msg, {Alignment align = const Alignment(0, 0.85)}) {
    _buildCustomToast(msg, Colors.yellow.shade600,
        align: align, isSuccessType: false);
  }

  static void error([String errorMsg = "Oops! Try Again."]) {
    _buildCustomToast(errorMsg, const Color(0xFFF33636), isErrorType: true);
  }

  static void _buildCustomToast(String msg, Color bgColor,
      {Alignment align = const Alignment(0, 0.85),
      bool isErrorType = false,
      bool isSuccessType = true}) {
    BotToast.showCustomText(
      onlyOne: true,
      duration: Duration(seconds: _getToastDuration(msg)),
      align: align,
      ignoreContentClick: true,
      toastBuilder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: bgColor,
              boxShadow: const [
                BoxShadow(
                    blurRadius: 10, spreadRadius: 4, color: Colors.black26)
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/error_icon.gif",
                  height: 40,
                  color: Colors.black,
                  // color: isErrorType
                  //     ? const Color(0xFFF33636)
                  //     : isSuccessType
                  //         ? const Color(0xFF8ADB7D)
                  //         : Colors.yellow.shade600,
                ),
                sizedBoxW10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   isErrorType ? 'Error' : 'Info',
                      //   style: TextStyle(
                      //       fontSize: 15,
                      //       color: isErrorType
                      //           ? const Color(0xFFF33636)
                      //           : isSuccessType
                      //               ? const Color(0xFF8ADB7D)
                      //               : Colors.yellow.shade600,
                      //       fontWeight: FontWeight.w700),
                      //   textAlign: TextAlign.center,
                      // ),
                      Text(
                        msg,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static int _getToastDuration(String msg) {
    int toastDuration = msg.length ~/ 20;

    if (toastDuration < 2) {
      toastDuration = 2;
    } else if (toastDuration > 8) {
      toastDuration = 8;
    }
    return toastDuration;
  }
}

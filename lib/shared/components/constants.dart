import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:products_app/shared/network/local/cache_helper.dart';
import 'package:products_app/shared/styles/colors.dart';

// enum
enum RecoredStatus { COMPLETE, REVIEW, ALL }

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = primaryColor;
      break;
    case ToastStates.ERROR:
      color = textErrorColor;
      break;
    case ToastStates.WARNING:
      color = warringColor;
      break;
  }

  return color;
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

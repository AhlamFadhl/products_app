import 'package:get/get.dart';

class Validation {
  static String? fieldValidate(val) {
    return val!.isEmpty ? 'This Field is required'.tr : null;
  }

  static String? noValdation(val) {
    return null;
  }
}

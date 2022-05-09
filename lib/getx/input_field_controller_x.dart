import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InputFieldControllerX extends GetxController{
  static InputFieldControllerX get i => Get.find();
  List<TextEditingController> controllers = [];
}
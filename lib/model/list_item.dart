import 'package:flutter/widgets.dart';
import 'package:rise_qr_code/getx/input_field_controller_x.dart';

class ListItem {
  final String barcode;
  final int id;
  final String name;
  final int stock;
  TextEditingController? textEditingController;

  ListItem({
    required this.textEditingController,
    required this.barcode,
    required this.id,
    required this.name,
    required this.stock,
  });
}

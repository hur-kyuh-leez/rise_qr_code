import 'package:rise_qr_code/model/list_item.dart';

class Cart {
  final barcodesList = [];
  final int index;

  final ListItem listItem;

  Cart(
    this.index, {
    required this.listItem,
  });
}

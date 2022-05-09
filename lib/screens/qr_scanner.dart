import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rise_qr_code/getx/input_field_controller_x.dart';
import 'package:rise_qr_code/widgets/barcode_scanner_controller.dart';
import 'package:rise_qr_code/widgets/list_item_widget.dart';

import '../api/api_fetch_product.dart';
import '../model/list_item.dart';

class QrScanner extends StatelessWidget {
  static final listKey = GlobalKey<AnimatedListState>();
  final int duration_milliseconds = 500;

  // static final List<ListItem> items = listItems.toList();

  // 여기서 initialize 할게 아니라 getXcontroller에서 해서 넣기
  static final List<ListItem> items = [];

  var controller = Get.put(ApiFetchProduct());
  var apiFetchProduct = ApiFetchProduct.instance;
  final inputFieldControllerX = Get.put(InputFieldControllerX());

  void insertItemHere(String? barcode) async {
    bool contain = false;

    if (await apiFetchProduct.fetchProduct(barcode.toString())) {
      // check if barcode is already in the list
      for (ListItem item in items) {
        if (item.barcode == barcode.toString()) {
          contain = true;
          item.textEditingController!.text =
              (int.parse(item.textEditingController!.text) + 1).toString();
        }
      }
      if (!contain) {
        int newIndex;
        inputFieldControllerX.controllers.length == 0
            ? newIndex = 0
            : newIndex = inputFieldControllerX.controllers.length;
        inputFieldControllerX.controllers.add(TextEditingController(text: '1'));
        var newItem = ListItem(
          textEditingController: inputFieldControllerX
              .controllers[inputFieldControllerX.controllers.length - 1],
          barcode: barcode.toString(),
          id: apiFetchProduct.product.id,
          name: apiFetchProduct.product.name,
          stock: apiFetchProduct.product.stock,
        );

        items.insert(newIndex, newItem);
        listKey.currentState!.insertItem(
          newIndex,
          duration: Duration(milliseconds: duration_milliseconds),
        );
      }
      Get.snackbar(
        "추가 완료",
        apiFetchProduct.product.name,
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: duration_milliseconds * 3),
      );
    } else {
      // SHOW SNACK BAR
      Get.snackbar(
        "상품 목록에 없음",
        "등록된 목록에 없습니다.\n상품이 등록되어 있는 지 다시 한 번 확인 해주세요.",
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: duration_milliseconds * 4),
      );
    }
  }

  void removeItemHere(index) {
    // remove item
    final removedItem = items[index];
    items.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => ListItemWidget(
        textEditingController: inputFieldControllerX.controllers[index],
        item: removedItem,
        animation: animation,
        onClicked: () {}, // 여기서는 아무런 액션 없어도 됨
      ),
      duration: Duration(milliseconds: duration_milliseconds),
    );
    Future.delayed(Duration(milliseconds: duration_milliseconds + 10), () {
      inputFieldControllerX.controllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     Text(apiFetchProduct.laravelApiModel != null
        //         ? apiFetchProduct.laravelApiModel!.name
        //         : '...'),
        //     // FutureBuilder<LaravelApiModel>(
        //     //   future: futureAlbum,
        //     //   builder: (context, snapshot) {
        //     //     if (snapshot.hasData) {
        //     //       return Text(snapshot.data!.name);
        //     //     } else if (snapshot.hasError) {
        //     //       return Text("${snapshot.error}");
        //     //     }
        //     //     return CircularProgressIndicator();
        //     //   },
        //     // ),
        //   ],
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: BarcodeScannerWithController(),
        ),
        Expanded(
          child: AnimatedList(
            key: listKey,
            initialItemCount: items.length,
            itemBuilder: (context, index, animation) => ListItemWidget(
              textEditingController: inputFieldControllerX.controllers[index],
              item: items[index],
              animation: animation,
              onClicked: () {
                removeItemHere(index);
              },
            ),
          ),
        ),
      ],
    );
  }
}

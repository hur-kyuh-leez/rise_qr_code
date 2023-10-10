import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../getx/input_field_controller_x.dart';
import '../model/list_item.dart';

class ListItemWidget extends StatefulWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;
  final TextEditingController textEditingController;

  ListItemWidget(
      {Key? key,
      required this.item,
      required this.animation,
      required this.onClicked,
      required this.textEditingController})
      : super(key: key);

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  // final TextEditingController quantityTextFieldController = TextEditingController();
  // final controller = Get.put(InputFieldControllerX());


  // 여기가 핵심! 일반 ListTile과 다른 곳은 여기!
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizeTransition(
          // key 있어야지 transition 때 url.image가 smooth하게 바뀐다.
          key: ValueKey(widget.item.name),
          sizeFactor: widget.animation,
          child: buildItem(),
        ),
      );

  Widget buildItem() {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child:
          // 여기 trailing에 여러 icon 넣을 때 어떻게 해야 할 지 고민해야 한다.
          ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          // getting only korean name of the product
          widget.item.name.split('(')[1].replaceAll(')', ''),
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        subtitle: Text(widget.item.name.split('(')[0]),
        trailing: Wrap(
          children: [
            Container(
              width: 40,
              child: TextField(
                controller: widget.textEditingController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  labelText: '수량',
                ),
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            IconButton(
                icon: Icon(Icons.delete, color: Colors.red, size: 32),
                onPressed: widget.onClicked),
          ],
        ),
      ),
    );
  }
}

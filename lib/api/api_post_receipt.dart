import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';
import 'package:rise_qr_code/model/list_item.dart';

class ApiPostReceipt{
  void postReceipt(List<ListItem> items) async {
    // API POST여기다 추가 // 잘된다...!
    final response = await http.post(
      // Uri.parse('http://146.56.37.118/api/receipt'),
      Uri.parse('http://192.168.68.113:8000/api/receipt'),
    headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "title": "핸드폰에서 함",
        "received_date": formatDate(
            DateTime.now(), [yyyy, '-', mm, '-', dd]),
        "user_id": "1",
        "provider_id": "1"
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      int current_receipt_id = jsonDecode(
          response.body.replaceAll(r'[]', r''))['id'];
      print(
          jsonDecode(response.body.replaceAll(r'[]', r''))[
          'id']); // 임시 방편으로

      // product 다 add 하기
      for(var item in items){
        final response2 = await http.post(
          // Uri.parse('http://146.56.37.118/api/received_product'),
          Uri.parse('http://192.168.68.113:8000/api/received_product'),

          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "receipt_id": current_receipt_id.toString(),
            "product_id": item.id.toString(),
            "stock": item.textEditingController!.text,
            "stock_defective": "0"
          }),
        );
        if (response2.statusCode == 201) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.

          print(jsonDecode(response2.body
              .replaceAll(r'[]', r''))); // 임시 방편으로
        }
      }

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      // throw Exception('Failed to post.');
      print('failed');
    }
  }
}

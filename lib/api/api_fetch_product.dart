import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/product.dart';

///
/// backend api gives only one column data by pluck().
/// below code take cares of data(string) and display it
///

class ApiFetchProduct extends GetxController {

  // using GetX to manage LaravelApiModel State
  static ApiFetchProduct instance = Get.find();
  late Rx<Product?> _product = Rxn<Product>();
  Product get product =>  _product.value!;

  // @override
  // void onInit() {
  //   super.onInit();
  //   Rx<LaravelApiModel?> _laravelApiModel = Rx<LaravelApiModel>();
  // }


  // if there is barcode match, it returns true
  Future<bool> fetchProduct(String barcode) async {

    final response =
        // await http.get(Uri.parse('http://146.56.37.118/api/product/$barcode'));
        await http.get(Uri.parse('http://192.168.68.113:8000/api/product/$barcode'));

    if (response.statusCode == 200  && response.body.length > 2) {
      // If the server did return a 200 OK response and response body is not '[]' (empty)
      // then parse the JSON.
      var json = await jsonDecode(response.body)[0];
      Product returnthis = Product.fromJson(json);
      _product.value = returnthis;
      update();
      return true;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // throw Exception('Failed to load');
      return false;
    }
  }
}

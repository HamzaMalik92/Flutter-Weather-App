import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http; // alias
import 'dart:convert';


class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response responseKey = await http.get(url);
    if (responseKey.statusCode == 200) {
          String locationData = responseKey.body;
      var decodedData = jsonDecode(locationData);
      return decodedData;
    } else {
      print('responseKey.statusCode : ${responseKey.statusCode}');
    }
    return;
  }
}

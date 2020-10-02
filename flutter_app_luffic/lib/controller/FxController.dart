
import 'dart:convert';

import 'package:flutter_app_luffic/model/FxRates.dart';
import 'package:http/http.dart' as http;

class FxController
{
  static Future fetchAlbum() async {

    final response = await http.get("https://api.exchangeratesapi.io/latest");
    print(response);
    return response;
  }
}

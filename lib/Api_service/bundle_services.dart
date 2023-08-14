import 'dart:convert';

import 'package:http/http.dart';

import '../DTO/bundle.dart';

class BundleServices {
  static Future<List<Bundle>> getAllBundle() async {
    List<Bundle> listBundle = [];

    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbBundles"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        listBundle.add(Bundle.fromJson(data[i]));
      }
    }
    return listBundle;
  }
}

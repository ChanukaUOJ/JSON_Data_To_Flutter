import 'dart:convert';

import 'package:http/http.dart' as http;

import 'User.dart';

class RestApiService {
  String apiUrl = "https://mocki.io/v1/c5828bc2-afcc-4a57-9f69-befc129d1569";

  Future getUser() async {
    final response = await http.get(Uri.parse(apiUrl));

    //print(response.body);

    if (response.statusCode == 200) {
      return getResponseList(response.body);
    } else {
      throw Exception("Unable to fetch data!");
    }
  }

  List<User> getResponseList(String responseBody) {
    final parseBody = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parseBody.map<User>((json) => User.fromJson(json)).toList();
  }
}

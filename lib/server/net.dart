import 'dart:convert';

import 'package:http/http.dart';

Future login(String email, String password) async {
  try {
    Response response = await post(
      Uri.parse('https://bank-367a2-default-rtdb.firebaseio.com/email.json'),
      body: jsonEncode({"email": email, "password": password}),


    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data["jwt"];
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return "sjsj";
    }
  } catch (e) {
    print(e.toString());
  }
}

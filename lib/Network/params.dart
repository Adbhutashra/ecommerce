import 'dart:convert';

dynamic loginWithEmailBody(String email, String password) {
  var json = jsonEncode(<String, dynamic>{
    "email": email.toLowerCase(),
    "password": password,
  });
  print("login params =" + json.toString());
  return json;
}
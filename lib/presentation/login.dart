import 'dart:convert';

import 'package:ecommerceapp/Network/apiHelper.dart';
import 'package:ecommerceapp/Network/params.dart';
import 'package:ecommerceapp/Network/urls.dart';
import 'package:ecommerceapp/presentation/dashboard.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHidden = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  String? email, password;
  String message = '';

  void loginWithEmailAPI() async {
    email = emailController.text;
    password = passwordController.text;
    if (_formKey.currentState!.validate()) {
      try {
        var responseJson = await ApiHelper().postApi(
            context,
            BASE_URL_END_POINT + LOGIN,
            await loginWithEmailBody(email!, password!));
        if (responseJson.body != null) {
          if (responseJson.statusCode == 200) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
            // showToastMessage(model.message);
          } else if (responseJson.statusCode == 401) {
            var msg = json.decode(responseJson.body.toString())["error"];

            // showToastMessage(msg);
          }
        }
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'email'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: (){
                  loginWithEmailAPI();
                },
                child: Text('Login'),
              ),
              SizedBox(height: 16),
              Text(message, style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}

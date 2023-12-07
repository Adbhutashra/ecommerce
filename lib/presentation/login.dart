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
           
          } 
        }
      } catch (e) {}
    }
  }

    String? validateEmail(String value) {
    
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
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
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => validateEmail(value!),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) => validatePassword(value!),
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

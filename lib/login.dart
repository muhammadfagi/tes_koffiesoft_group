import 'package:flutter/material.dart';
import 'package:tes_koffiesoft_group/dashboard.dart';
import 'package:tes_koffiesoft_group/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  late String? email;
  late String? password;

  Future _login() async {
    final response = await http.post(
        Uri.parse('https://grinder.koffiesoft.com/login'),
        body: {
          'username': email,
          'password': password,
        });
    print(response.body);
    if (response.statusCode == 200) {
      final snackBar = SnackBar(
          content: const Text("Login Success"),
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(context, MaterialPageRoute(builder: (_) => const Dashboard()));
      return response.body;
    } else {
      print("error status " + response.statusCode.toString());
      final snackBar = SnackBar(
          content: const Text("Login Failed"),
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: Text("Login",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto-Regular")),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    validator: (String? emailValue) {
                      if (emailValue!.isEmpty) {
                        return "enter email text";
                      }
                      email = emailValue;
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Masukkan Email Anda",
                      helperStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    validator: (String? passwordValue) {
                      if (passwordValue!.isEmpty) {
                        return "enter password text";
                      }
                      password = passwordValue;
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Masukkan Password anda",
                      // labelText: "Password",
                      helperStyle: TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _passwordVisible = !_passwordVisible;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("Belum Punya Akun?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text("Daftar"),
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Text(
                        "Masuk",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

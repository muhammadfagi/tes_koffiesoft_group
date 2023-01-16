import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:tes_koffiesoft_group/login.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController tanggal = TextEditingController();
  String? selected;
  List<String> kelamin = ["Laki-laki", "Perempuan"];
  String grup = "member";
  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  late String? email;
  late String? password;
  late String? hp;
  late String? firstname;
  late String? lastname;
  late String? tgl_lahir;
  late String? jenis_kelamin;

  Future _register() async {
    var kelamin;
    if (selected == "Laki-laki") {
      kelamin = 1;
    } else {
      kelamin = 2;
    }
    print(selected);
    print(kelamin);
    final response = await http.post(
        Uri.parse('https://grinder.koffiesoft.com/users'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: convert.jsonEncode({
          'email': email,
          'hp': hp,
          'firstname': firstname,
          'lastname': lastname,
          'grup': grup,
          'tgl_lahir': tanggal.text,
          'jenis_kelamin': kelamin,
          'password': password,
        }));
    var status = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      final snackBar = SnackBar(
        content: const Text("Register Success"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return response.body;
    } else if (response.statusCode == 404) {
      if (status['status']['keterangan'] == "No. HP sudah terdaftar") {
        final snackBar = SnackBar(
          content: const Text("No.Hp Sudah Terdaftar"),
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (status['status']['keterangan'] == "Email sudah terdaftar") {
        final snackBar = SnackBar(
          content: const Text("Email Sudah Terdaftar"),
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: const Text("Register Failed"),
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      }
    } else {
      print("error status " + response.statusCode.toString());
      final snackBar = SnackBar(
        content: const Text("Register Failed"),
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
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 30),
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
                      child: Text("Register",
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
                        validator: (String? hpValue) {
                          if (hpValue!.isEmpty) {
                            return "enter no.hp text";
                          }
                          hp = hpValue;
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Masukkan No.Hp",
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
                        validator: (String? firstnameValue) {
                          if (firstnameValue!.isEmpty) {
                            return "enter firstname text";
                          }
                          firstname = firstnameValue;
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Masukkan Firstname",
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
                        validator: (String? lastNameValue) {
                          if (lastNameValue!.isEmpty) {
                            return "enter lastname text";
                          }
                          lastname = lastNameValue;
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Masukkan Lastname",
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
                        readOnly: true,
                        controller: tanggal,
                        validator: (String? tglValue) {
                          if (tglValue!.isEmpty) {
                            return "enter tanggal lahir";
                          }
                          tgl_lahir = tglValue;
                          return null;
                        },
                        decoration: const InputDecoration(
                          // icon: Icon(Icons.calendar_today_rounded),
                          labelText: "Masukkan Tanggal Lahir",
                          helperStyle: TextStyle(color: Colors.black),
                        ),
                        onTap: () async {
                          DateTime? pickTgl = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));

                          if (pickTgl != null) {
                            setState(() {
                              tanggal.text =
                                  DateFormat('yyyy-MM-dd').format(pickTgl);
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10),
                      child: DropdownButtonFormField(
                        validator: (value) =>
                            value == null ? 'pilih jenis kelamin' : null,
                        value: selected,
                        hint: Text("Pilih Jenis Kelamin"),
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            selected = value as String?;
                          });
                        },
                        items: kelamin
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
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
                        Text("Sudah Punya Akun?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text("Login"),
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
                            "Daftar",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _register();
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

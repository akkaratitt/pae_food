import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String nameString, emailString, passwordString;
  final formKey = GlobalKey<FormState>();

  Widget showTitle = Text('Please Register');

  Widget nameTextFiled() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name :', hintText: 'Name User'),
      validator: (String valueName) {
        if (valueName.length == 0) {
          return 'Please fill Name not Blank';
        }
      },
      onSaved: (String value) {
        nameString = value;
      },
    );
  }

  Widget emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email Address :', hintText: 'Emain Address'),
      validator: (String value) {
        if (!value.contains('@')) {
          return 'Please Type Email Format you@gmail.com';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordTextFiled() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Password', hintText: 'more 6 Charator'),
      validator: (String value) {
        if (value.length <= 5) {
          return 'Please Type Password mor 6 Charator';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  void checkValueBeforeUpload(BuildContext context) {
    print('You click upload');
    print(formKey.currentState.validate());
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(
          'name = $nameString, email = $emailString, password = $passwordString');
      uploadValueToServer(context, nameString, emailString, passwordString);
    }
  }

  void uploadValueToServer(
      BuildContext context, String name, String email, String password) async {
    String urlString =
       'https://www.androidthai.in.th/chit/addDataPae.php?isAdd=true&Name=$name&Email=$email&Password=$password';
    // String urlString = 'http://192.168.1.16:8080/UngPHP2/addDataPae.php?isAdd=true&Name=$name&Email=$email&Password=$password';
    print('url = $urlString');

    var response =
        await get(urlString); // send data to API and wait before response
    var result = json.decode(response.body);
    print('result=$result');

    if(result.toString() == 'true'){
      Navigator.pop(context);
    }else{
      print('Can\'t Upload');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Upload to Server',
            icon: Icon(Icons.cloud_upload),
            onPressed: () {
              checkValueBeforeUpload(context);
            },
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(top: 60.0),
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            child: Column(
              children: <Widget>[
                nameTextFiled(),
                emailTextField(),
                passwordTextFiled()
              ],
            ),
          ),
        ),
      ),
    );
  } // Build Method
} // _Register State Class

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Widget showTitle = Text('Please Register');

  Widget nameTextFiled() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name :', hintText: 'Name User'),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email Address :', hintText: 'Emain Address'),
    );
  }

  Widget passwordTextFiled() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Password', hintText: 'more 6 Charator'),
    );
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
              print('You click upload');
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            children: <Widget>[nameTextFiled(), emailTextField(), passwordTextFiled()],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyService extends StatefulWidget {

  final String nameLoginString; 

  MyService({Key key , this.nameLoginString}) :super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {

  Widget showNameLogin(){
    return Text('${widget.nameLoginString}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showNameLogin(),
      ),
      body: Container(alignment: Alignment.center,
        child: Text('body'),
      ),
    );
  }
}

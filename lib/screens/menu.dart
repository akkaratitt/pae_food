import 'package:flutter/material.dart';
import 'my_service.dart';
import 'my_service2.dart';
import 'my_service_gridview.dart';

class Menu extends StatefulWidget {
  final String nameLoginString;
  Menu({Key key, this.nameLoginString}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Widget showNameLogin() {
    return Text('${widget.nameLoginString}');
  }

  Widget menuButton1(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      child: Text(
        'Menu',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        var newPage1 = new MaterialPageRoute(
          builder: (BuildContext context) =>
              MyService(nameLoginString: widget.nameLoginString),
        );
        Navigator.of(context).push(newPage1);
      },
    );
  }

  Widget menuButton2(BuildContext context) {
    return FlatButton(
      color: Colors.green,
      child: Text(
        'Menu 2',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: (){
        var namePage = new MaterialPageRoute(builder: (BuildContext context)=>MyService2(nameLoginString: widget.nameLoginString,));
        Navigator.of(context).push(namePage);
      },
    );
  }

  Widget menuButton3(BuildContext context) {
    return FlatButton(
      color: Colors.green,
      child: Text(
        'Menu 3',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: (){
        var namePage = new MaterialPageRoute(builder: (BuildContext context)=>MyServiceGridview(nameLoginString: widget.nameLoginString,));
        Navigator.of(context).push(namePage);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showNameLogin(),
      ),
      body: Container(
        color: Colors.yellow,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          children: <Widget>[menuButton1(context), menuButton2(context), menuButton3(context)],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import 'package:flutter/foundation.dart';
import '../models/photo_food_model.dart';

class MyService extends StatefulWidget {
  final String nameLoginString;

  MyService({Key key, this.nameLoginString}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  List list = List();
  var isData = false;

  Widget showNameLogin() {
    return Text('${widget.nameLoginString}');
  }

  void getDataFood() async {
    // setState(() {
    //   isData = true;
    // });

    String urlString = "https://www.androidthai.in.th/chit/getFoodTableAllData.php";
    // String urlString = "http://192.168.1.16:8080/UngPHP2/getFoodTableAllData.php";
    final response = await get(urlString);

      //print('result=${response.body}');

    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new PhotoFoodModel.fromJson(data))
          .toList();
      // setState(() {
      //   isData = false;
        
      // });
      isData = true;
      setState(() {
        print('result=${list.length}');
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    getDataFood();
  }

  Widget _buildPhoto(BuildContext context) {
    return !isData
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(20.0),
                title: new Text(list[index].nameFood),
                trailing: new Image.network(
                  list[index].imagePath,
                  fit: BoxFit.cover,
                  height: 80.0,
                  width: 80.0,
                ),
              );
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
        padding: EdgeInsets.only(top: 10.0),
        alignment: Alignment.center,
        child: _buildPhoto(context),
      ),
    );
  }
}

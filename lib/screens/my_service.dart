import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import 'package:flutter/foundation.dart';
import 'package:flutter/src/painting/image_provider.dart';
import '../models/photo_food_model.dart';

class MyService extends StatefulWidget {
  final String nameLoginString;

  MyService({Key key, this.nameLoginString}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  List list = List();
  var isLoading = false;

  Widget showNameLogin() {
    return Text('${widget.nameLoginString}');
  }

  void getDataFood(BuildContext context) async {
    // setState(() {
    //   isLoading = true;
    // });

    String urlString =
        "https://www.androidthai.in.th/chit/getFoodTableAllData.php";
    final response = await get(urlString);

    //print('result=$response');
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new PhotoFoodModel.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Widget _buildPhoto(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : new Scrollbar(
            child: new ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(10.0),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    
                    title: new Text(list[index].nameFood),
                    trailing: new Image.network(
                      list[index].imagePath,
                      fit: BoxFit.cover,
                      height: 80.0,
                      width: 80.0,
                    ),
                  );
                }),
          );
  }

  @override
  Widget build(BuildContext context) {
    getDataFood(context);

    return Scaffold(
      appBar: AppBar(
        title: showNameLogin(),
      ),
      body: new SingleChildScrollView(
        // for not show Overflow Bottom
        child: Container(
          padding: EdgeInsets.only(top: 60.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[_buildPhoto(context)],
          ),
        ),
      ),
    );
  }
}

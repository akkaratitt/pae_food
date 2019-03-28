import 'package:flutter/material.dart';
import 'screens/register.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'models/user_model.dart';
//import 'screens/my_service2.dart';
import 'screens/menu.dart';

// void main() {
//   runApp(App());
// }

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pae Food',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// Explicit
  final formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  String emailString, passwordString;

  void showSnackBar(String message) {
    final snackBar = new SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 20.0),
      ),
      backgroundColor: Colors.red,
      duration: new Duration(seconds: 8),
      action: new SnackBarAction(
        label: 'Hint',
        onPressed: () {},
      ),
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  Widget nameApp = Text(
    'Pae Food',
    style: TextStyle(
        fontFamily: 'Pacifico',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.blue[700]),
  );

  Widget logo = Image.asset('images/car2.png');

  Widget emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email Address', hintText: 'you@email.com'),
      validator: (String value) {
        if (!value.contains('@')) {
          return 'Please Fill Email Format';
        }
      },
      initialValue: 'pae@gmail.com',
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Password', hintText: 'more 6 Charator'),
      validator: (String value) {
        if (value.length <= 5) {
          return 'Please Type Password More 6 Charetor';
        }
      },
      initialValue: '123456',
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  void checkUserAndPass(
      BuildContext context, String email, String password) async {
    print('email = $email , password = $password');
     String urlString =
         'https://www.androidthai.in.th/chit/getUserWhereUserPae.php?isAdd=true&Email=$email';
    // String urlString =
    //     'http://192.168.1.16:8080/UngPHP2/getUserWhereUserPae.php?isAdd=true&Email=$email';   
    var response = await get(urlString);
    var result = json.decode(response.body);
    print('result = $result');
    if (result.toString() == 'null') {
      //showAlertDialog(context); // Show Dialop
      showSnackBar('User False');
    } else {
      for (var data in result) {
        print('data = $data');
        var userModel = UserModel.fromJson(data);
        int id = userModel.id;
        String name = userModel.name;
        String turePassword = userModel.password;

        print('name = $name , turePassword = $turePassword');
        if (password == turePassword) {
          showSnackBar('Welcome $name');
          var myServiceRoute = new MaterialPageRoute(
              //builder: (BuildContext context) => MyService2(nameLoginString: name,));
              builder: (BuildContext context) => Menu(
                    nameLoginString: name,
                  ));
          Navigator.of(context).push(myServiceRoute);
        } else {
          showSnackBar('Please Try Again Password False');
        }
      }
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    AlertDialog alertDialop = AlertDialog(
      title: Text('Have Problem'),
      content: Text('User False'),
      actions: <Widget>[okButton],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialop;
      },
    );
  }

  Widget signInButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue[600],
      child: Text(
        'Sing In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('You Click SingIn');
        print(formKey.currentState.validate());
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          checkUserAndPass(context, emailString, passwordString);
        }
      },
    );
  }

  Widget signUpButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue[300],
      child: Text(
        'Sing Up',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('You Click SingUp');
        var registerRoute = new MaterialPageRoute(
            builder: (BuildContext context) => Register());
        Navigator.of(context).push(registerRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomPadding: true,
      body: Form(
        key: formKey,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.green[400]],
                  begin: Alignment.topCenter)),
          child: new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            child: Container(
              margin: EdgeInsets.only(top: 80.0, bottom: 80.0),
              constraints: new BoxConstraints(maxWidth: 200.0),
              child: Column(
                children: <Widget>[
                  logo,
                  nameApp,
                  emailTextField(),
                  passwordTextField(),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        signInButton(context),
                        signUpButton(context)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

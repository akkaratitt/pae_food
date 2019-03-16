import 'package:flutter/material.dart';
import 'screens/register.dart';

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
  String emailString, passwordString;

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
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  void checkUserAndPass(BuildContext context, String email, String password) {
    print('email = $email , password = $password');
    
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
          checkUserAndPass(context ,emailString ,passwordString);
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
      body: Form(
        key: formKey,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.green[400]],
                  begin: Alignment.topCenter)),
          child: Container(
            margin: EdgeInsets.only(top: 80.0, bottom: 80.0),
            constraints: BoxConstraints.expand(width: 200.0),
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
                    children: <Widget>[signInButton(context), signUpButton(context)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

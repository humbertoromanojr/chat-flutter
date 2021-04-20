import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'model/user.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //controllers
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  String _messageError = "";

  _validateFields(){
    // retrieves data from fields
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    if(email.isNotEmpty && email.contains("@")){
      if(password.isNotEmpty){
        setState(() {
          _messageError = "";
        });

        User user = User();
        user.email = email;
        user.password = password;

        _loggedUser( user );

      } else {
        setState(() {
          _messageError = "Fill in the PASSWORD";
        });
      }
    } else {
      setState(() {
        _messageError = "Fill in the EMAIL field and must be valid";
      });
    }
  }

  _loggedUser( User user ) {

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password
    ).then((firebaseUser){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home()
          )
      );
    }).catchError((error){
      print("Error: " + error.toString());
      _messageError = "Error in authenticate, verify email and password, try again please!";
    });

  }

  Future _verifyUserLogged() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser userLogged = await auth.currentUser();
    if( userLogged != null ){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home()
          )
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _verifyUserLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff0026ca)),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // force large button login
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 22),
                  child: Image.asset(
                    "images/logo.png",
                    width: 250,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextField(
                    autofocus: true,
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextField(
                    controller: _controllerPassword,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0, bottom: 50.0),
                  child: RaisedButton(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    color: Colors.blueAccent,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)
                    ),
                    onPressed: () {
                      _validateFields();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Center(
                    child: Text(
                      _messageError,
                      style: TextStyle(
                          color: Colors.red, fontSize: 20.0
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Not has count? Register now!",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Register()
                        )
                      );
                    },
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

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:susell/colors/colors.dart';
import 'package:susell/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:susell/firebase/db.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _message = '';
  int attemptCount = 0;
  String mail = '';
  String pass = '';
  final _formKey = GlobalKey<FormState>();

  AuthService auth = AuthService();

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = TextButton(
      child: Text("Ok"),
      onPressed:  () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("You are not signed up! Please go to the Sign-up Page"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void setmessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    print('Build called');
    return Scaffold(
      appBar: AppBar(
        title: Text('SUsell'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.fill, AppColors.fill],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
          ),
        ),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40,),
                Row(
                  children: const <Widget>[
                    SizedBox(
                      width: 150,
                    ),

                    Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 28,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,),
                    ),

                  ],
                ),
                SizedBox(height: 170,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(9.0,2.0,9.0,0.0),
                        child: TextFormField(
                          decoration: InputDecoration(

                              disabledBorder: OutlineInputBorder(

                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(20), //unnötiger rand
                              ),
                              hintText: 'E-mail',
                              contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              hintStyle: const TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1.5,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500),
                              filled: true,
                              hoverColor: AppColors.border,
                              focusColor: AppColors.border,
                              fillColor: AppColors.appBarTitleC.withOpacity(.2),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.border),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.border),
                                borderRadius: BorderRadius.circular(25),
                              )
                          ),
                          keyboardType: TextInputType.emailAddress,

                          validator: (value) {
                            if(value != null) {
                              if(value.isEmpty) {
                                return 'Please enter your e-mail';
                              }
                              if(!EmailValidator.validate(value)) {
                                return 'The e-mail address is not valid';
                              }
                            }
                            else {
                              return 'Please enter your e-mail';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            if(value != null) {
                              mail = value;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16,),


                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(9.0, 0.0, 9.0,2.0),
                        child: TextFormField(
                          decoration: InputDecoration(

                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              hintText: 'Password',
                              contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              hintStyle: const TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1.5,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500),
                              filled: true,
                              hoverColor: AppColors.border,
                              focusColor: AppColors.border,
                              fillColor: AppColors.appBarTitleC.withOpacity(.2),                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.border),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.border),
                                borderRadius: BorderRadius.circular(25),
                              )
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value) {
                            if(value != null) {
                              if(value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if(value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                            }
                            else {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            pass = value ?? '';
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40,),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {

                          if(_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Logging in')));
                          }

                        },

                        child: Padding(

                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: ButtonTheme(
                              buttonColor: Colors.pink,
                              //minWidth: MediaQuery.of(context).size.width,
                              height: 50,
                              minWidth: 160,
                              child: RaisedButton(
                                onPressed: () {
                                  print('a');
                                  if(_formKey.currentState!.validate()){
                                    _formKey.currentState!.save();

                                    print('b');
                                    auth.loginWithMailAndPass(mail, pass);
                                    print('c');
                                    //if(alrt == 'user-not-found'){
                                      //showAlertDialog(context);
                                    //}
                                   // print("alrt: $alrt");

                                  }
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: AppColors.fill,
                                      fontSize: 18,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w500,),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              )),
                        ),

                      ),
                    ),
                  ],
                ),

                Text(
                  _message,
                  style: TextStyle(
                    color: Colors.red,
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


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:susell/colors/colors.dart';
import 'package:susell/firebase/auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  String _message = "";
  String mail = '';
  String pass = '';
  String phone = '';

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AuthService auth = AuthService();

  void setmessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SUsell'),
        backgroundColor: Colors.black,

      ),
      resizeToAvoidBottomInset: false,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40,),
                Row(
                  children: const <Widget>[
                    SizedBox(
                      width: 40,
                    ),

                    Center(
                      child: Text(
                        "SIGN UP", textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 28,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,),
                      ),
                    ),

                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(9.0, 0.0, 9.9,2.0),
                        child: TextFormField(
                          decoration: InputDecoration(

                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              hintText: 'Name Surname',
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
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(9.0, 0.0, 9.9,2.0),
                        child: TextFormField(
                          decoration: InputDecoration(

                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(25),
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

                          },
                          onSaved: (String? value) {
                            if(value != null) {
                              mail = value;
                              print("$mail");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(9.0, 0.0, 9.9,2.0),
                        child: TextFormField(
                          decoration: InputDecoration(

                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

                              hintText: 'Username',
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
                          validator: (value) {
                            if(value != null) {
                              if(value.isEmpty) {
                                return 'Please enter your password';
                              }
                            }
                            else {
                              return 'Please enter your e-mail';
                            }

                          },
                          onSaved: (String? value) {
                            if(value != null) {
                              pass = value;
                              print("$pass");
                            }
                          },

                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(9.0, 0.0, 9.9,2.0),
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
                          obscureText: true,
                          validator: (value) {
                            if(value != null) {
                              if(value.isEmpty) {
                                return 'Please enter your phone';
                              }
                            }
                            else {
                              return 'Please enter your phone';
                            }

                          },
                          onSaved: (String? value) {
                            if(value != null) {
                              phone = value;
                              print("$phone");
                            }
                          },

                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(

                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: ButtonTheme(
                      buttonColor: Colors.green,
                      //minWidth: MediaQuery.of(context).size.width,
                      height: 50,
                      minWidth: 160,
                      child: RaisedButton(
                        onPressed: () {
                          mail = emailController.text.trim();
                          pass = passwordController.text.trim();
                          if(_formKey.currentState!.validate()){

                            _formKey.currentState!.save();

                            context.read<AuthService>().signupWithMailAndPass(mail, pass).then((value) async{
                              User? user = FirebaseAuth.instance.currentUser;
                              await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({

                                'uid': user!.uid,
                                'email': mail,
                                'password': pass,
                                'phone' : phone,
                              });
                            });
                            Navigator.pushNamed(context, '/feed');
                          }
                        },
                        child: const Text(
                          'CREATE',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
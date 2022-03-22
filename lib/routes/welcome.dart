import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_installations/firebase_installations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:susell/colors/colors.dart';
import 'package:susell/firebase/auth.dart';
import 'package:susell/signMethods/googleSign.dart';
import 'package:susell/routes/feedView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  String _installationId = 'Unknown';

  Future<void> getInstallationId() async {
    String id;

    try {
      id =
          await FirebaseInstallations.id ?? 'Unknown installation id';
    } on PlatformException {
      id = 'Failed to get installation id.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _installationId = id;
    });
  }

  Future<void> deleteInstallationId() async {
    String id;

    try {
      await FirebaseInstallations.deleteInstallationId();
      id = "Unknown";
    } on PlatformException {
      id = 'Failed to get installation id.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _installationId = id;
    });
  }

  String _message = "";
  AuthService auth = AuthService();

  void setMessage(String msg){
    setState(() {
      _message = msg;
    });
  }

  Future<void> _setCurrentScreen() async {
    widget.analytics.setCurrentScreen(screenName: 'Signup Page');
    setMessage('setCurrentScreen succeeded');
    print(_message);
    Navigator.pushNamed(context, '/signup');
  }

  Future<void> _setCurrentScreen1() async {
    widget.analytics.setCurrentScreen(screenName: 'Login Page');
    setMessage('setCurrentScreen succeeded');
    print(_message);
    Navigator.pushNamed(context, '/login');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return Scaffold(
        backgroundColor: AppColors.welcomeBody,
        body:
        SafeArea(

          maintainBottomViewPadding: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: RichText(
                    text: const TextSpan(
                      text: "Welcome to \n     SUsell ",
                      style: TextStyle(
                        fontSize: 60,
                        color: AppColors.headingColor,
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset('lib/images/su_logo2.png', width: 250, height: 250),
              ),
              SizedBox(height: 2,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          children: <TextSpan>[
                            TextSpan(
                              text: " Log in",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                getInstallationId;
                                print(_installationId);
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                            ),
                          ],
                        ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: (){
                        auth.signInAnon();
                        getInstallationId;
                        print(_installationId);
                        Navigator.pushReplacementNamed(context, '/feed');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: Size(double.infinity, 50),

                      ),

                      child: Text('Continue without sign up/ log in'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: (){
                        getInstallationId;
                        print(_installationId);
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white30,
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity, 50),

                      ),
                      icon: Icon(Icons.mail, color: Colors.white,),
                      label: Text('Sign up with email'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: (){
                        getInstallationId;
                        print(_installationId);
                        final provider = Provider.of<GoogleSign>(context, listen:false);
                        provider.googleLogin();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity, 50),

                      ),
                      icon: FaIcon(FontAwesomeIcons.google, color: Colors.white,),
                      label: Text('Sign up with Google'),
                    ),
                    SizedBox(height: 8,),
                    ElevatedButton.icon(
                      onPressed: (){
                        getInstallationId;
                        print(_installationId);

                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        onPrimary: Colors.black,
                        minimumSize: Size(double.infinity, 50),

                      ),
                      icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white,),
                      label: Text('Sign up with Facebook'),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),

      );

    }
    else {

      return FeedView();
    }

  }
}
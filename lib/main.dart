import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:susell/colors/colors.dart';
import 'package:susell/feedPages/Category.dart';
import 'package:susell/feedPages/payment.dart';
import 'package:susell/product/addProduct2.dart';
import 'package:susell/routes/login.dart';
import 'package:susell/routes/signup.dart';
import 'package:susell/settings/shoppingBasket.dart';
import 'package:susell/signMethods/googleSign.dart';
import 'package:susell/feedPages/mapView.dart';
import 'package:susell/profile/profileView.dart';
import 'package:susell/profile/editProfile.dart';
import 'package:susell/routes/feedView.dart';
import 'package:susell/routes/walkthrough.dart';
import 'package:susell/routes/welcome.dart';
import 'package:susell/settings/bookmark.dart';
import 'feedPages/notificationView.dart';
import 'firebase/auth.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(myFirebaseApp(),);
}
class myFirebaseApp extends StatefulWidget {
  const myFirebaseApp({Key? key}) : super(key: key);


  @override
  _myFirebaseAppState createState() => _myFirebaseAppState();
}

class _myFirebaseAppState extends State<myFirebaseApp> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return MaterialApp(
            home: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                  ),
                ),
                child: Center(
                  child: Text(
                    'ERROR',
                  ),
                ),
              ),

            ),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return AppBase();
        }
        return MaterialApp(
          home: Scaffold(

            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                ),
              ),

              child: Center(
                child: Text(
                  'Connecting...',
                ),
              ),
            ),

          ),
        );

      },
    );
  }
}

class AppBase extends StatefulWidget{

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);


  @override
  State<AppBase> createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> {


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(),
          ),
          StreamProvider(create: (context) => context.read<AuthService>().authStateChanges, initialData: null,
          ),
        ],
        child: ChangeNotifierProvider(
          create: (context) => GoogleSign(),
          child: MaterialApp(
              navigatorObservers: <NavigatorObserver>[AppBase.observer],

              //home: (WalkThrough(analytics: analytics, observer: observer).isSeen()) ? Welcome(analytics: analytics, observer: observer) : WalkThrough(analytics: analytics, observer: observer),
              //initialRoute: WalkThrough(analytics: analytics, observer: observer),
              //home: default_page,
              routes:{
                '/' : (context) => WalkThrough(analytics: AppBase.analytics, observer: AppBase.observer),
                '/welcome': (context) => Welcome(analytics: AppBase.analytics, observer: AppBase.observer),
                '/login': (context) => Login(analytics: AppBase.analytics, observer: AppBase.observer),
                '/signup': (context) => SignUpScreen(analytics: AppBase.analytics, observer: AppBase.observer),
                '/feed': (context) => FeedView(),
                '/editProfile': (context) => editProfile(analytics: AppBase.analytics, observer: AppBase.observer),
                '/map' : (context) => mapPage(),
                '/profileView': (context) => profileView(),
                '/notification': (context) => NotificationView(),
                //'/bookmark': (context) => bookmark(),
                '/favorite': (context) => favorite(),
                '/order': (context) => order(),
                '/addProduct' : (context) => addPro(),
                '/card' : (context) => card(),
                '/pay' : (context) => Pay(),


              }

          ),
        ),
    );
  }
}

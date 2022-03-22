import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:susell/colors/colors.dart';
import 'package:susell/main.dart';
import 'package:susell/routes/welcome.dart';
import 'package:susell/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class WalkThrough extends StatefulWidget {

  const WalkThrough({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  _WalkThroughState createState() => _WalkThroughState();

}

class _WalkThroughState extends State {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  List<String> appBarTitles = ["WELCOME", "SIGN-UP", "USE", "BUY"];
  List<String> pageTitles = ["Welcome to SUsell App", "How to Signup?", "Easy to Use", "Easy to Buy"];
  List<String> imageUrls = ["https://www.birbir.net.tr/img/hizmetler/eticaret.png", "https://foryougrouptr.com/wp-content/uploads/2021/05/sabanci-university.png", "https://cdn-icons-png.flaticon.com/512/3858/3858639.png", "https://31ie0amlw353ita8n1t3t6v1-wpengine.netdna-ssl.com/wp-content/uploads/2021/02/EASY-TO-BUY-LOGO-1-04-1-1.png"];
  List<String> imageCaptions = ["Shopping in Sabancı University ", "Just use your SU-Net account", "Sell your stuffs that you don't need anymore.", "You can easily find items that you need via specific categories. "];

  int _count = 0;
  Future<void> readyData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    _count = sharedPreferences.getInt("count") ?? 0;
    print("in init state: $_count");
    if( _count > 0){
      Navigator.popAndPushNamed(context, '/welcome');
    }


  }
  Future<void> saveData() async{
    var sharedPreferences = await SharedPreferences.getInstance();
    _count += 1;
    sharedPreferences.setInt("count", _count);
    setState(() {
    });
    print("upgrade count to $_count");
  }



  int page = 1;
  int total_page = 4;

  @override
  void initState() {
    readyData();
    super.initState();
  }



  void nextPage() {
    setState(() {
      page = page +1;
    });

  }

  void prevPage() {
    setState(() {
      page = page-1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.welcomeBody,
      body:
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height:100),

            Text(
              pageTitles[page-1],
              style: appBarTitleStyle,

            ),
            SizedBox(height: 20),
            Image.network(imageUrls[page-1],
              fit: BoxFit.fill, width: 300, height: 300,
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                imageCaptions[page-1],
                style: imageCaptionStyle,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if(page == 1)
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/welcome');
                      print("in walkthrouh botton: $_count");
                      setState(() {
                        saveData();
                      });
                    },
                    child: Text(
                      'Close',
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.buttonBack,
                    ),

                  ),
                if(page != 1)
                  OutlinedButton(
                    onPressed: (){
                      prevPage();
                    },
                    child: Text(
                      'Prev',
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.buttonBack,
                    ),

                  ),
                if(page != 4)
                  OutlinedButton(
                    onPressed: () {
                      nextPage();
                    },

                    child: Text(
                      'Skip',
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.buttonBack,
                    ),
                  ),

                if(page == 4)
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/welcome');
                      print("in walkthrouh botton: $_count");
                      setState((){
                        saveData();
                      });


                    },

                    child: Text(

                      'Finish',
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.buttonBack,
                    ),
                  ),
              ],

            ),
            Text(
              '$page/$total_page',
              style: pageStyle,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}



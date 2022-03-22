import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:susell/firebase/auth.dart';
import 'package:susell/styles/styles.dart';

class Settings1 extends StatefulWidget {
  const Settings1({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  _Settings1State createState() => _Settings1State();
}

class _Settings1State extends State<Settings1> {

  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10),
      child: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: [
              SettingsTile(
                title: Text('Language'),

                leading: Icon(Icons.language),

                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          SettingsSection(
            title: Text('Account'),
            tiles: [
              SettingsTile(
                title: Text('Phone number'),
                leading: Icon(Icons.phone),

                onPressed: (BuildContext context) {
                  //TODO
                },
              ),
              SettingsTile(
                title: Text('Email'),
                leading: Icon(Icons.email),

                onPressed: (BuildContext context) {
                  // TODO
                },
              ),
              SettingsTile(
                title: Text('Sign Out'),
                leading: Icon(Icons.logout),

                onPressed: (BuildContext context) {
                  auth.signOut();
                },
              ),
              SettingsTile(
                title: Text('Deactivate your account'),
                leading: Icon(Icons.close),
                onPressed: (BuildContext context) {
                  auth.signOut();
                  Navigator.pushReplacementNamed(context, '/welcome');
                },
              ),
              SettingsTile(
                title: Text('Delete your account'),
                leading: Icon(Icons.delete),
                onPressed: (BuildContext context){
                  setState(() async{
                    User? user = await FirebaseAuth.instance.currentUser;
                    if(user != null){user.delete();}
                  });

                  auth.signOut();
                  Navigator.pushReplacementNamed(context, '/welcome');
                },
              ),



            ],
          ),
          SettingsSection(
            title: Text('Security'),
            tiles: [
              SettingsTile(
                title: Text('Change Password'),
                leading: Icon(Icons.lock),

                onPressed: (BuildContext context) {
                  // TODO
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Misc'),
            tiles: [
              SettingsTile(
                title: Text('Terms of Service'),
                leading: Icon(Icons.article_outlined),

                onPressed: (BuildContext context) {
                  //TODO
                },
              ),
              SettingsTile(
                title: Text('Open source licenses'),
                leading: Icon(Icons.article),
                onPressed: (BuildContext context) {
                  // TODO
                },
              ),



            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:susell/dimensions/dimensions.dart';
import 'package:susell/notification/notification_badge.dart';
import 'package:susell/notification/pushnotification_model.dart';
import 'package:susell/styles/styles.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:susell/colors/colors.dart';

class NotificationView extends StatelessWidget{
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: MaterialApp(
          title: 'Notification panel',
          home: const NotifView(),
        ),
    );
  }
}

class NotifView extends StatefulWidget {
  const NotifView({Key? key}) : super(key: key);

  @override
  _NotifViewState createState() => _NotifViewState();

}


class _NotifViewState extends State<NotifView> {


  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;
  PushNotification? _notificationInfo;

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;


    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission granted');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data['title'] ,
          dataBody: message.data['body']  ,
      );

      setState(() {

        _totalNotificationCounter ++;
        _notificationInfo = notification;

      });


      if (notification != null) {
        showSimpleNotification(Text(_notificationInfo!.title!),
            leading: NotificationBadge(totalNotification: _totalNotificationCounter),
            subtitle: Text(_notificationInfo!.body!),
            background: AppColors.buttomNavigator,
            duration: Duration(seconds: 2));
      }

    });

    }
  }



  @override
  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'] ,
        dataBody: message.data['body']  ,
      );

      setState(() {

        _totalNotificationCounter ++;
        _notificationInfo = notification;

      });

    });


    registerNotification();
    _totalNotificationCounter = 0;
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Panel')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Notifications',
              textAlign: TextAlign.center,
              style : pageTitleStyle,

            ),

            NotificationBadge(totalNotification: _totalNotificationCounter),

            _notificationInfo != null
              ?Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}',
                  style: imageCaptionStyle),
              SizedBox(height: Dimension.regularMargin),
                Text(
                    'Body: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}',
                    style: imageCaptionStyle),
              ])
        :Container()

          ],
        )
      ),
    );
  }
}


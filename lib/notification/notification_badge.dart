import 'package:flutter/material.dart';
import 'package:susell/colors/colors.dart';
import 'package:susell/dimensions/dimensions.dart';
import 'package:susell/styles/styles.dart';

class NotificationBadge extends StatelessWidget {
  final int totalNotification;
  NotificationBadge({Key? key, required this.totalNotification}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.headingColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(Dimension.regularMargin),
          child: Text('$totalNotification', style: imageCaptionStyle ),
        )
      )
    );
  }
}








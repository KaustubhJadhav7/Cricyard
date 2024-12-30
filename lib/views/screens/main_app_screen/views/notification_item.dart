import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';

class NotificationItem extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    final notificationText = notification['notification'] as String;
    final time = notification['time'] as String;
    final timeDifference = calculateTimeDifference(time);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text(
            //   notificationText,
            //   overflow: TextOverflow.ellipsis,
            //   textAlign: TextAlign.left,
            //   style: AppStyle.txtGilroySemiBold16,
            // ),
            Padding(
              padding: getPadding(
                top: 10,
              ),
              child: Text(
                notificationText,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtGilroyRegular14,
              ),
            ),
          ],
        ),
        Padding(
          padding: getPadding(
            top: 11,
            bottom: 13,
          ),
          child: Text(
            timeDifference,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtGilroySemiBold18,
          ),
        ),
      ],
    );



      ListTile(
      title: Text(notificationText),
      subtitle: Text(timeDifference),
    );
  }

  String calculateTimeDifference(String time) {
    final currentTime = DateTime.now();
    final notificationTime = DateTime.parse(time);

    final difference = currentTime.difference(notificationTime);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '${years} ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '${months} ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else {
      return 'Just now';
    }
  }
}

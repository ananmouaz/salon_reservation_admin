import 'package:flutter/foundation.dart';
import 'package:flutter_fcm/flutter_fcm.dart';

import '../constants/app_keys.dart';
import '../utils/di.dart';
import '../utils/shared_perefrences/shared_perefrences_helper.dart';
import 'data/fcm_notification_model.dart';
import 'domain/cubit/notification_cubit.dart';
import 'domain/notification_middleware.dart';


class Messaging {
  static final AppPreferences _appPreferences = instance<AppPreferences>();

  static String? token;

  static deleteToken() {
    Messaging.token = null;
    FCM.deleteRefreshToken();
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationReceived(RemoteMessage message) async {
    await Firebase.initializeApp();
    var notification = FCMNotificationModel.fromJson(message.data);
    NotificationMiddleware.onReceived(notification);
  }

  @pragma('vm:entry-point')
  static initFCM() async {
    try {
      await FCM.initializeFCM(
        withLocalNotification: true,
        navigatorKey: AppKeys.navigatorKey,
        onNotificationReceived: onNotificationReceived,
        onNotificationPressed: (Map<String, dynamic> data) {
          var notification = FCMNotificationModel.fromJson(data);
          NotificationMiddleware.forward(notification);
        },
        onTokenChanged: (String? token) {
          if (token != null && Messaging.token != null) {
            Messaging.token = token;
            if (_appPreferences.hasAccessToken()) {
              NotificationCubit.updateFCMToken(Messaging.token);
              if (kDebugMode) {
                print('FCM Token  $token');
              }
            }
          }
        },
        icon: 'ic_launcher',
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

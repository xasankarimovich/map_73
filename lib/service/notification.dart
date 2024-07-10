import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code/main.dart';

import '../screens/splash/splash.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelKey: 'channelKey',
            channelName: 'channelName',
            channelDescription: 'channelDescription',
            importance: NotificationImportance.Max,
            playSound: true,
            enableVibration: true,
            enableLights: true,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: "channelGroupKey", channelGroupName: 'Group 1'),
        ],
        debug: true);
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod);
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final Map<String, String?> payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      MyApp.navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (context) => const SplashScreen()));
    }
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecond,
        channelKey: "channelKey",
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true)
          : null,
    );
  }
}

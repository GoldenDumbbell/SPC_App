// Store notification on shared preferences

import 'package:shared_preferences/shared_preferences.dart';

class LocalNotificationService {
  static Future<void> saveNotification(String notification) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    notifications.add(notification);
    await prefs.setStringList('notifications', notifications);
  }

  static Future<List<String>> getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('notifications') ?? [];
  }

  static Future<void> clearNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notifications', []);
  }
}

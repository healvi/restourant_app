import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/common/navigation.dart';
import 'package:restourant_app/common/style.dart';
import 'package:restourant_app/data/api/api_service.dart';
import 'package:restourant_app/data/db/database_helper.dart';
import 'package:restourant_app/data/db/database_provider.dart';
import 'package:restourant_app/data/preferences/preferences_helper.dart';
import 'package:restourant_app/provider/preferences_provider.dart';
import 'package:restourant_app/provider/restaourant_provider.dart';
import 'package:restourant_app/provider/restourent_provider_search.dart';
import 'package:restourant_app/ui/details_restaurant.dart';
import 'package:restourant_app/ui/restaourant_list.dart';
import 'package:restourant_app/utils/background_service.dart';
import 'package:restourant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaourantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(apiService: ApiService(), query: ""),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
            title: 'Restourant',
            navigatorKey: navigatorKey,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: typographiRes,
                appBarTheme: AppBarTheme(
                    backgroundColor: Colors.blue,
                    textTheme: typographiRes.apply(bodyColor: Colors.black),
                    titleTextStyle: typographiRes.headline6,
                    elevation: 0)),
            home: MyHomePage());
      }),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RestourantListPage();
  }
}

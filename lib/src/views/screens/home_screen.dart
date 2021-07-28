import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:framer/src/views/screens/choose_screen.dart';
import 'package:framer/src/views/widgets/custom_button.dart';
import 'package:framer/src/views/widgets/logo_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterLocalNotificationsPlugin? fltrNotification;

  @override
  void initState() {
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('app_icon');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification!.initialize(initializationSettings);
    _showNotification();
  }

// Future<dynamic> notificationSelected (){}

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      'Framer',
      'Hello',
      'Welcome to the App',
      importance: Importance.high,
    );

    var iOSDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await fltrNotification!
        .show(0, 'Hello', 'Welcome to the framer!', generalNotificationDetails);

    var scheduledTime1 = DateTime.now().add(Duration(seconds: 60));
    // var scheduledTime2 = DateTime.now().add(Duration(seconds: 12));

    fltrNotification!.schedule(1, "Framer!", "Start framing now",
        scheduledTime1, generalNotificationDetails);
    // fltrNotification!.schedule(1, "Framer!", "Start framing now",
    //     scheduledTime2, generalNotificationDetails);
    // fltrNotification!.schedule(1, "Framer!", "Start framing now",
    //     scheduledTime.add(Duration(seconds: 180)), generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppLogo(),
          Text(
            'Add Frames to your Images',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Image.asset(
            'assets/home_edit.png',
            height: _size.height * 0.5,
            width: _size.width,
          ),
          CustomButton('Go Framer!', () {
            // _showNotification();
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ChooseScreen();
            }));
          })
        ],
      )),
    );
  }
}

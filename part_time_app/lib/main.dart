import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Pages/Explore/testWebsocket.dart';
import 'package:part_time_app/Pages/Message/messageMainPage.dart';
import 'package:part_time_app/Pages/Search/sortPage.dart';
import 'package:part_time_app/Pages/Onboarding/onboradingPage.dart';
import 'package:part_time_app/Pages/Onboarding/openingPage.dart';
import 'package:provider/provider.dart';
import 'Pages/Message/user/chatConfig.dart';
import 'Pages/homePage.dart';
import 'Services/notification/notifacationServices.dart';
import 'Services/webSocketService.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationController.initializeNotification();
  initAndLoginIm();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    ChangeNotifierProvider(
      create: (context) => WebSocketService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Color(0xFFFCEEA5),
          foregroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xFFFCEEA5),
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: kMainYellowColor),
        useMaterial3: true,
      ),
      // home: const HomePage(),
      initialRoute: '/depo',
      getPages: [
        GetPage(name: '/opening', page: () => const OpeningPage()),
        GetPage(name: '/onboarding', page: () => const OnboradingPage()),
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/sort', page: () => SortPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/depo', page: () => MessageMainPage()),
      ],
    );
  }
}

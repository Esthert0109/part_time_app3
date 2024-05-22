import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Pages/Explore/highCommisionPage.dart';
import 'package:part_time_app/Pages/Explore/exploreMainPage.dart';
import 'package:part_time_app/Pages/Explore/testWebsocket.dart';
import 'package:part_time_app/Pages/Message/systemMessage1Page.dart';
import 'package:part_time_app/Pages/Search/searchResultPage.dart';
import 'package:part_time_app/Pages/Search/sortPage.dart';
import 'package:part_time_app/Pages/Onboarding/onboradingPage.dart';
import 'package:part_time_app/Pages/Onboarding/openingPage.dart';
import 'package:part_time_app/Pages/UserProfile/paymentHistoryDetailPage.dart';
import 'package:part_time_app/Pages/UserProfile/depositMainPage.dart';
import 'package:part_time_app/Pages/UserProfile/depositPaymentPage.dart';
import 'package:part_time_app/Pages/UserProfile/paymentHistoryPage.dart';

import 'Pages/Message/user/chatConfig.dart';
import 'Pages/UserProfile/ticketDetailsRecordPage.dart';
import 'Pages/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initAndLoginIm();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const MyApp());
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
      initialRoute: '/opening',
      getPages: [
        GetPage(name: '/opening', page: () => const OpeningPage()),
        GetPage(name: '/onboarding', page: () => const OnboradingPage()),
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/sort', page: () => SortPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/depo', page: () => TicketDetailsRecordPage()),
      ],
    );
  }
}

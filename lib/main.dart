import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code/screens/splash/splash.dart';
import 'package:flutter_code/service/firebase_options.dart';
import 'package:flutter_code/service/notification.dart';
import 'package:flutter_code/view_models/adresses_view_model.dart';
import 'package:flutter_code/view_models/firebase_view_model.dart';
import 'package:flutter_code/view_models/location_view_model.dart';
import 'package:flutter_code/view_models/maps_view_model.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MapsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddressesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ))),
      home: const SplashScreen(),
    );
  }
}

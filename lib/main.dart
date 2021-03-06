import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/services/navigation/navigation_service.dart';
import 'package:priyo_quiz/services/navigation/route_aware.dart';
import 'package:priyo_quiz/ui/common/splash_screen.dart';
import 'package:priyo_quiz/ui/dashboard/dashboard_screen.dart';
import 'package:priyo_quiz/utils/disable_glow.dart';
import 'package:priyo_quiz/utils/locator.dart';

final globalScaffoldKey = GlobalKey<ScaffoldState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  portrait();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent, // Color for Android
        statusBarBrightness: Brightness.dark));

    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      navigatorObservers: [RouteObserverX()],
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: ColorsX.primaryRed
        ),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder()
        })
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        if(child != null)
          return ScrollConfiguration(
            behavior: DisableScrollGlow(), 
            child: Scaffold(
              key: globalScaffoldKey,
              body: MediaQuery(
                child: child,
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              ),
            )
          );
        
        return Container();
      },
      routes: <String,WidgetBuilder>{
        DashboardScreen.routeName: (ctx) => DashboardScreen()
      },
      home: SplashScreen(),
    );
  }
}

Future portrait() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
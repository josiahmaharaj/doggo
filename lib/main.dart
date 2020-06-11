import 'package:events_mobile/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:events_mobile/bloc/_providers.dart';


Future main() async {
  //using custom provider
  await DotEnv().load('.env');
  Provider.debugCheckInvalidValueType = null;
  
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  // Crashlytics.instance.enableInDevMode = true;  -- add

  // Pass all uncaught errors from the framework to Crashlytics.
  // FlutterError.onError = Crashlytics.instance.recordFlutterError;   -- add
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of the application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAnalytics analytics = FirebaseAnalytics();
    //material app is wrapped in multiproviders so all children can access providers.
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        // navigatorObservers: [
        //   FirebaseAnalyticsObserver(analytics: analytics),
        // ],
        title: 'Events Mobile',
        theme: ThemeData(fontFamily: 'OpenSans'),
        debugShowCheckedModeBanner: false,
        // see router.dart
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

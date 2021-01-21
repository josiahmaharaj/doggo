import 'package:dog_ceo/components/connectivity_status.dart';
import 'package:dog_ceo/router.dart' as emRouter;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:dog_ceo/services/connectivity_service.dart';

Future main() async {
  //using custom provider
  await DotEnv().load('.env');
  Provider.debugCheckInvalidValueType = null;

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
    precacheImage(AssetImage("assets/pug-min.jpg"), context);
    return StreamProvider<ConnectivityStatus>(
      create: (_) => ConnectivityService().connectionStatusController.stream,
      child: MaterialApp(
        title: 'Dog CEO',
        theme: ThemeData(fontFamily: 'OpenSans'),
        debugShowCheckedModeBanner: false,
        // see router.dart
        initialRoute: '/',
        onGenerateRoute: emRouter.Router.generateRoute,
      ),
    );
  }
}

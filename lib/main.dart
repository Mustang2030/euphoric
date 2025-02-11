import 'package:euphoric/firebase_options.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BindingBase.debugZoneErrorsAreFatal;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => RouteManagerProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Allows for use of provider
    return MaterialApp(
      //Removes the debug banner on the top right.
      debugShowCheckedModeBanner: false,
      //The first page that shows up when the application launches is set to the login page
      onGenerateRoute: Provider.of<RouteManagerProvider>(context, listen: false)
          .generateRoute,
      initialRoute: RouteManagerProvider.authPage,
    );
  }
}

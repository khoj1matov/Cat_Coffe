import 'package:fireapp3/core/components/themedata_comp.dart';
import 'package:fireapp3/provider/login_provider.dart';
import 'package:fireapp3/provider/route_provider.dart';
import 'package:fireapp3/provider/upload_coffee_provider.dart';
import 'package:fireapp3/routes/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/image_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RouteProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ImgProvider()),
        ChangeNotifierProvider(create: (_) => UploadCoffeeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final MyRouter _myRouter = MyRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffe Shop',
      theme: ThemeComp.myTheme,
      onGenerateRoute: _myRouter.OnGenerateRoute,
      initialRoute: context.watch<RouteProvider>().route,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/firebase_options.dart';
import 'package:task_flow/providers/taskprovider.dart';
import 'package:task_flow/providers/userprovider.dart';
import 'package:task_flow/screens/splash.dart';
// import 'package:task_flow/screens/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Taskprovider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Userprovider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

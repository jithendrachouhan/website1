import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website/provider/data_provider.dart';
import 'package:website/views/pages/homee_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDvofpKHk4nC9_ba0LBsnDYPrjKUCFEoGY",
        authDomain: "photos-2c435.firebaseapp.com",
        projectId: "photos-2c435",
        storageBucket: "photos-2c435.appspot.com",
        messagingSenderId: "956110289674",
        appId: "1:956110289674:web:46a809c6eeed655dd418f3",
        measurementId: "G-BB8Q7KTYG8"
    )
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}



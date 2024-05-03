
import 'package:chatfirebase/screens/home_screen.dart';
import 'package:chatfirebase/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:const FirebaseOptions(
        apiKey: "AIzaSyDif3F7H87yNJ8yGymRLjDBWMacCr2RaB0",
        appId: "1:96270576515:android:d91762b79489265e8924b6",
        messagingSenderId: "96270576515",
        projectId: "chat-76c54"),
  );
 // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instance.userChanges().listen((event) {
    print("User : ${event?.email}");
  });

  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot) {
            if (snapShot.hasData) {
              return const HomeScreen();
            } else {
              return const SignInScreen();
            }
          }),
    );
  }
}

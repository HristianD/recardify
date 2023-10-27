import 'package:flutter/material.dart';
import 'package:recardify/routing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
    CustomNavigationHelper.instance;
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: CustomNavigationHelper.router,
            theme: ThemeData(
                scaffoldBackgroundColor: const Color(0xff527462),
                appBarTheme: const AppBarTheme(
                    actionsIconTheme: IconThemeData(
                        color: Color(0xffd5dcdc)
                    ),
                    backgroundColor: Color(0xffd5dcdc)
                ),
                textTheme: const TextTheme(
                    bodyLarge: TextStyle(
                        color: Color(0xffc0c49b)
                    ),
                    bodyMedium: TextStyle(
                        color: Color(0xffc0c49b)
                    ),
                    bodySmall: TextStyle(
                        color: Color(0xffc0c49b)
                    )
                )
            )
        );
    }
}
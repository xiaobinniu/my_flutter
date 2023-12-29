import 'package:flutter/material.dart';
import 'package:my_flutter/view/home.dart';
import 'package:my_flutter/view/error.dart';

import 'bilibili/bilibili_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      initialRoute: "home",
      home: const Home(),
      // routes: {
      //   "history": (context) => const History(),
      // },
      onGenerateRoute: (settings) {
        return _generateRoute(settings);
      },
    );
  }
}

PageRouteBuilder _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

PageRouteBuilder _generateRoute(RouteSettings settings) {
  Widget page;

  // Your dynamic routing logic based on settings
  switch (settings.name) {
    case 'home':
      page = const Home();
      break;
    case 'bilibili-home':
      page = const BilibiliHome();
      break;
    default:
      return _createRoute(const Error());
  }

  return _createRoute(page);
}

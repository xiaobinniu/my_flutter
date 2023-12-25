import 'package:flutter/material.dart';
import 'package:my_flutter/history.dart';
import 'package:my_flutter/home.dart';
import './error.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      home: Home(),
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
    case '/':
      page = Home();
      break;
    case 'history':
      page = const History();
      break;
    // Add more cases as needed
    default:
      // Handle unknown routes
      return _createRoute(const Error());
  }

  return _createRoute(page);
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moface/user/presentation/screens/login_screen.dart';
import 'package:moface/user/presentation/screens/home.dart';
import 'package:moface/user/presentation/screens/splash_screen.dart';
import 'package:moface/user/presentation/screens/suggestion_friends.dart';

import '../user/presentation/screens/main_screen.dart';
import '../user/presentation/screens/profile_screen.dart';

class Routers {
  static const String splashScreen = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String main = '/main';
  static const String profile = '/profile';
  static const String suggestionFriends = '/suggestion';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routers.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routers.login :
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routers.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routers.profile:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case Routers.main:
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case Routers.suggestionFriends:
        return MaterialPageRoute(builder: (context) => const SuggestionFriendsScreen());
      default :
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text("No Route Found"),
          ),
          body: const Center(
            child: Text("No Route Found"),
          ),
        ));
  }
}




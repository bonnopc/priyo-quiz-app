import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {bool replace = false}) {
    if (replace)
      return navigatorKey.currentState!.pushReplacementNamed(routeName);
    else
      return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithArgument(String routeName,
      {dynamic arguments, bool replace = false}) {
    if (replace)
      return navigatorKey.currentState
          !.pushReplacementNamed(routeName, arguments: arguments);
    else
      return navigatorKey.currentState
          !.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndRemoveUntil(String routeName, String predicateRoute, 
    { dynamic arguments }
  ){
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName, 
      ModalRoute.withName(predicateRoute),
      arguments: arguments
    );
  }
}

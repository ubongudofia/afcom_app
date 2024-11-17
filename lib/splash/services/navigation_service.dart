import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

  void removeAndNavigateToRoute(stringRoute) {
    navigatorkey.currentState?.pop;
  }
}

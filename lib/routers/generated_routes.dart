import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:plane_startup/screens/home_screen.dart';
import '../utils/page_route_builder.dart';
import 'routes_path.dart';

class GeneratedRoutes {
  
  bool isAutheticated() {
    return true;
  }

   Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesPaths.home:
        return PageRoutesBuilder.sharedAxis(
        const HomeScreen(),
          SharedAxisTransitionType.horizontal,
        );

      default:
        return PageRoutesBuilder.sharedAxis(
          const HomeScreen(),
          SharedAxisTransitionType.horizontal,
        );
    }
  }
}

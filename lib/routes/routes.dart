import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/new_task_page.dart';
import '../pages/edit_task_page.dart';
import '../pages/loading.dart';

class RouteGenerator {
  //PascalCase
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? routeName = settings.name;
    switch (routeName) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/new_task':
        return MaterialPageRoute(
          builder: (_) => const NewTaskPage(),
          settings: settings,
        );
      case '/edit':
        return MaterialPageRoute(
          builder: (_) => const EditTaskPage(),
          settings: settings,
        );
      case '/loading':
        return MaterialPageRoute(
          builder: (_) => const Loading(),
          settings: settings,
        );
      default:
        // If the route is not defined, you can handle it here
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('404: Route not found!'),
            ),
          ),
        );
    }
  }
}

import 'package:fireapp3/screens/home/details_admin_page.dart';
import 'package:fireapp3/screens/home/details_page.dart';
import 'package:fireapp3/screens/pages/card_page.dart';
import 'package:fireapp3/screens/pages/create_page.dart';
import 'package:fireapp3/screens/pages/login_page.dart';
import 'package:flutter/material.dart';

class MyRouter {
  Route? OnGenerateRoute(RouteSettings s) {
    switch (s.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const DetailsPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/create':
        return MaterialPageRoute(builder: (_) => const CreatePage());
      case '/card':
        return MaterialPageRoute(builder: (_) => const CardPage());
      case '/details':
        return MaterialPageRoute(builder: (_) => const DetailsPage());
      case '/admin':
        return MaterialPageRoute(builder: (_) => const DetailsAdminPage());
    }
  }
}

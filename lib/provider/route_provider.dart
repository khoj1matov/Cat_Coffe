import 'package:fireapp3/service/firebase_servoce.dart';
import 'package:flutter/foundation.dart';

class RouteProvider extends ChangeNotifier {
  RouteProvider() {
    checkLoginPage();
  }

  String route = '/login';

  void checkLoginPage() {
    if (FireService.auth.currentUser != null) {
      if (FireService.auth.currentUser!.email == "admin@gmail.com") {
        FireService.auth.currentUser != null
            ? route = '/admin'
            : route = '/login';
      } else {
        FireService.auth.currentUser != null
            ? route = '/home'
            : route = '/login';
      }
    }
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class Routes {
  static const login = '/login';
  static const register = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case register:
      //   return MaterialPageRoute(builder: (_) => RegisterView());
      // case login:
      //   return MaterialPageRoute(builder: (_) => LoginView());
      // case otpVerification:
      //   var fromRegister = settings.arguments as bool;
      //   return MaterialPageRoute(
      //       builder: (_) => OTPView(fromRegister: fromRegister));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

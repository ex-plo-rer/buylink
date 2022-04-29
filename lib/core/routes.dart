import 'package:flutter/material.dart';

import '../features/authentication/views/forgot_password_view.dart';
import '../features/authentication/views/onboarding_view.dart';
import '../features/authentication/views/signup_view.dart';
import '../features/core/views/home_view.dart';
import '../features/authentication/views/login_view.dart';
import '../features/core/views/no_product_search_view.dart';
import '../features/core/views/store_views/add_store.dart';
import '../features/core/views/store_views/empty_state.dart';
import '../features/core/views/store_views/store_settings.dart';
import '../features/core/views/store_views/store_view.dart';

class Routes {
  static const login = '/login';
  static const signup = '/signup';
  static const homeView = '/home';
  static const forgotpassword = '/forgotpassword';
  static const onboarding = '/onboarding';
  static const storeView ='/store';
  static const noproductView = '/noproduct';
  static const addstoreView = '/addstore';
  static const emptystoreView = '/emptystore';
  static const storesettingView = '/storesetting';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signup:
        return MaterialPageRoute(builder: (_) => SignupView());
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case homeView:
        return MaterialPageRoute(builder: (_) => HomeView());
      case forgotpassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingView());
      case storeView:
        return MaterialPageRoute(builder: (_) => StoreView());
      case noproductView:
        return MaterialPageRoute(builder: (_) => NoProductView());
      case addstoreView:
        return MaterialPageRoute(builder: (_) => AddStoreView());
      case emptystoreView:
        return MaterialPageRoute(builder: (_) => EmptyStateView());
      case storesettingView:
        return MaterialPageRoute(builder: (_) => StoreSetting());



    // case otpVerification:
      //   var fromRegister = settings.arguments as bool;
      // return MaterialPageRoute(
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

import 'package:buy_link/features/core/views/add_review_view.dart';
import 'package:buy_link/features/core/views/categories_view.dart';
import 'package:buy_link/features/core/views/compare_view.dart';
import 'package:buy_link/features/core/views/product_details_view.dart';
import 'package:buy_link/features/core/views/shop_details_view.dart';
import 'package:buy_link/features/core/views/store_views/product_searched_view.dart';
import 'package:buy_link/features/core/views/store_views/store_dashboard_view.dart';
import 'package:buy_link/features/core/views/store_views/store_visits_view.dart';
import 'package:buy_link/features/core/views/wishlist_view.dart';
import 'package:flutter/material.dart';

import '../features/authentication/views/forgot_password_view.dart';
import '../features/authentication/views/onboarding_view.dart';
import '../features/authentication/views/signup_view.dart';
import '../features/core/views/home_view.dart';
import '../features/authentication/views/login_view.dart';
import '../features/core/views/no_product_search_view.dart';
import '../features/core/views/store_views/add_store.dart';
import '../features/core/views/store_views/empty_state.dart';
import '../features/core/views/store_views/store_view.dart';
import '../features/core/views/store_reviews_view.dart';

class Routes {
  static const login = '/login';
  static const signup = '/signup';
  static const homeView = '/home';
  static const forgotPassword = '/forgot-password';
  static const wishlist = '/wishlist';
  static const categories = '/categories';
  static const compare = '/compare';
  static const productDetails = '/product-details';
  static const shopDetails = '/shop-details';
  static const storeReviews = '/store-reviews';
  static const addReview = '/add-review';
  static const onboarding = '/onboarding';
  static const storeView = '/store';
  static const storeVisits = '/store-visits';
  static const productSearched = '/product-searched';
  static const storeDashboard = '/store-dashboard';
  static const noproductView = '/noproduct';
  static const addstoreView = '/addstore';
  static const emptystoreView = '/emptystore';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signup:
        return MaterialPageRoute(builder: (_) => SignupView());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingView());
      case wishlist:
        return MaterialPageRoute(builder: (_) => const WishlistView());
      case categories:
        return MaterialPageRoute(builder: (_) => const CategoriesView());
      case compare:
        return MaterialPageRoute(builder: (_) => CompareView());
      case productDetails:
        return MaterialPageRoute(builder: (_) => const ProductDetailsView());
      case shopDetails:
        return MaterialPageRoute(builder: (_) => const ShopDetailsView());
      case storeReviews:
        return MaterialPageRoute(builder: (_) => StoreReviewsView());
      case addReview:
        return MaterialPageRoute(builder: (_) => AddReviewView());
      case storeView:
        return MaterialPageRoute(builder: (_) => const StoreView());
      case productSearched:
        return MaterialPageRoute(builder: (_) => const ProductSearchedView());
      case storeDashboard:
        return MaterialPageRoute(builder: (_) => const StoreDashboardView());
      case storeVisits:
        return MaterialPageRoute(builder: (_) => const StoreVisitsView());
      case noproductView:
        return MaterialPageRoute(builder: (_) => NoProductView());
      case addstoreView:
        return MaterialPageRoute(builder: (_) => AddStoreView());
      case emptystoreView:
        return MaterialPageRoute(builder: (_) => EmptyStateView());

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

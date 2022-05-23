import 'package:buy_link/features/core/views/add_product_view.dart';
import 'package:buy_link/features/core/views/add_review_view.dart';
import 'package:buy_link/features/core/views/categories_view.dart';
import 'package:buy_link/features/core/views/compare_view.dart';
import 'package:buy_link/features/core/views/dashboard_view.dart';
import 'package:buy_link/features/core/views/product_details_more_view.dart';
import 'package:buy_link/features/core/views/product_details_view.dart';
import 'package:buy_link/features/core/views/settings_view/change_name.dart';
import 'package:buy_link/features/core/views/settings_view/change_password.dart';
import 'package:buy_link/features/core/views/settings_view/delete_user.dart';
import 'package:buy_link/features/core/views/settings_view/settings_notification.dart';
import 'package:buy_link/features/core/views/store_views/store_details_view.dart';
import 'package:buy_link/features/core/views/store_views/product_searched_view.dart';
import 'package:buy_link/features/core/views/store_views/store_dashboard_view.dart';
import 'package:buy_link/features/core/views/store_views/store_direction_view.dart';
import 'package:buy_link/features/core/views/store_views/store_visits_view.dart';
import 'package:buy_link/features/core/views/wishlist_view.dart';
import 'package:flutter/material.dart';

import '../features/authentication/views/forgot_password_view.dart';
import '../features/core/models/compare_arg_model.dart';
import '../features/core/models/product_model.dart';
import '../features/core/views/settings_view/about_buylink.dart';
import '../features/core/views/settings_view/change_email.dart';
import '../features/core/views/settings_view/privacy_policy.dart';
import '../features/startup/views/onboarding_view.dart';
import '../features/authentication/views/signup_view.dart';
import '../features/core/views/home_view.dart';
import '../features/authentication/views/login_view.dart';
import '../features/core/views/message_view/message_view.dart';
import '../features/core/views/no_product_search_view.dart';
import '../features/core/views/store_views/add_store.dart';
import '../features/core/views/store_views/store_empty_state.dart';
import '../features/core/views/store_views/store_settings.dart';
import '../features/core/views/store_views/store_view.dart';
import '../features/core/views/store_reviews_view.dart';

class Routes {
  static const login = '/login';
  static const signup = '/signup';
  static const homeView = '/home';
  static const dashboard = '/dashboard';
  static const forgotPassword = '/forgot-password';
  static const wishlist = '/wishlist';
  static const categories = '/categories';
  static const compare = '/compare';
  static const productDetails = '/product-details';
  static const productDetailsMore = '/product-details-more';
  static const storeDetails = '/shop-details';
  static const storeReviews = '/store-reviews';
  static const addReview = '/add-review';
  static const onboarding = '/onboarding';
  static const storeView = '/store';
  static const storeVisits = '/store-visits';
  static const productSearched = '/product-searched';
  static const storeDashboard = '/store-dashboard';
  static const storeDirection = '/store-direction';
  static const noproductView = '/noproduct';
  static const addstoreView = '/addstore';
  static const emptystoreView = '/emptystore';
  static const storesettingView = '/storesetting';
  static const messageView = '/message';
  static const addProduct = '/addproduct';
  static const privacyPolicy = '/privacypolicy';
  static const deleteUser = '/deleteuser';
  static const about = '/about';
  static const settingNotification = '/settingnot';
  static const changePassword = '/changepassword';
  static const changeEmail = '/changeemail';
  static const editUsername = '/editusername';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signup:
        return MaterialPageRoute(builder: (_) => SignupView());
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case homeView:
        return MaterialPageRoute(builder: (_) => HomeView());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingView());
      case dashboard:
        return MaterialPageRoute(builder: (_) => DashboardView());
      case wishlist:
        return MaterialPageRoute(builder: (_) => const WishlistView());
      case categories:
        return MaterialPageRoute(builder: (_) => const CategoriesView());
      case compare:
        var arguments = settings.arguments as CompareArgModel;
        return MaterialPageRoute(
          builder: (_) => CompareView(
            arguments: arguments,
          ),
        );
      case productDetails:
        var product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsView(
            product: product,
          ),
        );
      case productDetailsMore:
        return MaterialPageRoute(builder: (_) => ProductDetailsMoreView());
      case storeDetails:
        Store store = settings.arguments as Store;
        return MaterialPageRoute(
          builder: (_) => StoreDetailsView(
            store: store,
          ),
        );
      case storeReviews:
        Store store = settings.arguments as Store;
        return MaterialPageRoute(
          builder: (_) => StoreReviewsView(
            store: store,
          ),
        );
      case addReview:
        int storeId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => AddReviewView(
            storeId: storeId,
          ),
        );
      case storeView:
        return MaterialPageRoute(builder: (_) => const StoreView());
      case productSearched:
        return MaterialPageRoute(builder: (_) => const ProductSearchedView());
      case storeDashboard:
        return MaterialPageRoute(builder: (_) => const StoreDashboardView());
      case storeVisits:
        return MaterialPageRoute(builder: (_) => const StoreVisitsView());
      case storeDirection:
        return MaterialPageRoute(builder: (_) => const StoreDirectionView());
      case noproductView:
        return MaterialPageRoute(builder: (_) => NoProductView());
      case addstoreView:
        return MaterialPageRoute(builder: (_) => AddStoreView());
      case emptystoreView:
        return MaterialPageRoute(builder: (_) => StoreEmptyStateView());
      case storesettingView:
        return MaterialPageRoute(builder: (_) => StoreSetting());
      case messageView:
        return MaterialPageRoute(builder: (_) => MessageView());

      case addProduct:
        return MaterialPageRoute(builder: (_) => AddProductView());

      case privacyPolicy:
        return MaterialPageRoute(builder: (_) => PrivacyPolicy());

      case deleteUser:
        return MaterialPageRoute(builder: (_) => DeleteUser());
      case about:
        return MaterialPageRoute(builder: (_) => About());
      case settingNotification:
        return MaterialPageRoute(builder: (_) => SettingNotification());
      case changePassword:
        return MaterialPageRoute(builder: (_) => ChangePassword());
      case changeEmail:
        return MaterialPageRoute(builder: (_) => ChangeEmail());
      case editUsername:
        return MaterialPageRoute(builder: (_) => EditUserName());



    // case otpVerification:
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

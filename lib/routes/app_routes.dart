import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/onboarding/onboarding.dart';
import '../features/authentication/screens/password_configuration/forget_password.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/personalization/screens/address/address.dart';
import '../features/personalization/screens/profile/profile.dart';
import '../features/personalization/screens/settings/settings.dart';
import '../features/shop/screens/cart/cart.dart';
import '../features/shop/screens/checkout/checkout.dart';
import '../features/shop/screens/home/home.dart';
import '../features/shop/screens/order/order.dart';
import '../features/shop/screens/product_review/product_reviews.dart';
import '../features/shop/screens/store/store.dart';
import '../features/shop/screens/wishlist/wishlist.dart';
import 'routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: MyRoutes.home, page: () => const HomeScreen()),
    GetPage(name: MyRoutes.store, page: () => const StoreScreen()),
    GetPage(name: MyRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: MyRoutes.settings, page: () => const SettingsScreen()),

    // Product
    GetPage(
        name: MyRoutes.productReviews,
        page: () => const ProductReviewsScreen()),

    // Order & Cart
    GetPage(name: MyRoutes.order, page: () => const OrderScreen()),
    GetPage(name: MyRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: MyRoutes.cart, page: () => const CartScreen()),

    // User
    GetPage(name: MyRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: MyRoutes.userAddress, page: () => const UserAddressScreen()),

    // Auth
    GetPage(name: MyRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: MyRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: MyRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
        name: MyRoutes.forgetPassword,
        page: () => const ForgetPasswordScreen()),

    // Onboarding
    GetPage(name: MyRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];
}

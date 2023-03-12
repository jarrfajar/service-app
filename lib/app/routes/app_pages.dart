import 'package:get/get.dart';

import '../modules/all_category/bindings/all_category_binding.dart';
import '../modules/all_category/views/all_category_view.dart';
import '../modules/all_review/bindings/all_review_binding.dart';
import '../modules/all_review/views/all_review_view.dart';
import '../modules/all_service/bindings/all_service_binding.dart';
import '../modules/all_service/views/all_service_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/auth/resetPassword/bindings/reset_password_binding.dart';
import '../modules/auth/resetPassword/views/reset_password_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/detail_product/bindings/detail_product_binding.dart';
import '../modules/detail_product/views/detail_product_view.dart';
import '../modules/detail_service/bindings/detail_service_binding.dart';
import '../modules/detail_service/views/detail_service_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/seller_store/bindings/seller_store_binding.dart';
import '../modules/seller_store/views/seller_store_view.dart';
import '../modules/servis/bindings/servis_binding.dart';
import '../modules/servis/views/servis_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/store/bindings/store_binding.dart';
import '../modules/store/views/store_view.dart';
import '../modules/tambah_servis/bindings/tambah_servis_binding.dart';
import '../modules/tambah_servis/views/tambah_servis_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.SPLASH_SCREEN;
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => BookingView(),
      binding: BookingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SERVIS,
      page: () => const ServisView(),
      binding: ServisBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_SERVIS,
      page: () => const TambahServisView(),
      binding: TambahServisBinding(),
    ),
    GetPage(
      name: _Paths.ALL_CATEGORY,
      page: () => const AllCategoryView(),
      binding: AllCategoryBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SERVICE,
      page: () => DetailServiceView(),
      binding: DetailServiceBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT,
      page: () => DetailProductView(),
      binding: DetailProductBinding(),
    ),
    GetPage(
      name: _Paths.ALL_REVIEW,
      page: () => AllReviewView(),
      binding: AllReviewBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_STORE,
      page: () => SellerStoreView(),
      binding: SellerStoreBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.ALL_SERVICE,
      page: () => const AllServiceView(),
      binding: AllServiceBinding(),
    ),
    GetPage(
      name: _Paths.STORE,
      page: () => StoreView(),
      binding: StoreBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}

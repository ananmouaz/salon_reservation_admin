import '../../app_settings.dart';

class ApiURLs {
  ///baseUrl
  static const String baseUrl = AppSettings.baseUrl;
  static const String imageBaseUrl = 'https://booket.sy/assets/uploads/business/';

  // User
  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String getUserInfo = '$baseUrl/get_logged_in_user';

  // Notifications
  static const String setFCMToken = '$baseUrl/update_fcm_token';
  static const String getNotifications = '$baseUrl/api/services/app/Notify/GetNotifications';
  static const String removeFCMToken = '$baseUrl/api/services/app/Profile/removeFCMToken';
  static const String readNotification = '$baseUrl/api/services/app/Notify/ReadNotification';
  static const String getUnreadNotifications = '$baseUrl/api/services/app/Notify/GetUnreadNotificationsCount';

  // Products
  static const String product = '$baseUrl/product';
  static const String service = '$baseUrl/service';
  static const String updateService = '$baseUrl/update_service';
  static const String deleteService = '$baseUrl/delete_service';
  static const String businessService = '$baseUrl/business_services';
  static const String salons = '$baseUrl/business';
  static const String updateBusiness = '$baseUrl/update_business';
  static const String booking = '$baseUrl/booking';
  static const String myBooking = '$baseUrl/business_bookings';
  static const String transactions = '$baseUrl/transactions';
  static const String remaining = '$baseUrl/remaining';
  static const String timesOfDay = '$baseUrl/getAvailableHours';
  static const String review = '$baseUrl/reviews';
  static const String changeBookingStatus = '$baseUrl/change_booking_status';
  static const String changeBookingPrice = '$baseUrl/change_booking_price';
  static const String category = '$baseUrl/category';
  static const String categories = '$baseUrl/categories';
  static const String order = '$baseUrl/order';
  static const String getOrders = '$baseUrl/get_user_orders/';
  static const String getOrderItems = '$baseUrl/get_order_items/';
  static const String brand = '$baseUrl/brand';
  static const String warehouse = '$baseUrl/get_all_warehouses';
  static const String advertisement = '$baseUrl/advertisement';
  static const String getProductsOfCategory = '$baseUrl/get_by_category/';
  static const String getProductsOfBrand = '$baseUrl/get_by_brand/';
  static const String getProductImage = '$imageBaseUrl/product';
  static const String getCategoryImage = '$imageBaseUrl/category';
  static const String getAdvertisementImage = '$imageBaseUrl/advertisement';
  static const String getAllAds = '$baseUrl/get_all_ads';
  static const String getAllWarehouses = '$baseUrl/get_all_warehouses';
}

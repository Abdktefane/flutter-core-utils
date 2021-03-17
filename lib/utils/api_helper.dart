// const BASE_API = 'https://tawreedapp.ae';
// const BASE_API = 'http://34.235.130.49';
const BASE_STATIC_API = '$BASE_URL/static';

const BASE_API = '$BASE_URL$REST_SUFFIX';

const BASE_URL = 'https://api.tawreed.ai';

const REST_SUFFIX = '/rest';

abstract class ApiFunctions {
  // App

  static String getConstants = '/common/constants/all';

  static String upload = '/files/upload';

  static String getCartItemsCount = '/customers/shopping/carts/items/count';

  static String getNotificationsCount = '/notification/users/messages/count';

  static String registerDevice = '/notification/public/devices/create';

  static String deleteDevice = '/notification/public/devices/delete';

  static String linkDevice = '/notification/users/devices/link';

  static String unlinkDevice = '/notification/users/devices/unlink';

  // Auth
  static String login = '/auth/public/customer/login';

  static String register = '/customers/public/register';

  static String updateBusinessInfo = '/customers/profile/update';

  static String otpSend = '/auth/public/otp/send';

  static String otpVerify = '/auth/public/otp/verify';

  static String getProfile = '/auth/users/profile';

  static String sitesGetAll = '/common/public/sites/all';

  static String getSiteStates = '/common/public/sites/states/all';

  static String getTicketCategories = '/common/public/ticket/categories/all';

  static String getCustomerProfile = '/customers/profile';

  static String getAllLanguages = '/common/public/languages/all';

  static String forgotPassword = '/auth/public/users/password/forgot';

  static String resetPassword = '/auth/public/users/password/forgot/update';

  static String forgotPasswordUpdate = '/auth/public/users/password/forgot/update';

  static String validateMobileUnique = '/auth/public/users/mobile/validate/unique';

  // Settings

  static String updateLanguage = '/auth/users/language/update';

  static String validateEmailUnique = '/auth/public/users/email/validate/unique';

  static String updatePersonalInfo = '/auth/users/personal/update';

  static String changeMobile = '/auth/users/mobile/change';
  static String changeMobileUpdate = '/auth/users/mobile/change/update';

  static String changeEmail = '/auth/users/email/change';
  static String changeEmailUpdate = '/auth/users/email/change/update';

  static String changePassword = '/auth/users/password/change';

  static String updateAddress = '/customers/update';

  static String sendTicket = '/support/public/ticket/create';

  // Vendors
  static String getConnectedDistributors = '/customers/stores/linked/search';

  static String geUnConnectedDistributors = '/customers/stores/unlinked/search';

  static String connectToDistributor = '/customers/stores/link';

  static String disconnectDistributor = '/customers/stores/linked/unlink';

  static String getVendorStoreInfo = '/customers/stores/get';

  // products
  static String getAllProducts = '/customers/products/search/stores';

  static String calculateOffer = '/customers/products/offers/get';

  static String addToCart = '/customers/shopping/carts/items/add';

  // Basket
  static String getCart = '/customers/shopping/carts/get';

  static String checkout = '/customers/shopping/carts/checkout';

  static String deleteItem = '/customers/shopping/carts/items/delete';

  static String updateQuantity = '/customers/shopping/carts/items/update';

  static String getPaymentTerms = '/customers/stores/payment/terms/get';

  static String getProductsByStoreId = '/customers/products/get';

  static String deleteCartItem = '/customers/shopping/carts/items/delete';

  static String changeQuantity = '/customers/shopping/carts/items/update';

  // orders

  static String getAllOrders = '/customers/orders/search';

  static String getOrderDetails = '/customers/orders/get';

  static String cancelOrder = '/customers/orders/cancel';

  // Home

  static String getOrdersReport = '/customers/reports/orders/count';

  static String getLoyaltyReport = '/customers/reports/loyalty/total';

  // Notifications

  static String getNotifications = '/notification/users/messages/all';
  static String markAsRead = '/notification/users/messages/read';

  // loyalty

  static String getAvailableLoyaltyBalance = '/customers/loyalty/balance';

  static String getOutstandingLoyaltyBalance = '/customers/loyalty/outstanding/balance';

  static String getPointsHistory = '/customers/loyalty/transactions/search';

  static String getTransactions = '/customers/invoices/search';

  static String redeem = '/customers/loyalty/redeem';
}

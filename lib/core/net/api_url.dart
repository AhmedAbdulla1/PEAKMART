/// API
class APIUrls {
  static const baseUrl = "https://hk.herova.net/";

  // auth api
  static const login = "${baseUrl}login_API/login-api.php";
  static const resetPassword = "${baseUrl}login_API/SendToMail.php";
  static const register = "${baseUrl}login_API/signUp-api.php";
  static const sendOtp = "${baseUrl}login_API/SendOTP.php";
  static const verfiyOtp = "${baseUrl}login_API/verfiyOTP.php";
  static const sendWatsAppOtp = "${baseUrl}bids/whatsApp.php";
  static const verfiyWatsAppOtp = "${baseUrl}bids/verify.php";
  static const registerAsSeller = "${baseUrl}bids/bid_own_rig.php";
  static const addSellerInfo = "${baseUrl}bids/bid_owner_rig_info.php";

  // profile api

  static const getUserInfo = "${baseUrl}data/user_info.php";
  static const getUserProducts = "${baseUrl}data/user_products.php";
  static const updateUserInfo = "${baseUrl}data/update_info.php";
  static const updateUserImage = "${baseUrl}data/change_photo.php";

  // home api
  static const getNews = "${baseUrl}InPageApi/news-api.php";
  static const getBidWorkNow = "${baseUrl}products/fetch.php?key=1";
  static const getFutureBids = "${baseUrl}products/fetch.php?key=4";
  static const getEndedBids = "${baseUrl}products/fetch.php?key=3";
  static const getTrendingBids = "${baseUrl}products/fetch.php?key=3";
  static const getCategories = "${baseUrl}products/fetch.php?key=2";

  static const getProductsByCategory = "${baseUrl}products/cat_p.php";

  // static const getAllProducts = "${baseUrl}products/fetch.php?key=4";

  static const getContent = "${baseUrl}InPageApi/pageContent-api.php";

  // Add Product
  static const addProduct = "${baseUrl}products/new_Product.php";
  static const checkIsASeller = "${baseUrl}login_API/admin_c.php";
}

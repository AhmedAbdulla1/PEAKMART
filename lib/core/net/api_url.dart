/// API
class APIUrls {
  static const baseUrl = "https://hk.herova.net/";


  // auth api
  static const login = "${baseUrl}login_API/login-api.php";
  static const resetPassword = "${baseUrl}login_API/SendToMail.php";
  static const register = "${baseUrl}login_API/signUp-api.php";
  static const sendOtp = "${baseUrl}login_API/SendOTP.php";
  static const verfiyOtp = "${baseUrl}login_API/verfiyOTP.php";



  // home api
  static const getNews = "${baseUrl}InPageApi/news-api.php";


}

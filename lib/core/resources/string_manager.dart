import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  static String phone = tr('mobile_number');
  static String phoneHint = tr('mobile_number_hint');
  static String phoneError = tr("invalid_mobile_number");
  static String searchCountry = tr("search_country");

  static String emailErrorEmpty = tr('email_empty');
  static String emailNotValid = tr('email_not_valid');
  static String passwordErrorEmpty = tr('password_empty');
  static String cancel = tr('cancel');
  static String confirm = tr('confirm');
  static String forgotPassword = tr('forgot_password');
  static String resetPassword = tr('reset_password');
  static String forgotPasswordHint = tr('reset_password_hint');
  static String rPSMessage =
      'Send you a message to set or reset your new password';
  static String refresh = 'refresh';
  static String otpSuccessMessage = 'OTP Verified Successfully!';

  ///////////////////////////////////////////////////////////////
  static String createAccount = tr('Create an account');
  static String alreadyHaveAnAccount = tr('Already have an account?');
  static String login = tr('Login');
  static String signUp = tr('Sign Up');
  static String otp = tr('OTP');
  static String otpHeader =
      tr('Enter the code we sent you to your e-mail here');
  static String otpNotReceived = tr('Didn\'t receive a code?');
  static String otpResend = tr('Resend');
  static String byClicking = tr('By clicking the');
  static String register = tr(' Register ');
  static String agreeText = tr('button, you agree to the public offer');
  static String userName = tr('Username');
  static String userNameHint = tr('Enter your name');
  static String email = tr('Email');
  static String emailHint = tr('Enter your email');
  static String password = tr('Password');
  static String passwordHint = tr('Enter your password');
  static String confirmPassword = tr('Confirm Password');
  static String confirmPasswordHint = tr('Confirm your password');
  static String google = tr('Google');

  static const String noRouteFound = "No Route Found";
  static const String getStart = 'Get Started';
  static const String loginTitle = 'SIGN IN';
  static const String saveAndExit = 'Save And Exit';
  static const String save = 'Save';
  static const String delete = 'delete';
  static const String teams = 'Teams';
  static const String addNewDevice = 'Add New Device';
  static const String loginSubTitle =
      'Looks like you don’t have an account. Let’s create a new account for you.';
  static const String signUpWithgoogle = 'Sign Up with Google';
  static const String apple = 'Sign Up with Apple';
  static const String haveAnAccount = "have an account?";
  static const String dontHaveAnAccount = "Don’t have an account?";
  static const String guest = "CONTINUE AS A GUEST";
  static const String signup = 'Create Account';
  static const String signupTitle = 'SIGN UP';
  static const String signupSubTitle =
      'Looks like you don’t have an account. Let’s create a new account for you.';
  static const String privacy =
      'By selecting Create Account below, I agree to Terms of Service & Privacy Policy';
  static const String recoverPasswordTitle = "Recover Password";
  static const String recoverPasswordSubTitle =
      'Forgot your password? Don’t worry, enter your email to reset your current password.';
  static const String submit = 'SUBMIT';
  static const String verifyCodeTitle = "Verify Code";
  static const String verifyCodeSubTitle =
      'An authentication code has been sent to your email';
  static const String verify = 'VERIFY';
  static const String enterCode = 'Enter Code ';
  static const String resendCode = "Didn’t receive a code?";
  static const String resend = 'Resend';
  static const String changePasswordTitle = 'Change Password';
  static const String changePasswordSubTitle =
      "Create a new, strong password that you don’t use before";
  static const String newPassword = 'New Password';
  static const String profile = 'Profile';
  static const String bodyWeight = 'Body Weight';
  static const String height = 'Height';
  static const String age = 'Age';
  static const String gender = 'Gender';
  static const String passwordError2 =
      "Your password could be stronger. Consider using uppercase letters and symbols.";
  static const String bodyWeightError = 'Enter valid weight';
  static const String heightError = 'Enter valid height';
  static const String ageError = 'Enter valid age';
  static const String updateProfile = 'Update Profile';
  static const String exercises = 'Exercises';
  static const String advanced = 'Advanced';
  static const String selectWeight = 'Select your weight';
  static const String large = "Large";
  static const String small = "Small";
  static const String autoStart = "Auto Start";
  static const String idleTime = "Idle Time";

  static const String skip = 'skip';
  static const String name = 'Name';
  static const String nameError1 = 'Please enter your name ';
  static const String nameError2 = 'Please enter at least 3 characters ';
  static const String confirmError = 'Password not confirm';

  static const String search = "Search or Add New Exercise";

  static const String popularDoctor = "Popular Doctor";
  static const String featureDoctor = "Feature Doctor";
  static const String seeAll = "See all >>";
  static const String haveAccount = 'Have an account? Log in';
  static const String enterYourEmailVerification =
      'Enter your email for the verification process,we will send 4 digits code to your email.';
  static const String enter4Digits = 'Enter 4 Digits Code';
  static const String enter4digitsSubTitle =
      'Enter the 4 digits code that you received on your email.';
  static const String Continue = 'Continue';
  static const String doctor = 'Are you a doctor ?';
  static const String addProfilePicture = 'Profile Picture';

  static const String updatePassword = 'Update Password';

  static const String success = "Success";
  static const String reLogin = 'already member? sign in ';
  static const String loading = 'loading';
  static const String ok = 'OK';
  static const String retry = 'retry again';
  static const profilePicture = "upload_profile_picture";
  static const photoGallery = "Photo From Galley";
  static const photoCamera = "Photo From Camera";
  static const home = 'Home';
  static const notification = 'Notification';
  static const setting = 'Setting';
  static const services = 'Services';
  static const stores = 'Stores';

  static const String badRequestError = "Email has already been used";
  static const String cancelError = "cancelError";
  static const String loginErrorRequired = "loginErrorRequired";
  static const String connectionErrorMessage = 'Connection error message';
  static const String noContent = "no_content";
  static const String forbiddenError = "forbidden_error";
  static const String unauthorizedError = "unauthorized_error";
  static const String notFoundError = "not_found_error";
  static const String conflictError = "conflict_error";
  static const String internalServerError = "internal_server_error";
  static const String unknownError = "unknown_error";
  static const String timeoutError = "timeout_error";
  static const String defaultError = "هناك حظا ما";
  static const String cacheError = "لا توجد بيانات";
  static const String noInternetError = "No Internet";

  static const String privacyTitle = "Doctor Hunt Apps Privacy Policy";
  static const String privacySubTitle1 =
      "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable. It is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more ";
  static const String privacySubTitle2 =
      "The standard chunk of lorem Ipsum used since  1500s is reproduced below for those interested.";
  static const String privacySubTitle3 =
      "Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum. The point of using.";
  static const String privacySubTitle4 =
      "The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.";
  static const String privacySubTitle5 =
      "It is a long established fact that reader distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established.";
}

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
  static const String enterEmail = 'Please enter an email address';
  static const String rPSMessage =
      'Send you a message to set or reset your new password';
  static const String refresh = 'refresh';
  static const String otpSuccessMessage = 'OTP Verified Successfully!';
  static const String otpErrorMessage = 'OTP Verification Failed!';
  static const String passwordAtLeast8Char =
      'Password must be at least 8 characters long.';
  static const String passwordAtLeast1Uppercase =
      'Password must contain at least one uppercase letter.';
  static const String passwordAtLeast1Lowercase =
      'Password must contain at least one lowercase letter.';
  static const String passwordAtLeast1Number =
      'Password must contain at least one number.';
  static const String passwordAtLeast1SpecialChar =
      'Password must contain at least one special character.';
  static const String emailError = 'Please enter a valid email address';
  static const String fieldRequired = 'This field is required.';
  static const String nameError =
      'Please enter a valid name (letters and spaces only)';
  static const String soldFor = 'Sold for: ';
  static const String soldOut = 'Sold out';
  static const String bid = 'Bid';
  static const String nowBid = 'Now Bid:';
  static const String enrollNow = 'Enroll Now';
  static const String placeBid = 'Place a bid';

  static const String trendingBids = 'Trending Bids';
  static const String futureBids = 'Future Bids';
  static const String bidsWorkNow = 'Bids Work Now';
  static const String endedBids = 'Ended Bids';
  static const productName = 'Product Name';
  static const String description = 'Description';
  static const String startingPrice = 'Starting price';
  static const String expectedPrice = 'Expected price';
  static const String location = 'Location';
  static const String startDate = 'Start date';
  static const String arrivalDate = 'Arrival date';
  static const String periodOfBids = 'Period of bids';
  static const String privacyPolicy = 'Privacy and Policy ';
  static const String auctionRules = 'Auction Rules and Guidelines:';
static const String auctionRulesDescription = """
1. Eligibility to Bid
All users must be registered and verified on the website to place a bid.
Users must be at least 18 years old to participate in auctions.


2. Bidding Process
Each auction has a specified start time and end time. No bids will be accepted before the start time or after the end time.
All bids are legally binding. By placing a bid, you are committing to purchase the item if you win the auction.
Bids cannot be withdrawn or canceled once submitted.


3. Automatic Bidding (if applicable)
Users can set up automatic bidding to place bids on their behalf up to a maximum amount.
Automatic bids will increase incrementally to maintain the user’s position as the highest bidder until the maximum amount is reached.


4. Bid Increments
Bids must follow the minimum increment amount specified for each auction. Bids below this increment will not be accepted.


5. Winning the Auction
The highest bidder at the end of the auction will be declared the winner.
If a user wins the auction, they will receive an email confirmation with instructions on how to complete the purchase.
The winning bid amount is final, and the winner is obligated to pay this amount.


6. Payment Terms
All winning bids must be paid in full within [specify time frame, e.g., 48 hours] of the auction ending.
Failure to make the payment within the specified period may result in the cancellation of the winning bid, and the item may be offered to the next highest bidder or relisted.
Accepted payment methods are [list payment methods].


7. Non-Payment and Penalties
If a winning bidder fails to make payment within the specified time, they may be subject to penalties, including account suspension or permanent banning from the platform.
Repeated instances of non-payment may result in legal action or additional penalties.


8. Auction Extension (if applicable)
If a bid is placed within the last few minutes of the auction, the auction may be automatically extended to allow fair competition. The exact extension period will be stated in the auction details.


9. Returns and Refunds
All sales are final. No returns or refunds will be accepted unless explicitly stated in the auction description or due to specific circumstances (e.g., item not as described).
Any disputes regarding the condition of the item or delivery must be addressed within [specify time frame, e.g., 7 days] of receiving the item.


10. User Conduct and Fair Play
Users must conduct themselves professionally and refrain from any fraudulent activity.
Collusion, bid manipulation, or attempting to artificially influence auction results is strictly prohibited and will result in account suspension.


11. Disputes and Resolution
In the event of a dispute regarding a bid or auction result, the platform’s decision will be final.
Users are encouraged to reach out to customer support for any issues, and the platform will work to resolve disputes fairly.


12. Disclaimer of Liability
The platform is not responsible for any loss, damage, or claim resulting from the use of the auction platform.
All items are sold "as is" unless otherwise stated, and the platform makes no warranties regarding the condition, authenticity, or value of items listed for auction.


13. Changes to Auction Rules
The platform reserves the right to change these rules at any time. Users will be notified of any significant changes, and it is the responsibility of the users to review the rules before participating in any auction.
""";
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
  static const String privacyAndPolicyDescription = """
Introduction of the usage agreement:
      
      
Our online store welcomes you and informs you that you will find below the terms and Conditions governing your use of this store and all the legal consequences that result from your use of the store's online services via this electronic platform, as the use of any person to the store, whether he is a consumer of the store's service or product or otherwise, this is and Ben. This agreement is considered valid and effective as soon as you approve it and start registering with the store under Article X of the Saudi electronic transactions system          
      
Article I-introduction and definitions:
      
The above preface is an integral part of this Agreement, and below you will find the semantics and definitions of the main terms consumed in this agreement :          
      
1- (store) this definition includes all forms of the online store, whether it is an electronic application, a website on the web, or a commercial store.

2- (consumer) a person who deals in electronic commerce with a desire to obtain the products or services provided by the store through its electronic platform.
  
3- (agreement) this term means the terms and conditions of this agreement, which govern and regulate the relationship between the parties to this agreement.
  
Article II-legal capacity of the consumer:

1- the consumer acknowledges that he has a legal capacity considered legitimate and a system for dealing with the store, or that he is at least eighteen years old.

2- the consumer agrees that in case of violation of this article, he shall bear the consequences of such violation before third parties.

Article III-nature of an obligation:

1- the store's obligation to consumers or consumers is to provide ( service or product).

2- the store may provide other services such as after-sales services or other related services, due to the nature and type ( service or product ) required by the consumer.

Article IV - controls on the use of :

1- the consumer is obliged to use the store's electronic platform in accordance with public morals and regulations in force in the kingdom of Saudi Arabia.

2- the consumer is obliged when buying a service or product from this store not to use this service or product in violation of public morals and the regulations in force in the kingdom of Saudi Arabia.

Article V. accounts and registration obligations:

Immediately after applying for membership in this store as a user, you are obliged to disclose specific information and choose a username and a secret password to use when accessing the store's services. By doing so, you have agreed to:

1- you are responsible for maintaining the confidentiality of your account information and password confidentiality, and you hereby agree to inform this store immediately of any unauthorized use of your account information with the store or any other breach of your confidential information. 

2- in no case will the store be responsible for any loss that may be inflicted on you directly or indirectly morally or materially as a result of disclosing consumer name information or login password.

3- you are committed to using your account or membership with the store yourself, as you are fully responsible for it, and if someone else uses it, this is a presumption that you have authorized him to use the store in your name and for your account.

4- you are committed when using the store to use it with all seriousness and credibility.

5- you are obliged to disclose real, correct, up-to-date, complete and legal information about yourself as required during registration with the store and are obliged to update your data in case of changing it in reality or in case of need to do so.

6- our store is committed to treating your personal information and contact addresses with strict confidentiality.

7- if the store finds out that you have disclosed information that is not true, incorrect, current, incomplete, illegal or contrary to what is stated in the usage agreement, the store has the right to suspend, freeze or cancel your membership or your store and account on the platform, without prejudice to the store's other rights and legitimate means to recover their rights and protect other consumers.

8- in case of non-compliance with any of the above, the store management has the right to suspend or cancel your store or membership or block you from accessing the store's services again.


Article VI-electronic communications and official means of communication:

1- the parties to this Agreement agree that communication is carried out by e-mail registered in the platform.

2- the consumer agrees that all agreements, advertisements, data and other communications that are provided electronically take the place of their written counterparts, which is a stand-alone argument, in meeting legal and legitimate needs.  

3- the consumer agrees to the possibility of communicating with him and informing him of any provisions related to this agreement or related to dealing with him through the store management broadcasting public messages that will be sent to all consumers or to specific users of the store

Article VII-amendments to the usage agreement and fees:

1- in case of cancellation of any incoming material or clause contained in this agreement or that there is any incoming material or any clause contained in this agreement is no longer in force, such an order does not cancel the validity of the rest of the materials, clauses, rules and provisions contained in this Agreement and remain valid until further notice from the store management  

2- this agreement - which is amended from time to time as the case may be-constitutes the mechanism of action, understanding and agreement between (the consumer) and( the store) 

3- the store may impose fees on some consumers, depending on the offers, products or services they request, or the fees or taxes imposed by the state on the nature of the product or service.

4- the store reserves the right to add, increase, reduce or deduct any fees or expenses under the articles, terms and conditions of the use agreement, on any of the consumers, whatever the reason for their registration.

Article VIII-payment and payment services for stores in the store

1- the store provides through its partners a payment system and payment in the store can be done completely online through the payment options available on the store or through any payment method provided by the store from time to time.

2- the store is obliged to determine the price of the service or product that it offers in its store according to the recognized market value.

3- the store is obliged to provide invoices, receipt documents and receipt documents for all amounts and profits that arise in its store, and is obliged to give the consumer an invoice for his purchase of a service or product 

4- the store shall be obliged to provide the accounting specifications recognized in its electronic store, in accordance with the provisions of this Agreement, and for the legal, economic, commercial and organizational interests in this organization.

Article IX-intellectual property:

1- the intellectual property rights of the store are fully owned by the store, whether owned by them before the establishment of this electronic platform or after its establishment.

2- the consumer or consumer respects the intellectual property rights of the store, including the name of the store itself, and the words, logos and other symbols of the store or displayed on it, as each right followed by the name of the store are fully intellectual property rights of the store

Article X - responsibility of the store:

1- the store is committed to conduct its business through this electronic platform in a regular manner and in accordance with the regulations in force in the kingdom of Saudi Arabia, and in accordance with the provisions of this agreement.

2- the store shall not bear any claims arising from errors or negligence, whether caused directly, indirectly, accidentally, by the consumer or by a third party such as shipping companies.

3- the name of the store, its employees, owners and their representatives are obliged to ensure that the product or service is sound, legitimate and authorized in accordance with the laws and regulations of the kingdom of Saudi Arabia and is used for legitimate purposes.  

Article XI - restriction of access or membership:

The store can suspend or cancel the consumer's membership or restrict the consumer's access to the platform's services at any time, without warning, for any reason, and without limitation.

Article XII. applicable law or regulation:  

This usage agreement is governed and formulated in accordance with the laws, regulations and legislations in force and in force in the kingdom of Saudi Arabia, and is fully and completely subject to the regulations in force with the authorities in the kingdom of Saudi Arabia.


Article XIII. general provisions: 
  
In the event of cancellation of any incoming material or clause contained in this Use Agreement or that there is any incoming material or any clause contained in the use agreement is no longer effective, such an order does not cancel the validity of the rest of the materials, clauses and provisions contained in the Use Agreement and remain valid until further notice from the store management

This usage agreement - which may be amended from time to time as the case may be-constitutes the usage agreement, the mechanism of work, understanding, Agreement and contract between the store and the consumer, and both parties to this Agreement agree to bear in mind the following:

1- the Arabic language shall be the applicable language when interpreting the provisions of this agreement, or when translating them into another language.

2- all prices displayed on the services or products of the store may be amended from time to time.

3- the promotional or marketing offers that the store may place are temporary offers, as the store has the right to modify these promotional or marketing offers at any time or stop them.

4- the parties to this agreement are obliged to deal with each other in a manner that does not violate the Sharia rules, regulations and applicable laws related to the nature of dealing between the store and the consumer.

5- this Use Agreement is canceled only by a decision issued by the store management""";
  static const String privacyAndPolicyDescription2 = """
📌 **Introduction to the Terms of Use**:

Welcome to our online store! Below, you will find the terms and conditions governing your use of this store, along with all the legal implications of using its online services through this platform.  
By accessing or registering with the store, whether as a consumer of its services and products or otherwise, you agree to these terms, which take effect immediately as per **Article X** of the Saudi Electronic Transactions System.

---

## 📜 **Article I - Introduction and Definitions**:
🔹 **(Store)**: This term includes all forms of the online store, whether it is an electronic application, a website, or a commercial platform.  
🔹 **(Consumer)**: A person who engages in electronic commerce with the intent to obtain products or services provided by the store.  
🔹 **(Agreement)**: Refers to the terms and conditions that govern the relationship between the consumer and the store.

---

## ⚖ **Article II - Legal Capacity of the Consumer**:
✅ The consumer acknowledges that they have the **legal capacity** to engage with the store or that they are at least **18 years old**.  
❌ If this requirement is violated, the consumer bears full responsibility for any resulting consequences.

---

## 🎯 **Article III - Nature of Obligation**:
✔ The store is committed to providing **products or services** as advertised.  
✔ Additional services, such as after-sales support, may be provided based on the product or service type.

---

## 📌 **Article IV - Usage Regulations**:
🛑 The consumer must use the store's platform in compliance with **public morals and applicable laws in Saudi Arabia**.  
🛑 Services and products purchased from the store **must not** be used in ways that violate public morals or national regulations.

---

## 🔐 **Article V - Accounts and Registration Obligations**:
1️⃣ Consumers must provide **accurate, complete, and up-to-date** information when registering.  
2️⃣ Consumers are **responsible for maintaining account confidentiality** and must notify the store immediately of any unauthorized access.  
3️⃣ The store **will not be liable** for losses resulting from the disclosure of account credentials.  
4️⃣ The store **reserves the right** to suspend or cancel accounts that violate these terms.

---

## 📩 **Article VI - Electronic Communications**:
✔ All official communications will be conducted via **email registered on the platform**.  
✔ Consumers agree that electronic notifications and agreements **hold the same legal weight as written documents**.

---

## 📝 **Article VII - Amendments to the Agreement**:
✔ The store **reserves the right** to modify these terms at any time without prior notice.  
✔ Any modifications will **not affect the validity** of the remaining terms.

---

## 💳 **Article VIII - Payment and Financial Services**:
✔ The store provides **various online payment methods** through its partners.  
✔ Consumers will receive **official invoices and receipts** for all purchases.  
✔ The store will **adhere to standard accounting practices** in compliance with applicable laws.

---

## 🚀 **Article IX - Intellectual Property**:
✔ All **intellectual property rights** related to the store (including the name, logo, trademarks, and content) are fully owned by the store.  
✔ Unauthorized use, reproduction, or modification of any store-related intellectual property is strictly prohibited.

---

## 🛠 **Article X - Store Responsibility**:
✔ The store operates in accordance with the **laws of Saudi Arabia** and within the terms of this agreement.  
❌ The store **is not responsible** for any damages or claims resulting from errors caused by **third-party service providers** (e.g., shipping companies).  
✔ The store and its representatives ensure that all **products and services comply with local laws** and **are intended for lawful purposes**.

---

## ❌ **Article XI - Account Restriction or Termination**:
🛑 The store may **suspend or cancel consumer accounts** at any time, without prior notice, and for any reason.

---

## ⚖ **Article XII - Governing Law**:
✔ This agreement is governed and interpreted in accordance with the **laws and regulations of Saudi Arabia**.

---

## 🔍 **Article XIII - General Provisions**:
✔ The **Arabic language** shall be the official language for interpreting this agreement, and any translations are for reference only.  
✔ Prices of services and products **may change** at any time.  
✔ Promotional and marketing offers are **temporary**, and the store has the right to modify or discontinue them at any time.  
✔ Both parties **must comply** with Islamic laws and Saudi regulations governing consumer-business interactions.  
✔ This agreement **can only be terminated** by a decision issued by the store management.

""";
}

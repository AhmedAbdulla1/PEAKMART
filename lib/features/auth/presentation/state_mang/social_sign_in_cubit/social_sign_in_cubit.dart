import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/string_manager.dart';

part 'social_sign_in_state.dart';

class SignInWithSocialCubit extends Cubit<SignInWithSocialState> {
  SignInWithSocialCubit() : super(SignInWithSocialInitialState());

  final AppPreferences appPreferences = instance<AppPreferences>();
  final GoogleSignIn googleSignIn = GoogleSignIn(); 

  Future<void> signInWithGoogle() async {
    emit(SignInWithSocialLoadingState());
    try {
      await googleSignIn.signOut(); 
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        log("User cancelled the sign-in.");
        throw GoogleSignInAccountException(AppStrings.googleSignInCancelled);
      }

      log("Selected Account Email: ${googleUser.email}");

      await _loginWithGoogleSuccessfully(googleUser);
      appPreferences.setPressKeyLoginScreen();
      appPreferences.setUserId(googleUser.id);

      emit(SignInWithSocialSuccessState());
    } on FirebaseAuthException catch (e) {
      log("Firebase Auth Error: ${e.message}");
      emit(SignInWithSocialFailureState(
        errorMessage: _handleFirebaseAuthError(e),
      ));
    } on PlatformException {
      log("Platform Exception: ${AppStrings.networkError}");
      emit(SignInWithSocialFailureState(
        errorMessage: AppStrings.networkError,
      ));
    } on GoogleSignInAccountException catch (e) {
      log("Google Sign-In Error: ${e.message}");
      emit(SignInWithSocialFailureState(
        errorMessage: AppStrings.googleSignInCancelled,
      ));
    } on Exception catch (e) {
      log("Unexpected Error: ${e.toString()}");
      emit(SignInWithSocialFailureState(
        errorMessage: "${AppStrings.unexpectedError} ${e.toString()}",
      ));
    }
  }

  Future<UserCredential> _loginWithGoogleSuccessfully(GoogleSignInAccount googleUser) async {
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      throw Exception(AppStrings.googleAuthFailed);
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        return AppStrings.accountExistsWithDifferentCredential;
      case 'invalid-credential':
        return AppStrings.invalidCredential;
      case 'operation-not-allowed':
        return AppStrings.operationNotAllowed;
      case 'user-disabled':
        return AppStrings.userDisabled;
      case 'user-not-found':
        return AppStrings.userNotFound;
      case 'wrong-password':
        return AppStrings.wrongPassword;
      case 'network-request-failed':
        return AppStrings.networkError;
      default:
        return "${AppStrings.authError} ${e.message}";
    }
  }
}

class GoogleSignInAccountException implements Exception {
  final String message;
  GoogleSignInAccountException(this.message);
}

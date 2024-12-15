import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logger/logger.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final Logger _logger = Logger();

  SignUpCubit() : super(SignUpInitialState());

  Future<void> userSignUp(
      {required String email, required String password}) async {
    emit(SignUpLoadingState());
    // try {
    //   await _auth.createUserWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   _logger.i(
    //       "User signed up successfully with email: $email and password: $password");
    //   emit(SignUpSuccessState());
    // } on FirebaseAuthException catch (e) {
    //   emit(_handleFirebaseAuthError(e));
    // } catch (e) {
    //   _logger.e("An unexpected error occurred: ${e.toString()}");
    //   emit(SignUpFailureState(errorMessage: 'An unexpected error occurred.'));
    // }
  }

  // SignUpFailureState _handleFirebaseAuthError(FirebaseAuthException e) {
  //   switch (e.code) {
  //     case 'weak-password':
  //       _logger.w('The password provided is too weak.');
  //       return SignUpFailureState(
  //           errorMessage: 'The password provided is too weak.');
  //     case 'email-already-in-use':
  //       _logger.w('The account already exists for that email.');
  //       return SignUpFailureState(
  //           errorMessage: 'The account already exists for that email.');
  //     default:
  //       _logger.e('Error code: ${e.code}');
  //       return SignUpFailureState(errorMessage: '${e.code}.');
  //   }
  // }
}

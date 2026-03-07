import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';
  

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  register({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = auth.currentUser!;
      emit(AuthAuthenticated(user: user,authType: AuthType.signUp));
    } on FirebaseAuthException catch (e) {
      String? message;
      if (e.code == 'email-already-in-use') {
        message = 'This email is already registered. Please login.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid. Please check and try again.';
      } else if (e.code == 'weak-password') {
        message = 'Your password is too weak. Use at least 6 characters.';
      } else {
        message = 'Something went wrong. Please try again later.';
      }
      emit(AuthError(message: message));
    } on Exception catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
  signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final user = auth.currentUser!;
      emit(AuthAuthenticated(user: user,authType: AuthType.signIn));
    } on FirebaseAuthException catch (e) {
      String? message;
      if (e.code == 'wrong-password') {
        message = 'Incorrect password. Please try again';
      } else if (e.code == 'wrong-password' ||
          e.code == 'user-not-found' ||
          e.code == 'invalid-credential') {
        message = 'Incorrect email or password';
      }
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        message = 'Incorrect email or password';
      } else if (e.code == 'network-request-failed') {
        message = 'Check your internet connection';
      }
      emit(AuthError(message: message!));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}

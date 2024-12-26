import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> authStateChague() => _firebaseAuth.authStateChanges();

  String getUserEmail() => _firebaseAuth.currentUser?.email ?? 'User';

  Future<UserCredential?> signWithApple() async {
    try {
      final appleCredential =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);

      final oAuthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      return await _firebaseAuth.signInWithCredential(oAuthCredential);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (kDebugMode) {
        print('Apple Authorization Error: ${e.code}');
        print('Details: ${e.message}');
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error desconocido al iniciar sesión con Apple: $e');
      }
      return null;
    }
  }

  Future signOutApple() async => await _firebaseAuth.signOut();

  //Metodo para iniciar sesion con Google (Gmail)

  Future<UserCredential?> signWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        signInOption: SignInOption.standard,
        scopes: [
          'email', // Permiso para obtener el correo electrónico
          'profile',
        ],
      );

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      //Se agregan la informacion a firebase console.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      ///Se regresan las credenciales para su posterior uso
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      if (kDebugMode) {
        print("Error en el inicio de sesión con Gmail: $error");
      }
      return null;
    }
  }

  //Metodo para iniciar sesion o registrarse con Facebook.
}

// ignore_for_file: avoid_print, duplicate_ignore

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:instagram_clone_course_rtk/state/auth/constants/constants.dart';
import 'package:instagram_clone_course_rtk/state/auth/models/auth_result.dart';
import 'package:instagram_clone_course_rtk/state/posts/typedefs/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticator {

  const Authenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedin => userId != null;
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  // Future<AuthResult> loginWithFacebook() async {
  //   final loginResult = await FacebookAuth.instance.login();
  //   final token = loginResult.accessToken!.token;
  //   if (token == null) {
  //     return AuthResult.aborted;
  //   }
  //   final OAuthCredential = FacebookAuthProvider.credential(token);

  //   try {
  //     await FirebaseAuth.instance.signInWithCredential(OAuthCredential);
  //     print('Successful Facebook login'); // Add this print statement
  //     return AuthResult.success;
  //   } on FirebaseAuthException catch (e) {
  //     final email = e.email;
  //     final credential = e.credential;
  //     if (e.code == Constants.accountExistsWithDifferentCredential &&
  //         email != null &&
  //         credential != null) {
  //       final providers =
  //           await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  //       if (providers.contains(Constants.googleCom)) {
  //         await loginWithGoogle();
  //         FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
  //       }
  //       return AuthResult.success;
  //     }
  //     return AuthResult.failure;
  //   }
  // }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            '770111659996-f8mkkkf3hjsv6n8617hnfoc4o91eockb.apps.googleusercontent.com',
        scopes: [
          Constants.emailScope,
        ]);
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    // ignore: non_constant_identifier_names
    final OAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(OAuthCredential);
      // ignore: avoid_print
      print('Successful Google login'); // Add this print statement
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  // Future<UserCredential> signInWithGitHub() async {
//   // Create a new provider
//   GithubAuthProvider githubProvider = GithubAuthProvider();

//   return await FirebaseAuth.instance.signInWithProvider(githubProvider);
// }

// Future<UserCredential> signInWithGitHub() async {
//   // Create a new provider
//   GithubAuthProvider githubProvider = GithubAuthProvider();

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithPopup(githubProvider);

//   // Or use signInWithRedirect
//   // return await FirebaseAuth.instance.signInWithRedirect(githubProvider);
// }

// Future<UserCredential> signInWithGitHub() async {
//   GithubAuthProvider githubProvider = GithubAuthProvider();
//   return await FirebaseAuth.instance.signInWithPopup(githubProvider);
// }

Future<AuthResult> signInWithGitHub() async {
    final GithubAuthProvider githubProvider = GithubAuthProvider();

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(githubProvider);

      if (userCredential.user != null) {
        print('Successful GitHub login');
        return AuthResult.success;
      } else {
        return AuthResult.aborted;
      }
    } catch (e) {
      print('GitHub sign in failed: $e');
      return AuthResult.failure;
    }
}


}

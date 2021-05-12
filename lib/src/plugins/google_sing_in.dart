import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSingIn = GoogleSignIn();

Future<UserCredential> signInWithGoogle() async {
  if (!kIsWeb) {
    final GoogleSignInAccount googleUser = await googleSingIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } else {
    GoogleAuthProvider authProvider = GoogleAuthProvider();
    final usuario = await FirebaseAuth.instance.signInWithPopup(authProvider);
    return usuario;
  }
}

Future<void> googleLogOut() async {
  await googleSingIn.signOut();
  await FirebaseAuth.instance.signOut();
}

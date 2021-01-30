import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<UserCredential> signInWithFacebook() async {
  final result = await FacebookAuth.instance.login();

  final FacebookAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.token);

  return await FirebaseAuth.instance
      .signInWithCredential(facebookAuthCredential);
}

Future<void> facebookLogOut() async {
  try {
    await FacebookAuth.instance.logOut();
  } catch (e) {
    print(e);
  }
}

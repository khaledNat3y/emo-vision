import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  FirebaseAuth get _auth => FirebaseAuth.instance;
  static bool isInitialized = false;

  Future<void> _initSignIn() async {
    if (!isInitialized) {
      await googleSignIn.initialize(
        serverClientId:
            "911321786473-863rtkr9s7llukra3fq7lo6g1j6ovvmg.apps.googleusercontent.com",
      );
      isInitialized = true;
    }
  }

   Future<UserCredential> signInWithGoogle() async {
    await _initSignIn();

    final GoogleSignInAccount account = await googleSignIn.authenticate();

    if (account == null) {
      throw FirebaseAuthException(
        code: "SIGNIN ABORTED BY USER",
        message: "Signin Incomplete because user Exited",
      );
    }

    final idToken = account.authentication.idToken;
    final authClient = account.authorizationClient;

    GoogleSignInClientAuthorization? auth = await authClient
        .authorizationForScopes(['email', 'profile']);

    final accessToken = auth?.accessToken;

    if (accessToken == null) {
      final auth2 = await authClient.authorizationForScopes([
        'email',
        'profile',
      ]);
      if (auth2?.accessToken == null) {
        throw FirebaseAuthException(
          code: "No Access Token",
          message: "Fail to Retrive Access Token",
        );
      }
      auth = auth2;
    }

    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: accessToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }
}

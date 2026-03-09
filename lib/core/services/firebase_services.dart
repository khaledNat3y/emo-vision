import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/firebase_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore firestoreDatabase = FirebaseFirestore.instance;
  bool isInitialize = false;
  Future<void> initSignIn() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(
        serverClientId:
            '911321786473-863rtkr9s7llukra3fq7lo6g1j6ovvmg.apps.googleusercontent.com',
      );
    isInitialize = true;
    }
  }

  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      await initSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes(['email', 'profile']);
      final accessToken = authorization?.accessToken;
      if (accessToken == null) {
        final authorization2 = await authorizationClient.authorizationForScopes(
          ['email', 'profile'],
        );
        if (authorization2?.accessToken == null) {
          throw FirebaseAuthException(code: "error", message: "error");
        }
        authorization = authorization2;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        final userDoc = firestoreDatabase
            .collection(FirebaseConstants.usersCollection)
            .doc(user.uid);
        final docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set(UserModel(
            createdAt: FieldValue.serverTimestamp(),
            uid: user.uid,
            email: user.email ?? '',
            name: user.displayName ?? '',
            photoURL: user.photoURL ?? '',
            provider: 'google',
          ).toJson());
        }
      }
      return userCredential;
    } catch (e) {
      Logger.error('Error: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      Logger.error('Error signing out: $e');
      rethrow;
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
  UserModel? getCurrentUserInfo() {
    return _auth.currentUser != null
        ? UserModel(
            uid: _auth.currentUser!.uid,
            name: _auth.currentUser!.displayName ?? '',
            email: _auth.currentUser!.email ?? '',
            photoURL: _auth.currentUser!.photoURL ?? '',
            provider: 'google',
            createdAt: FieldValue.serverTimestamp(),
          )
        : null;
  }
}

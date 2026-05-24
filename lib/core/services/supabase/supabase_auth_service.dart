import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final SupabaseClient client = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      await _storeSession(response.session);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );
      await _storeSession(response.session);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final result = await client.auth.signInWithOAuth(OAuthProvider.google);
      await _storeSession(client.auth.currentSession);
      return true;
    } catch (e) {
      Logger.error('Google sign-in failed: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    await client.auth.signOut();
    await SharedPrefHelper.removeSecuredString(
      CacheConstants.supabaseAccessToken,
    );
    await SharedPrefHelper.removeData(CacheConstants.userEmail);
    await SharedPrefHelper.removeData(CacheConstants.userName);
    await SharedPrefHelper.removeData(CacheConstants.userPhotoUrl);
    Logger.debug('Signed out from Supabase');
  }

  User? getCurrentUser() {
    return client.auth.currentUser;
  }

  Future<String?> getAccessToken() async {
    final session = client.auth.currentSession;
    if (session != null) {
      if (session.isExpired) {
        try {
          final refreshed = await client.auth.refreshSession();
          final newToken = refreshed.session?.accessToken;
          if (newToken != null) {
            await SharedPrefHelper.setSecuredString(
              CacheConstants.supabaseAccessToken,
              newToken,
            );
            return newToken;
          }
        } catch (e) {
          Logger.error('Token refresh failed: $e');
        }
      }
      return session.accessToken;
    }
    return await SharedPrefHelper.getSecuredString(
      CacheConstants.supabaseAccessToken,
    );
  }

  bool isSignedIn() {
    return client.auth.currentUser != null;
  }

  Future<void> resetPasswordForEmail(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  Future<void> _storeSession(Session? session) async {
    if (session != null) {
      await SharedPrefHelper.setSecuredString(
        CacheConstants.supabaseAccessToken,
        session.accessToken,
      );
    }
  }
}

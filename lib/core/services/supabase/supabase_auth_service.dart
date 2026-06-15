import 'package:facial_emotional_detection_graduation_project/core/constant/app_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final SupabaseClient client = Supabase.instance.client;

  // final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  bool _initialized = false;

  // Future<void> initGoogle() async {
  //   if (!_initialized) {
  //     await googleSignIn.initialize(
  //       clientId:
  //           '439901524950-9k6q5ahqnvs0h23jont8ptmoi7phm7ok.apps.googleusercontent.com',
  //       serverClientId:
  //           '439901524950-5g7bql784m36j66pjl5vat3phqbjtdi6.apps.googleusercontent.com',
  //     );
  //     _initialized = true;
  //   }
  // }

  // Sign in with email and password
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

  // Sign up with email and password
  Future<AuthResponse> signUpWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signUp(
        data: {'full_name': '$firstName $lastName'},
        email: email,
        password: password,
        emailRedirectTo: AppConstants.emailVerifiedDeepLink,
      );
      // 'https://emovision.dev/email-verified'
      await _storeSession(response.session);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Google
  Future<AuthResponse> signInWithGoogle() async {
    const webClientId =
        '439901524950-5g7bql784m36j66pjl5vat3phqbjtdi6.apps.googleusercontent.com';

    final scopes = ['email', 'profile'];
    final googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize(serverClientId: webClientId);

    // Try silent auth first, fall back to interactive
    GoogleSignInAccount? googleUser = await googleSignIn
        .attemptLightweightAuthentication();

    googleUser ??= await googleSignIn.authenticate();

    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
        await googleUser.authorizationClient.authorizeScopes(scopes);

    final idToken = googleUser.authentication.idToken;

    if (idToken == null) {
      throw AuthException('No ID Token found.');
    }

    final response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );

    if (response.session != null) {
      await _storeSession(response.session);
    }
    if (response.user != null) {
      await _saveUser(response.user!);
    }

    return response;
  }

  // Sign out
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

  // Delete account
  Future<void> deleteAccount() async {
    try {
      final user = client.auth.currentUser;
      if (user == null) {
        throw const AuthException('No authenticated user found.');
      }

      // 1. Delete user data from your users table first
      await client.from('users').delete().eq('id', user.id);

      // 2. Delete the auth user via Supabase Edge Function
      // (Supabase doesn't allow client-side auth deletion directly)
      await client.functions.invoke('delete-user', body: {'user_id': user.id});

      // 3. Clear local session & cached data
      await client.auth.signOut();
      await SharedPrefHelper.removeSecuredString(
        CacheConstants.supabaseAccessToken,
      );
      await SharedPrefHelper.removeData(CacheConstants.userEmail);
      await SharedPrefHelper.removeData(CacheConstants.userName);
      await SharedPrefHelper.removeData(CacheConstants.userPhotoUrl);
      await SharedPrefHelper.removeData(CacheConstants.isUserAuthenticated);

      Logger.debug('Account deleted successfully');
    } catch (e) {
      Logger.error('Account deletion failed: $e');
      rethrow;
    }
  }

  User? getCurrentUser() {
    return client.auth.currentUser;
  }

  // Update password
  Future<void> updatePassword(String newPassword) async {
    await client.auth.updateUser(UserAttributes(password: newPassword));
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
    await client.auth.resetPasswordForEmail(
      email,
      redirectTo: AppConstants.resetPasswordDeepLink,
    );
    // 'https://emovision.dev/update-password'
  }

  Future<void> _storeSession(Session? session) async {
    if (session != null) {
      await SharedPrefHelper.setSecuredString(
        CacheConstants.supabaseAccessToken,
        session.accessToken,
      );
    }
  }

  Future<void> _saveUser(User user) async {
    await client.from('users').upsert({
      'id': user.id,
      'email': user.email,
      'name': user.userMetadata?['full_name'],
      'photo_url': user.userMetadata?['avatar_url'],
      'provider': user.appMetadata['provider'] ?? 'unknown',
    });

    await SharedPrefHelper.setData(CacheConstants.userEmail, user.email ?? '');
    await SharedPrefHelper.setData(
      CacheConstants.userName,
      user.userMetadata?['full_name'] ?? '',
    );
    await SharedPrefHelper.setData(
      CacheConstants.userPhotoUrl,
      user.userMetadata?['avatar_url'] ?? '',
    );
  }
}

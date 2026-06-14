import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepo {
  final SupabaseAuthService supabaseAuthService;

  AuthRepo(this.supabaseAuthService);

  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> signUpWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseAuthService.signUpWithEmailAndPassword(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> signInWithGoogle() async {
    try {
      final response = await supabaseAuthService.signInWithGoogle();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await supabaseAuthService.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      await supabaseAuthService.deleteAccount();
    } catch (e) {
      rethrow;
    }
  }

  User? getCurrentUser() {
    return supabaseAuthService.getCurrentUser();
  }

  Future<String?> getAccessToken() async {
    return supabaseAuthService.getAccessToken();
  }

  bool isSignedIn() {
    return supabaseAuthService.getCurrentUser() != null;
  }

  Future<void> resetPasswordForEmail(String email) async {
    await supabaseAuthService.resetPasswordForEmail(email);
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientHelper {
  static SupabaseClient? _client;

  static SupabaseClient get client {
    _client ??= SupabaseClient(
      'https://clnujoogeumhemytkdfg.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsbnVqb29nZXVtaGVteXRrZGZnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyNDEzMTcsImV4cCI6MjA5MDgxNzMxN30.Q6_0fUwCVUKDqhCSYf5k_Nsw4-2xFROjZuoN6BiCNSc',
    );
    return _client!;
  }

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://clnujoogeumhemytkdfg.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsbnVqb29nZXVtaGVteXRrZGZnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyNDEzMTcsImV4cCI6MjA5MDgxNzMxN30.Q6_0fUwCVUKDqhCSYf5k_Nsw4-2xFROjZuoN6BiCNSc',
      authOptions: FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
        pkceAsyncStorage: SharedPreferencesGotrueAsyncStorage(),
      ),
    );
  }
}

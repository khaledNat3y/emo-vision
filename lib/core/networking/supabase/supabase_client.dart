import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientHelper {
  static SupabaseClient? _client;

  static SupabaseClient get client {
    _client ??= SupabaseClient(
      'https://gdskgusceunagmpsoxzh.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdkc2tndXNjZXVuYWdtcHNveHpoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg1OTEwMTIsImV4cCI6MjA5NDE2NzAxMn0.1RuQOuAH7EvtLWAWQ18-Q1IbnRAMQX6iYZrv6LkgP0o',
    );
    return _client!;
  }

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://gdskgusceunagmpsoxzh.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdkc2tndXNjZXVuYWdtcHNveHpoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg1OTEwMTIsImV4cCI6MjA5NDE2NzAxMn0.1RuQOuAH7EvtLWAWQ18-Q1IbnRAMQX6iYZrv6LkgP0o',
      authOptions: FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
        pkceAsyncStorage: SharedPreferencesGotrueAsyncStorage(),
      ),
    );
  }
}

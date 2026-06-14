import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/user_model.dart';

class HomeRepo {
  final SupabaseAuthService supabaseService;

  HomeRepo(this.supabaseService);

  UserModel? getCurrentUserInfo() {
    final user = supabaseService.getCurrentUser();

    if (user == null) return null;

    return UserModel(
      uid: user.id,
      name: user.userMetadata?['full_name'] ?? '',
      email: user.email ?? '',
      photoURL: user.userMetadata?['avatar_url'] ?? '',
      provider: user.appMetadata['provider'] ?? '',
      createdAt: DateTime.now(),
    );
  }
}

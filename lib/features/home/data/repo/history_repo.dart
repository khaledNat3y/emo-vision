// lib/features/home/data/repos/history_repo.dart

import 'package:dartz/dartz.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/video_analysis.dart';

class HistoryRepo {
  final SupabaseAuthService _supabaseService;

  HistoryRepo(this._supabaseService);

  Future<Either<String, List<VideoAnalysis>>> fetchHistory() async {
    try {
      final userId = _supabaseService.client.auth.currentUser?.id;
      if (userId == null) {
        return const Left('User not authenticated');
      }

      final response = await _supabaseService.client
          .from('video_analyses')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final videos = (response as List)
          .map((e) => VideoAnalysis.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(videos);
    } catch (e) {
      Logger.error('fetchHistory failed: $e');
      return Left(e.toString());
    }
  }
}

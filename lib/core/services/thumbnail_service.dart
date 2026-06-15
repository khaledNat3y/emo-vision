import 'dart:io';
import 'dart:typed_data';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailService {
  final SupabaseAuthService _supabaseAuthService;

  ThumbnailService(this._supabaseAuthService);

  Future<String?> generateAndUpload({
    required String videoPath,
    required String userId,
    required String videoName,
  }) async {
    try {
      // 1. Generate thumbnail bytes from video
      final Uint8List? thumbnailBytes = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 640,
        quality: 75,
        timeMs: 1000, // grab frame at 1 second
      );

      if (thumbnailBytes == null) {
        Logger.error('Failed to generate thumbnail bytes');
        return null;
      }

      // 2. Save to temp file
      final tempDir = await getTemporaryDirectory();
      final thumbnailFileName =
          '${videoName.replaceAll('.mp4', '')}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final tempFile = File('${tempDir.path}/$thumbnailFileName');
      await tempFile.writeAsBytes(thumbnailBytes);

      // 3. Upload to Supabase Storage
      final storagePath = 'thumbnails/$userId/$thumbnailFileName';

      await _supabaseAuthService.client.storage
          .from('thumbnails')
          .upload(
            storagePath,
            tempFile,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );

      // 4. Get public URL
      final publicUrl = _supabaseAuthService.client.storage
          .from('thumbnails')
          .getPublicUrl(storagePath);

      // 5. Clean up temp file
      await tempFile.delete();

      Logger.debug('Thumbnail uploaded: $publicUrl');
      return publicUrl;
    } catch (e) {
      Logger.error('Thumbnail generation/upload failed: $e');
      return null; // don't fail the upload if thumbnail fails
    }
  }
}

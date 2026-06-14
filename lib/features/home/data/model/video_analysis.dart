// lib/features/home/data/models/video_analysis.dart

class VideoAnalysis {
  final String id;
  final String videoName;
  final String? thumbnailUrl;
  final String status;
  final double? engagementScore;
  final double? overallConfidence;
  final DateTime createdAt;

  const VideoAnalysis({
    required this.id,
    required this.videoName,
    this.thumbnailUrl,
    required this.status,
    this.engagementScore,
    this.overallConfidence,
    required this.createdAt,
  });

  factory VideoAnalysis.fromJson(Map<String, dynamic> json) => VideoAnalysis(
    id: json['id'] as String,
    videoName: json['video_name'] as String,
    thumbnailUrl: json['thumbnail_url'] as String?,
    status: json['status'] as String,
    engagementScore: (json['engagement_score'] as num?)?.toDouble(),
    overallConfidence: (json['overall_confidence'] as num?)?.toDouble(),
    createdAt: DateTime.parse(json['created_at'] as String),
  );
}

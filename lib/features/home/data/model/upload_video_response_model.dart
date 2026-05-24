class UploadVideoResponseModel {
  String? prediction;
  String? status;
  Metadata? metadata;
  List<TimelineData>? timelineData;
  num? overallScore;
  String? overallConfidence;
  bool? dbSaved;

  UploadVideoResponseModel({
    this.prediction,
    this.status,
    this.metadata,
    this.timelineData,
    this.overallScore,
    this.overallConfidence,
    this.dbSaved,
  });

  UploadVideoResponseModel.fromJson(Map<String, dynamic> json) {
    prediction = json['prediction'];
    status = json['status'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    if (json['timeline_data'] != null) {
      timelineData = <TimelineData>[];
      json['timeline_data'].forEach((v) {
        timelineData!.add(new TimelineData.fromJson(v));
      });
    }
    overallScore = json['overall_score'];
    overallConfidence = json['overall_confidence'];
    dbSaved = json['db_saved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prediction'] = prediction;
    data['status'] = status;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    if (timelineData != null) {
      data['timeline_data'] = timelineData!.map((v) => v.toJson()).toList();
    }
    data['overall_score'] = overallScore;
    data['overall_confidence'] = overallConfidence;
    data['db_saved'] = dbSaved;
    return data;
  }
}

class Metadata {
  int? totalFrames;
  num? durationSec;
  int? numChunks;

  Metadata({this.totalFrames, this.durationSec, this.numChunks});

  Metadata.fromJson(Map<String, dynamic> json) {
    totalFrames = json['total_frames'];
    durationSec = json['duration_sec']?.toDouble();
    numChunks = json['num_chunks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_frames'] = totalFrames;
    data['duration_sec'] = durationSec;
    data['num_chunks'] = numChunks;
    return data;
  }
}

class TimelineData {
  String? startTime;
  String? endTime;
  String? status;
  num? score;
  String? confidence;

  TimelineData({
    this.startTime,
    this.endTime,
    this.status,
    this.score,
    this.confidence,
  });

  TimelineData.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    score = json['score']?.toDouble();
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['score'] = score;
    data['confidence'] = confidence;
    return data;
  }
}

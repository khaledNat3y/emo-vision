class UploadVideoResponseModel {
  String? prediction;
  String? status;
  Metadata? metadata;

  UploadVideoResponseModel({this.prediction, this.status, this.metadata});

  UploadVideoResponseModel.fromJson(Map<String, dynamic> json) {
    prediction = json['prediction'];
    status = json['status'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
  }
}

class Metadata {
  int? totalFrames;

  Metadata({this.totalFrames});

  Metadata.fromJson(Map<String, dynamic> json) {
    totalFrames = json['total_frames'];
  }
}

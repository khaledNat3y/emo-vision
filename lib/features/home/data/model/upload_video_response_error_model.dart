class UploadVideoResponseErrorModel {
  List<Detail>? detail;

  UploadVideoResponseErrorModel({this.detail});

  UploadVideoResponseErrorModel.fromJson(Map<String, dynamic> json) {
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String? type;
  List<String>? loc;
  String? msg;
  Null input;

  Detail({this.type, this.loc, this.msg, this.input});

  Detail.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    loc = json['loc'].cast<String>();
    msg = json['msg'];
    input = json['input'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['loc'] = this.loc;
    data['msg'] = this.msg;
    data['input'] = this.input;
    return data;
  }
}

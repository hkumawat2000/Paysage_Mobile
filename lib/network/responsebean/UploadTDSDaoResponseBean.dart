import 'package:choice/widgets/WidgetCommon.dart';

import '../ModelWrapper.dart';

class UploadTDSResponseBean extends ModelWrapper<Message> {
  Message? message;

  UploadTDSResponseBean({this.message});

  UploadTDSResponseBean.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  int? status;
  String? message;
  UploadedData? data;

  Message({this.status, this.message, this.data});

  Message.fromJson(Map<String, dynamic> json) {
    printLog("JSONNS DATA ${json['data'].runtimeType}");
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UploadedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UploadedData {
  UploadedFile? file;

  UploadedData({this.file});

  UploadedData.fromJson(Map<String, dynamic> json) {
    file = json['file'] != null ? new UploadedFile.fromJson(json['file']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    return data;
  }
}

class UploadedFile {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  double? tdsAmount;
  String? tdsFileUpload;
  String? year;
  String? doctype;

  UploadedFile(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.idx,
      this.docstatus,
      this.tdsAmount,
      this.tdsFileUpload,
      this.year,
      this.doctype
      });

  UploadedFile.fromJson(Map<String, dynamic> json) {
    printLog("UploadedFile name ${json['name'].runtimeType}");
    printLog("UploadedFile owner ${json['owner'].runtimeType}");
    printLog("UploadedFile creation ${json['creation'].runtimeType}");
    printLog("UploadedFile modified ${json['modified'].runtimeType}");
    printLog("UploadedFile modified_by ${json['modified_by'].runtimeType}");
    printLog("UploadedFile idx ${json['idx'].runtimeType}");
    printLog("UploadedFile docstatus ${json['docstatus'].runtimeType}");
    printLog("UploadedFile tds_amount ${json['tds_amount'].runtimeType}");
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    tdsAmount = json['tds_amount'];
    tdsFileUpload = json['tds_file_upload'];
    year = json['year'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['idx'] = this.idx;
    data['docstatus'] = this.docstatus;
    data['tds_amount'] = this.tdsAmount;
    data['tds_file_upload'] = this.tdsFileUpload;
    data['year'] = this.year;
    data['doctype'] = this.doctype;
    return data;
  }
}

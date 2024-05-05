class DematDetailNewRequest {
  Demat? demat;

  DematDetailNewRequest({this.demat});

  DematDetailNewRequest.fromJson(Map<String, dynamic> json) {
    demat = json['demat'] != null ? new Demat.fromJson(json['demat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.demat != null) {
      data['demat'] = this.demat!.toJson();
    }
    return data;
  }
}

class Demat {
  List<DematList1>? list;

  Demat({this.list});

  Demat.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <DematList1>[];
      json['list'].forEach((v) {
        list!.add(new DematList1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DematList1 {
  String? depository;
  String? dpid;
  String? clientId;
  int? isChoice;
  int? timeStamps;

  DematList1({this.depository, this.dpid, this.clientId, this.isChoice, this.timeStamps});

  DematList1.fromJson(Map<String, dynamic> json) {
    depository = json['depository'];
    dpid = json['dpid'];
    clientId = json['client_id'];
    isChoice = json['is_choice'];
    timeStamps = json['time_stamps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['depository'] = this.depository;
    data['dpid'] = this.dpid;
    data['client_id'] = this.clientId;
    data['is_choice'] = this.isChoice;
    data['time_stamps'] = this.timeStamps;
    return data;
  }
}
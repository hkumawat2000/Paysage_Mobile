class DematDetailRequest {
  List<DematList>? dematList;

  DematDetailRequest({this.dematList});

  DematDetailRequest.fromJson(Map<String, dynamic> json) {
    if (json['demat_list'] != null) {
      dematList = <DematList>[];
      json['demat_list'].forEach((v) {
        dematList!.add(new DematList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dematList != null) {
      data['demat_list'] = this.dematList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DematList {
  String? depository;
  String? dpid;
  String? clientId;
  int? timeStamps;
  int? isAtrina;

  DematList({this.depository, this.dpid, this.clientId, this.timeStamps, this.isAtrina});

  DematList.fromJson(Map<String, dynamic> json) {
    depository = json['depository'];
    dpid = json['dpid'];
    clientId = json['client_id'];
    timeStamps = json['time_stamps'];
    isAtrina = json['is_choice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['depository'] = this.depository;
    data['dpid'] = this.dpid;
    data['client_id'] = this.clientId;
    data['time_stamps'] = this.timeStamps;
    data['is_choice'] = this.isAtrina;
    return data;
  }
}

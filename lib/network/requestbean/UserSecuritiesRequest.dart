class UserSecuritiesRequest {
  String? userID;
  String? clientID;
  String? clientName;

  UserSecuritiesRequest({this.userID, this.clientID, this.clientName});

  UserSecuritiesRequest.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    clientID = json['ClientID'];
    clientName = json['ClientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.userID;
    data['ClientID'] = this.clientID;
    data['ClientName'] = this.clientName;
    return data;
  }
}
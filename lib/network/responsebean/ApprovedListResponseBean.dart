import 'package:lms/network/ModelWrapper.dart';

class ApprovedListResponseBean extends ModelWrapper<List<ShareListData>> {
  String? message;
  List<ShareListData>? shareListData;

  ApprovedListResponseBean({this.message, this.shareListData});

  ApprovedListResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      shareListData = <ShareListData>[];
      json['data'].forEach((v) {
        shareListData!.add(new ShareListData.fromJson(v));
      });
      data = shareListData;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShareListData {
  String? branch;
  String? clientCode;
  String? clientName;
  String? scripName;
  String? iSIN;
  String? depository;
  String? stockAt;
  double? quantity;
  double? price;
  double? scripValue;
  String? holdingAsOn;
  bool? isEligible;
  String? category;
  double? pledge_qty;

  ShareListData(
      {this.branch,
        this.clientCode,
        this.clientName,
        this.scripName,
        this.iSIN,
        this.depository,
        this.stockAt,
        this.quantity,
        this.price,
        this.scripValue,
        this.holdingAsOn,
        this.isEligible,
        this.category,
      this.pledge_qty});

  ShareListData.fromJson(Map<String, dynamic> json) {
    branch = json['Branch'];
    clientCode = json['Client_Code'];
    clientName = json['Client_Name'];
    scripName = json['Scrip_Name'];
    iSIN = json['ISIN'];
    depository = json['Depository'];
    stockAt = json['Stock_At'];
    quantity = json['Quantity'];
    price = json['Price'];
    scripValue = json['Scrip_Value'];
    holdingAsOn = json['Holding_As_On'];
    isEligible = json['Is_Eligible'];
    category = json['Category'];
    pledge_qty = json['pledge_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Branch'] = this.branch;
    data['Client_Code'] = this.clientCode;
    data['Client_Name'] = this.clientName;
    data['Scrip_Name'] = this.scripName;
    data['ISIN'] = this.iSIN;
    data['Depository'] = this.depository;
    data['Stock_At'] = this.stockAt;
    data['Quantity'] = this.quantity;
    data['Price'] = this.price;
    data['Scrip_Value'] = this.scripValue;
    data['Holding_As_On'] = this.holdingAsOn;
    data['Is_Eligible'] = this.isEligible;
    data['Category'] = this.category;
    data['pledge_qty'] = this.pledge_qty;
    return data;
  }
}
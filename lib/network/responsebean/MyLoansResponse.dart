import 'package:lms/network/ModelWrapper.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class MyLoansResponse extends ModelWrapper<Message>{
  Message? message;

  MyLoansResponse({this.message});

  MyLoansResponse.fromJson(Map<String, dynamic> json) {
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
  MyLoansData? data;

  Message({this.status, this.message, this.data});

  Message.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new MyLoansData.fromJson(json['data']) : null;
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

class MyLoansData {
  List<Loans>? loans;
  int? canPledge;
  double? totalOutstanding;
  double? totalDrawingPower;
  double? totalTotalCollateralValue;
  double? totalMarginShortfall;
  double? totalSanctionedLimit;

  MyLoansData({this.loans,
    this.canPledge,
    this.totalOutstanding,
    this.totalDrawingPower,
    this.totalTotalCollateralValue,
    this.totalMarginShortfall,
    this.totalSanctionedLimit});

  MyLoansData.fromJson(Map<String, dynamic> json) {
    if (json['loans'] != null) {
      loans = <Loans>[];
      json['loans'].forEach((v) {
        loans!.add(new Loans.fromJson(v));
      });
    }
    try {
      canPledge = json['user_can_pledge'];
      totalOutstanding = json['total_outstanding'];
      totalDrawingPower = json['total_drawing_power'];
      totalTotalCollateralValue = json['total_total_collateral_value'];
      totalMarginShortfall = json['total_margin_shortfall'];
      totalSanctionedLimit = json['total_sanctioned_limit'];
    } catch (e, s) {
      printLog(s.toString());
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loans != null) {
      data['loans'] = this.loans!.map((v) => v.toJson()).toList();
    }
    data['user_can_pledge'] = this.canPledge;
    data['total_outstanding'] = this.totalOutstanding;
    data['total_drawing_power'] = this.totalDrawingPower;
    data['total_total_collateral_value'] = this.totalTotalCollateralValue;
    data['total_margin_shortfall'] = this.totalMarginShortfall;
    data['total_sanctioned_limit'] = this.totalSanctionedLimit;
    return data;
  }
}

class Loans {
  double? totalCollateralValue;
  String? totalCollateralValueStr;
  String? name;
  double? shortfall;
  double? drawingPower;
  String? drawingPowerStr;
  double? shortfallPercentage;
  double? shortfallC;
  double? outstanding;
  double? sanctionedLimit;
  String? sanctionedLimitStr;
  double? topUpAmount;
  int? topUpAvailable;

  Loans(
      {this.totalCollateralValue,
        this.name,
        this.shortfall,
        this.drawingPower,
        this.shortfallPercentage,
        this.shortfallC,this.outstanding,
      this.sanctionedLimit,this.topUpAmount,this.topUpAvailable,this.drawingPowerStr,this.sanctionedLimitStr, this.totalCollateralValueStr});

  Loans.fromJson(Map<String, dynamic> json) {
    totalCollateralValue = json['total_collateral_value'];
    totalCollateralValueStr = json['total_collateral_value_str'];
    name = json['name'];
    shortfall = json['shortfall'];
    drawingPower = json['drawing_power'];
    drawingPowerStr = json['drawing_power_str'];
    shortfallPercentage = json['shortfall_percentage'];
    shortfallC = json['shortfall_c'];
    outstanding = json['outstanding'];
    sanctionedLimit = json['sanctioned_limit'];
    sanctionedLimitStr = json['sanctioned_limit_str'];
    topUpAvailable = json['top_up_available'];
    topUpAmount = json['top_up_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_collateral_value'] = this.totalCollateralValue;
    data['total_collateral_value_str'] = this.totalCollateralValueStr;
    data['name'] = this.name;
    data['shortfall'] = this.shortfall;
    data['drawing_power'] = this.drawingPower;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['shortfall_percentage'] = this.shortfallPercentage;
    data['shortfall_c'] = this.shortfallC;
    data['outstanding'] = this.outstanding;
    data['sanctioned_limit'] = this.sanctionedLimit;
    data['sanctioned_limit_str'] = this.sanctionedLimitStr;
    data['top_up_available'] = this.topUpAvailable;
    data['top_up_amount'] = this.topUpAmount;
    return data;
  }
}
import 'package:lms/network/ModelWrapper.dart';

class UserInformation extends ModelWrapper<UserInformation>{
  String? investorName;
  String? emailId;
  String? dateOfBirth;
  String? fatherName;
  String? motherName;
  String? address;
  String? addressCity;
  String? addressPinCode;
  String? addressState;
  String? mobileNum;
  String? defaultBank;
  String? accountType;
  String? cancelChequeFileName;
  String? clientId;
  String? panNum;
  String? ifsc;
  String?micr;
  String? branch;
  String? bank;
  String? bankAddress;
  String? contact;
  String? city;
  String? district;
  String? state;
  String? bankMode;
  String? bankcode;
  Null bankZipCode;
  String? accountNumber;

  UserInformation(
      {this.investorName,
        this.emailId,
        this.dateOfBirth,
        this.fatherName,
        this.motherName,
        this.address,
        this.addressCity,
        this.addressPinCode,
        this.addressState,
        this.mobileNum,
        this.defaultBank,
        this.accountType,
        this.cancelChequeFileName,
        this.clientId,
        this.panNum,
        this.ifsc,
        this.micr,
        this.branch,
        this.bank,
        this.bankAddress,
        this.contact,
        this.city,
        this.district,
        this.state,
        this.bankMode,
        this.bankcode,
        this.bankZipCode,
        this.accountNumber});

  UserInformation.fromJson(Map<String, dynamic> json) {
    investorName = json['investorName'];
    emailId = json['emailId'];
    dateOfBirth = json['dateOfBirth'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    address = json['address'];
    addressCity = json['addressCity'];
    addressPinCode = json['addressPinCode'];
    addressState = json['addressState'];
    mobileNum = json['mobileNum'];
    defaultBank = json['defaultBank'];
    accountType = json['accountType'];
    cancelChequeFileName = json['cancelChequeFileName'];
    clientId = json['clientId'];
    panNum = json['panNum'];
    ifsc = json['ifsc'];
    micr = json['micr'];
    branch = json['branch'];
    bank = json['bank'];
    bankAddress = json['bankAddress'];
    contact = json['contact'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    bankMode = json['bankMode'];
    bankcode = json['bankcode'];
    bankZipCode = json['bankZipCode'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['investorName'] = this.investorName;
    data['emailId'] = this.emailId;
    data['dateOfBirth'] = this.dateOfBirth;
    data['fatherName'] = this.fatherName;
    data['motherName'] = this.motherName;
    data['address'] = this.address;
    data['addressCity'] = this.addressCity;
    data['addressPinCode'] = this.addressPinCode;
    data['addressState'] = this.addressState;
    data['mobileNum'] = this.mobileNum;
    data['defaultBank'] = this.defaultBank;
    data['accountType'] = this.accountType;
    data['cancelChequeFileName'] = this.cancelChequeFileName;
    data['clientId'] = this.clientId;
    data['panNum'] = this.panNum;
    data['ifsc'] = this.ifsc;
    data['micr'] = this.micr;
    data['branch'] = this.branch;
    data['bank'] = this.bank;
    data['bankAddress'] = this.bankAddress;
    data['contact'] = this.contact;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    data['bankMode'] = this.bankMode;
    data['bankcode'] = this.bankcode;
    data['bankZipCode'] = this.bankZipCode;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}
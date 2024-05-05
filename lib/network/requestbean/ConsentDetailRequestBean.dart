class ConsentDetailRequestBean {
  String? userKycName;
  int? acceptTerms;
  AddressDetails? addressDetails;
  int? isLoanRenewal;

  ConsentDetailRequestBean(
      {this.userKycName, this.acceptTerms, this.addressDetails, this.isLoanRenewal});

  ConsentDetailRequestBean.fromJson(Map<String, dynamic> json) {
    userKycName = json['user_kyc_name'];
    acceptTerms = json['accept_terms'];
    addressDetails = json['address_details'] != null
        ? new AddressDetails.fromJson(json['address_details'])
        : null;
    isLoanRenewal = json['is_loan_renewal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_kyc_name'] = this.userKycName;
    data['accept_terms'] = this.acceptTerms;
    if (this.addressDetails != null) {
      data['address_details'] = this.addressDetails!.toJson();
    } else {
      data['address_details'] = null;
    }
    data['is_loan_renewal'] = this.isLoanRenewal;
    return data;
  }
}

class AddressDetails {
  PermanentAddress? permanentAddress;
  String? permCorresFlag;
  PermanentAddress? correspondingAddress;

  AddressDetails(
      {this.permanentAddress, this.permCorresFlag, this.correspondingAddress});

  AddressDetails.fromJson(Map<String, dynamic> json) {
    permanentAddress = json['permanent_address'] != null
        ? new PermanentAddress.fromJson(json['permanent_address'])
        : null;
    permCorresFlag = json['perm_corres_flag'];
    correspondingAddress = json['corresponding_address'] != null
        ? new PermanentAddress.fromJson(json['corresponding_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.permanentAddress != null) {
      data['permanent_address'] = this.permanentAddress!.toJson();
    }
    data['perm_corres_flag'] = this.permCorresFlag;
    if (this.correspondingAddress != null) {
      data['corresponding_address'] = this.correspondingAddress!.toJson();
    }
    return data;
  }
}

class PermanentAddress {
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? pinCode;
  String? state;
  String? district;
  String? country;
  String? addressProofImage;
  String? poaType;

  PermanentAddress(
      {this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.city,
        this.pinCode,
        this.state,
        this.district,
        this.country,
        this.addressProofImage,
        this.poaType});

  PermanentAddress.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    city = json['city'];
    pinCode = json['pin_code'];
    state = json['state'];
    district = json['district'];
    country = json['country'];
    addressProofImage = json['address_proof_image'];
    poaType = json['poa_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['address_line3'] = this.addressLine3;
    data['city'] = this.city;
    data['pin_code'] = this.pinCode;
    data['state'] = this.state;
    data['district'] = this.district;
    data['country'] = this.country;
    data['address_proof_image'] = this.addressProofImage;
    data['poa_type'] = this.poaType;
    return data;
  }
}

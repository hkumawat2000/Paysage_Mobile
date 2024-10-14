// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConsentDetailsRequestEntity {
  String? userKycName;
  int? acceptTerms;
  AddressDetailsRequestEntity? addressDetailsRequestEntity;
  int? isLoanRenewal;

  ConsentDetailsRequestEntity({
    this.userKycName,
    this.acceptTerms,
    this.addressDetailsRequestEntity,
    this.isLoanRenewal,
  });
}

class AddressDetailsRequestEntity {
  PermanentAddressRequestEntity? permanentAddress;
  String? permCorresFlag;
  String? geoLocation;
  PermanentAddressRequestEntity? correspondingAddress;
  
  AddressDetailsRequestEntity({
    this.permanentAddress,
    this.permCorresFlag,
    this.geoLocation,
    this.correspondingAddress,
  });
}

class PermanentAddressRequestEntity {
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
  
  PermanentAddressRequestEntity({
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.city,
    this.pinCode,
    this.state,
    this.district,
    this.country,
    this.addressProofImage,
    this.poaType,
  });
}

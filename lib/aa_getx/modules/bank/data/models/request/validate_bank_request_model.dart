import 'package:lms/aa_getx/modules/bank/domain/entities/request/validate_bank_request_entity.dart';

class ValidateBankRequestModel {
  String? ifsc;
  String? accountHolderName;
  String? accountNumber;
  String? bankAccountType;
  String? bank;
  String? branch;
  String? city;
  String? personalizedCheque;

  ValidateBankRequestModel(
      {this.ifsc,
        this.accountHolderName,
        this.accountNumber,
        this.bankAccountType,
        this.bank,
        this.branch,
        this.city,
        this.personalizedCheque});

  ValidateBankRequestModel.fromJson(Map<String, dynamic> json) {
    ifsc = json['ifsc'];
    accountHolderName = json['account_holder_name'];
    accountNumber = json['account_number'];
    bankAccountType = json['bank_account_type'];
    bank = json['bank'];
    branch = json['branch'];
    city = json['city'];
    personalizedCheque = json['personalized_cheque'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ifsc'] = this.ifsc;
    data['account_holder_name'] = this.accountHolderName;
    data['account_number'] = this.accountNumber;
    data['bank_account_type'] = this.bankAccountType;
    data['bank'] = this.bank;
    data['branch'] = this.branch;
    data['city'] = this.city;
    data['personalized_cheque'] = this.personalizedCheque;
    return data;
  }

  factory ValidateBankRequestModel.fromEntity(ValidateBankRequestEntity validateBankRequestEntity) {
    return ValidateBankRequestModel(
      ifsc: validateBankRequestEntity.ifsc != null ? validateBankRequestEntity.ifsc as String : null,
      accountHolderName: validateBankRequestEntity.accountHolderName != null ? validateBankRequestEntity.accountHolderName as String : null,
      accountNumber: validateBankRequestEntity.accountNumber != null ? validateBankRequestEntity.accountNumber as String : null,
      bankAccountType: validateBankRequestEntity.bankAccountType != null ? validateBankRequestEntity.bankAccountType as String : null,
      bank: validateBankRequestEntity.bank != null ? validateBankRequestEntity.bank as String : null,
      branch: validateBankRequestEntity.branch != null ? validateBankRequestEntity.branch as String : null,
      city: validateBankRequestEntity.city != null ? validateBankRequestEntity.city as String : null,
      personalizedCheque: validateBankRequestEntity.personalizedCheque != null ? validateBankRequestEntity.personalizedCheque as String : null,
    );
  }
}
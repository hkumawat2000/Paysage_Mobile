class ValidateBankRequestEntity {
  String? ifsc;
  String? accountHolderName;
  String? accountNumber;
  String? bankAccountType;
  String? bank;
  String? branch;
  String? city;
  String? personalizedCheque;

  ValidateBankRequestEntity(
      {this.ifsc,
        this.accountHolderName,
        this.accountNumber,
        this.bankAccountType,
        this.bank,
        this.branch,
        this.city,
        this.personalizedCheque});
}
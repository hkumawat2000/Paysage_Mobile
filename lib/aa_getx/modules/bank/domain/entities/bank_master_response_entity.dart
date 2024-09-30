
class BankMasterResponseEntity{
  String? message;
  List<BankDataEntity>? bankList;

  BankMasterResponseEntity({this.message, this.bankList});
}

class BankDataEntity {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  String? bank;
  String? ifsc;
  String? branch;
  String? address;
  String? district;
  String? city;
  String? state;
  int? isActive;

  BankDataEntity(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        this.idx,
        this.bank,
        this.ifsc,
        this.branch,
        this.address,
        this.district,
        this.city,
        this.state,
        this.isActive});
}
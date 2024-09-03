class DematAccountResponseEntity {
  String? message;
  List<DematAccountEntity>? dematAc;

  DematAccountResponseEntity({
    this.message,
    this.dematAc,
  });
}

class DematAccountEntity {
  String? customer;
  String? depository;
  String? dpid;
  String? clientId;
  int? isAtrina;
  String? stockAt;

  DematAccountEntity({
    this.customer,
    this.depository,
    this.dpid,
    this.clientId,
    this.isAtrina,
    this.stockAt,
  });
}

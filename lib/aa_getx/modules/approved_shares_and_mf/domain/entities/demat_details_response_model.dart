class DematDetailsResponseEntity {
  String? message;
  DematDataResponseEntity? dematData;
  
  DematDetailsResponseEntity({
    this.message,
    this.dematData,
  });
}

class DematDataResponseEntity {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? customer;
  String? depository;
  String? dpid;
  String? clientId;
  String? doctype;
  
  DematDataResponseEntity({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.customer,
    this.depository,
    this.dpid,
    this.clientId,
    this.doctype,
  });
}
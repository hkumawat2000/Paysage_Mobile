

class AllLoanNamesResponseEntity {
  String? message;
  List<AllLoansNameDataEntity>? allLoansNameData;

  AllLoanNamesResponseEntity({this.message, this.allLoansNameData});
}


class AllLoansNameDataEntity {
  String? name;

  AllLoansNameDataEntity({this.name});
}

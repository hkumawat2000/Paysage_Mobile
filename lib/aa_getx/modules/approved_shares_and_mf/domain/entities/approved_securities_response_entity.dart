class ApprovedSecuritiesResponseEntity {
  String? message;
  ApprovedSecuritiesDataResponseEntity? data;

  ApprovedSecuritiesResponseEntity({
    this.message,
    this.data,
  });
}

class ApprovedSecuritiesDataResponseEntity {
  List<String>? securityCategoryList;
  List<ApprovedSecuritiesListResponseEntity>? approvedSecuritiesList;
  String? pdfFileUrl;
  ApprovedSecuritiesDataResponseEntity({
    this.securityCategoryList,
    this.approvedSecuritiesList,
    this.pdfFileUrl,
  });
}

class ApprovedSecuritiesListResponseEntity {
  String? isin;
  String? securityName;
  String? securityCategory;
  double? eligiblePercentage;
  ApprovedSecuritiesListResponseEntity({
    this.isin,
    this.securityName,
    this.securityCategory,
    this.eligiblePercentage,
  });
}
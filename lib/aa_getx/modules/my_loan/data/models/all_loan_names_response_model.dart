
import 'package:lms/aa_getx/modules/my_loan/domain/entities/all_loan_names_response_entity.dart';

class AllLoanNamesResponseModel {
  String? message;
  List<AllLoansNameData>? allLoansNameData;

  AllLoanNamesResponseModel({this.message, this.allLoansNameData});

  AllLoanNamesResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      allLoansNameData = <AllLoansNameData>[];
      json['data'].forEach((v) {
        allLoansNameData!.add(new AllLoansNameData.fromJson(v));
      });
      //data = allLoansNameData;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.allLoansNameData != null) {
      data['data'] = this.allLoansNameData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  AllLoanNamesResponseEntity toEntity() => AllLoanNamesResponseEntity(
        message: message,
        allLoansNameData: allLoansNameData?.map((x) => x.toEntity()).toList(),
      );

  factory AllLoanNamesResponseModel.fromEntity(
      AllLoanNamesResponseEntity allLoanNamesResponseEntity) {
    return AllLoanNamesResponseModel(
      message: allLoanNamesResponseEntity.message != null
          ? allLoanNamesResponseEntity.message as String
          : null,
      allLoansNameData: allLoanNamesResponseEntity.allLoansNameData != null
          ? List<AllLoansNameData>.from(
              (allLoanNamesResponseEntity.allLoansNameData as List<dynamic>)
                  .map<AllLoansNameData?>(
                (x) => AllLoansNameData.fromEntity(x as AllLoansNameDataEntity),
              ),
            )
          : null,
    );
  }
}

class AllLoansNameData {
  String? name;

  AllLoansNameData({this.name});

  AllLoansNameData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }

  AllLoansNameDataEntity toEntity() => AllLoansNameDataEntity(
        name: name,
      );

  factory AllLoansNameData.fromEntity(AllLoansNameDataEntity allLoansNameData) {
    return AllLoansNameData(
      name: allLoansNameData.name != null
          ? allLoansNameData.name as String
          : null,
    );
  }
}

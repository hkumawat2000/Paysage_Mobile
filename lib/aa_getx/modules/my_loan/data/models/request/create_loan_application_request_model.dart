import 'package:lms/aa_getx/modules/my_loan/domain/entities/create_loan_application_request_entity.dart';

class CreateLoanApplicationRequestModel {
  String? cartName;
  String? otp;
  String? fileId;
  String? pledgorBoid;

  CreateLoanApplicationRequestModel(
      {this.cartName, this.otp, this.fileId, this.pledgorBoid});

  CreateLoanApplicationRequestModel.fromJson(Map<String, dynamic> json) {
    cartName = json['cart_name'];
    otp = json['otp'];
    fileId = json['file_id'];
    pledgorBoid = json['pledgor_boid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_name'] = this.cartName;
    data['otp'] = this.otp;
    data['file_id'] = this.fileId;
    data['pledgor_boid'] = this.pledgorBoid;
    return data;
  }

  CreateLoanApplicationRequestEntity toEntity() =>
      CreateLoanApplicationRequestEntity(
        cartName:cartName,
        otp:otp,
        fileId:fileId,
        pledgorBoid:pledgorBoid,

      );

  factory CreateLoanApplicationRequestModel.fromEntity(CreateLoanApplicationRequestEntity createLoanApplicationRequestEntity) {
    return CreateLoanApplicationRequestModel(
      cartName:createLoanApplicationRequestEntity.cartName != null ? createLoanApplicationRequestEntity.cartName as String : null,
      otp:createLoanApplicationRequestEntity.otp != null ? createLoanApplicationRequestEntity.otp as String : null,
      fileId:createLoanApplicationRequestEntity.fileId != null ? createLoanApplicationRequestEntity.fileId as String : null,
      pledgorBoid:createLoanApplicationRequestEntity.pledgorBoid != null ? createLoanApplicationRequestEntity.pledgorBoid as String : null,
    );
  }
}
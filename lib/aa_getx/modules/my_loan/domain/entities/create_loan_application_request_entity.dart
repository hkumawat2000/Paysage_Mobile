
class CreateLoanApplicationRequestEntity {
  String? cartName;
  String? otp;
  String? fileId;
  String? pledgorBoid;

  CreateLoanApplicationRequestEntity(
      {required this.cartName,
      required this.otp,
      required this.fileId,
      required this.pledgorBoid});
}
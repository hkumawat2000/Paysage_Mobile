
import 'package:flutter/material.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/payment/data/data_sources/payment_data_source.dart';
import 'package:lms/aa_getx/modules/payment/data/models/request/loan_details_request_model.dart';
import 'package:lms/aa_getx/modules/payment/data/models/request/payment_request_model.dart';
import 'package:lms/aa_getx/modules/payment/data/models/request/razor_pay_request_model.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/payment_response_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/payment_request_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/razor_pay_request_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository{
  final PaymentApi paymentApi;

  PaymentRepositoryImpl(this.paymentApi);

  @override
  ResultFuture<LoanDetailsResponseEntity> getLoanDetails(LoanDetailsRequestEntity loanDetailsRequestEntity) async {
    try {
      LoanDetailsRequestModel getLoanDetailsRequestModel = LoanDetailsRequestModel.fromEntity(loanDetailsRequestEntity);
      debugPrint("request : ${loanDetailsRequestEntity.loanName}");
      final getLoanDetailsResponse =
      await paymentApi.getLoanDetails(getLoanDetailsRequestModel);
      debugPrint("response : $getLoanDetailsResponse");
      return DataSuccess(getLoanDetailsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<PaymentResponseEntity> createOrderID(PaymentRequestEntity paymentRequestEntity) async{
    try {
      PaymentRequestModel paymentRequestModel = PaymentRequestModel.fromEntity(paymentRequestEntity);
      final paymentResponse =
      await paymentApi.createOrderID(paymentRequestModel);
      debugPrint("response : $paymentResponse");
      return DataSuccess(paymentResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<CommonResponseEntity> createPaymentRequest(RazorPayRequestEntity razorPayRequestEntity) async {
    try {
      RazorPayRequestModel razorPayRequestModel = RazorPayRequestModel.fromEntity(razorPayRequestEntity);
      final createPaymentResponse =
      await paymentApi.createPaymentRequest(razorPayRequestModel);
      debugPrint("response : $createPaymentResponse");
      return DataSuccess(createPaymentResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

}
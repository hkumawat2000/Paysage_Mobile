import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/additional_account_details/data/datasource/additional_acc_details_datasource.dart';
import 'package:lms/aa_getx/modules/additional_account_details/data/models/request/additional_account_details_request_model.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/entities/request/additional_account_details_request_entity.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/entities/response/additional_account_details_response_entity.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/repositories/additional_acc_details_repository.dart';

class AdditionalAccDetailsRepositoryImpl implements AdditionalAccDetailsRepository{
  final AdditionalAccDetailsDatasource additionalAccDetailsDatasource;
  AdditionalAccDetailsRepositoryImpl(this.additionalAccDetailsDatasource);

  ResultFuture<AdditionalAccountResponseEntity> mycamsAccount(
      AdditionalAccountdetailsRequestEntity additionalAccountDetailRequestEntity) async {
    try {
      AdditionalAccountdetailsRequestModel additionalAccountdetailsRequestModel =
          AdditionalAccountdetailsRequestModel.fromEntity(additionalAccountDetailRequestEntity);
      final additionalAccountDetailResponse =
          await additionalAccDetailsDatasource.mycamsAccount(additionalAccountdetailsRequestModel);
      return DataSuccess(additionalAccountDetailResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }
}
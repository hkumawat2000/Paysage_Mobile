// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/data/datasource/approved_shares_and_mf_datasource.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/demat_account_response_entity.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/repositories/approved_shares_and_mf_repository.dart';

class ApprovedSharesAndMfRepositoryImpl
    implements ApprovedSharesAndMfRepository {
  final ApprovedSharesAndMfDatasource approvedSharesAndMfDatasource;

  ApprovedSharesAndMfRepositoryImpl(
    this.approvedSharesAndMfDatasource,
  );

  ResultFuture<DematAccountResponseEntity> getDematAccountDetails() async {
    try {
      final getDematAccountDetailsResponse =
          await approvedSharesAndMfDatasource.getDematAccountDetails();
      return DataSuccess(getDematAccountDetailsResponse.toEntity());
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

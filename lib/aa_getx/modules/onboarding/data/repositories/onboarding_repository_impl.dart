import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/alert.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/onboarding/data/data_source/onboarding_api.dart';
import 'package:lms/aa_getx/modules/onboarding/domain/entity/onboarding_response_entity.dart';
import 'package:lms/aa_getx/modules/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingApi onboardingApi;
  final ConnectionInfo connectionInfo;

  OnboardingRepositoryImpl(
    this.onboardingApi,
    this.connectionInfo,
  );
  ResultFuture<OnBoardingResponseEntity> getOnbaordingData() async {
    try {
        final onboardingResponse = await onboardingApi.getOnBoardingData();
        return DataSuccess(onboardingResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg,0));
    } on DioException catch (e) {
      return DataFailed(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(),0));
    }
  }
}

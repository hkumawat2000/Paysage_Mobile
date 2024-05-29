import 'package:lms/Eligibility/CheckEligibilityDao.dart';
import 'package:lms/network/responsebean/CheckEligibilityResponseBean.dart';

class CheckEligibilityRepository {
  final checkEligibilityDao = CheckEligibilityDao();

  Future<CheckEligibilityResponseBean> getEligibility(String lender, String searchData) =>
      checkEligibilityDao.getEligibility(lender,searchData);

  Future<CheckEligibilityResponseBean> getEligibilityWithKYC(String lender, String searchData) =>
      checkEligibilityDao.getEligibilityWithKYC(lender,searchData);
}

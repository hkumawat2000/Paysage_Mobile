import 'package:lms/network/requestbean/MFSchemeRequest.dart';
import 'package:lms/network/responsebean/MFSchemeResponse.dart';
import 'package:lms/pledge_eligibility/mutual_fund/MFSchemeDao.dart';

class MFSchemeRepository {
  final mFSchemeDao = MFSchemeDao();

  Future<MFSchemeResponse> getSchemesList(MFSchemeRequest request) =>
      mFSchemeDao.getSchemesList(request);
}

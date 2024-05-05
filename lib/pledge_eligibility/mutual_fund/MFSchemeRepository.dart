import 'package:choice/network/requestbean/MFSchemeRequest.dart';
import 'package:choice/network/responsebean/MFSchemeResponse.dart';
import 'package:choice/pledge_eligibility/mutual_fund/MFSchemeDao.dart';

class MFSchemeRepository {
  final mFSchemeDao = MFSchemeDao();

  Future<MFSchemeResponse> getSchemesList(MFSchemeRequest request) =>
      mFSchemeDao.getSchemesList(request);
}

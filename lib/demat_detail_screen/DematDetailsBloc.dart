import 'package:lms/demat_detail_screen/DematDetailsRepository.dart';
import 'package:lms/demat_detail_screen/DematDetailsResponse.dart';
import 'package:lms/network/requestbean/DematDetailNewRequest.dart';
import 'package:lms/network/responsebean/DematAcResponse.dart';

class DematDetailsBloc{
  final dematDetailsRepository = DematDetailsRepository();

  Future<DematDetailsResponse> dematDetails(DematDetailNewRequest dematDetailNewRequest) async {
    DematDetailsResponse wrapper = await dematDetailsRepository.dematDetails(dematDetailNewRequest);
    return wrapper;
  }

  Future<DematAcResponse> dematAcDetails() async {
    DematAcResponse wrapper = await dematDetailsRepository.dematAcDetails();
    return wrapper;
  }

}
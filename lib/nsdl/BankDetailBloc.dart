import 'package:lms/network/requestbean/ValidateBankRequestBean.dart';
import 'package:lms/network/responsebean/AtrinaBankResponseBean.dart';
import 'package:lms/network/responsebean/FundAccValidationResponseBean.dart';
import 'package:lms/nsdl/BankDetailRepository.dart';
import 'package:lms/nsdl/BankMasterResponse.dart';


class BankDetailBloc{
  final bankDetailRepository = BankDetailRepository();

  Future<BankMasterResponse> getBankDetails(ifsc) async{
    BankMasterResponse wrapper = await bankDetailRepository.getBankDetails(ifsc);
    return wrapper;
  }

  Future<FundAccValidationResponseBean> validateBank(ValidateBankRequestBean validateBankRequestBean) async{
    FundAccValidationResponseBean wrapper = await bankDetailRepository.validateBank(validateBankRequestBean);
    return wrapper;
  }

  // Future<CreateContactResponse> createContactAPI() async{
  //   CreateContactResponse wrapper = await bankDetailRepository.createContactAPI();
  //   return wrapper;
  // }

  // Future<CreateFundAccountResponseBean> createFundAccountAPI(CreateFundAccountRequestBean createFundAccountRequestBean) async{
  //   CreateFundAccountResponseBean wrapper = await bankDetailRepository.createFundAccountAPI(createFundAccountRequestBean);
  //   return wrapper;
  // }

  // Future<FundAccValidationResponseBean> fundAccValidationAPI(FundAccValidationRequestBean fundAccValidationRequestBean) async{
  //   FundAccValidationResponseBean wrapper = await bankDetailRepository.fundAccValidationAPI(fundAccValidationRequestBean);
  //   return wrapper;
  // }

  // Future<FundAccValidationResponseBean> fundAccValidationByIdAPI(favID, chequeByteImageString) async{
  //   FundAccValidationResponseBean wrapper = await bankDetailRepository.fundAccValidationByIdAPI(favID, chequeByteImageString);
  //   return wrapper;
  // }

  Future<AtrinaBankResponseBean> getChoiceBankKYC() async{
    AtrinaBankResponseBean wrapper = await bankDetailRepository.getChoiceBankKYC();
    return wrapper;
  }

}
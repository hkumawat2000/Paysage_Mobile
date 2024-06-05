import 'package:lms/network/requestbean/ValidateBankRequestBean.dart';
import 'package:lms/network/responsebean/AtrinaBankResponseBean.dart';
import 'package:lms/network/responsebean/FundAccValidationResponseBean.dart';
import 'package:lms/nsdl/BankDetailDao.dart';
import 'BankMasterResponse.dart';


class BankDetailRepository{

  final bankDetailDao = BankDetailDao();

  Future<BankMasterResponse> getBankDetails(ifsc) => bankDetailDao.getBankDetails(ifsc);

  Future<FundAccValidationResponseBean> validateBank(ValidateBankRequestBean validateBankRequestBean) => bankDetailDao.validateBank(validateBankRequestBean);

  // Future<CreateContactResponse> createContactAPI() => bankDetailDao.createContactAPI();

  // Future<CreateFundAccountResponseBean> createFundAccountAPI(CreateFundAccountRequestBean createFundAccountRequestBean) => bankDetailDao.createFundAccountAPI(createFundAccountRequestBean);

  // Future<FundAccValidationResponseBean> fundAccValidationAPI(FundAccValidationRequestBean fundAccValidationRequestBean) => bankDetailDao.fundAccValidationAPI(fundAccValidationRequestBean);

  // Future<FundAccValidationResponseBean> fundAccValidationByIdAPI(favId, chequeByteImageString) => bankDetailDao.fundAccValidationByIdAPI(favId, chequeByteImageString);

  Future<AtrinaBankResponseBean> getChoiceBankKYC() => bankDetailDao.getAtrinaBankKYC();

}
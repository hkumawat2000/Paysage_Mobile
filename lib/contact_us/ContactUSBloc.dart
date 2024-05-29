import 'package:lms/contact_us/ContactUSRepository.dart';
import 'package:lms/network/requestbean/ContactUsRequestBean.dart';
import 'package:lms/network/responsebean/ContactUsResponseBean.dart';
import 'package:lms/network/responsebean/LoginResponseBean.dart';

class ContactUSBloc {
  ContactUSBloc();

  final contactUSRepository = ContactUsRepository();

  Future<LoginResponseBean> contactUs(ContactUsRequestBean contactUsRequestBean) async {
    LoginResponseBean wrapper = await contactUSRepository.contactUs(contactUsRequestBean);
    return wrapper;
  }

  Future<ContactUsResponseBean> getContactUsData(String search, int viewMore) async {
    ContactUsResponseBean wrapper = await contactUSRepository.getContactUsData(search, viewMore);
    return wrapper;
  }
}

import 'package:choice/contact_us/ContactUSRepository.dart';
import 'package:choice/network/requestbean/ContactUsRequestBean.dart';
import 'package:choice/network/responsebean/ContactUsResponseBean.dart';
import 'package:choice/network/responsebean/LoginResponseBean.dart';

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

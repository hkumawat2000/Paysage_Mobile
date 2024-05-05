import 'package:choice/contact_us/ContactUSDao.dart';
import 'package:choice/network/requestbean/ContactUsRequestBean.dart';
import 'package:choice/network/responsebean/ContactUsResponseBean.dart';
import 'package:choice/network/responsebean/LoginResponseBean.dart';

class ContactUsRepository {
  final contactusDao = ContactUSDao();

  Future<LoginResponseBean> contactUs(ContactUsRequestBean contactUsRequestBean) =>
      contactusDao.contactUs(contactUsRequestBean);

  Future<ContactUsResponseBean> getContactUsData(String search, int viewMore) =>
      contactusDao.getContactUsData(search, viewMore);
}

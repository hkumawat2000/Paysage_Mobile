import 'package:lms/contact_us/ContactUSDao.dart';
import 'package:lms/network/requestbean/ContactUsRequestBean.dart';
import 'package:lms/network/responsebean/ContactUsResponseBean.dart';
import 'package:lms/network/responsebean/LoginResponseBean.dart';

class ContactUsRepository {
  final contactusDao = ContactUSDao();

  Future<LoginResponseBean> contactUs(ContactUsRequestBean contactUsRequestBean) =>
      contactusDao.contactUs(contactUsRequestBean);

  Future<ContactUsResponseBean> getContactUsData(String search, int viewMore) =>
      contactusDao.getContactUsData(search, viewMore);
}

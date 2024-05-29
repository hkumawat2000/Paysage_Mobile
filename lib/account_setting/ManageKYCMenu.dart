import 'package:lms/network/responsebean/GetProfileSetAlertResponseBean.dart';
import 'package:lms/util/Colors.dart';
import 'package:flutter/material.dart';

class ManageKYCMenu extends StatefulWidget {
  AlertData alertData;

  ManageKYCMenu(this.alertData);

  @override
  _ManageKYCMenuState createState() => _ManageKYCMenuState();
}

class _ManageKYCMenuState extends State<ManageKYCMenu> {

  List<BankAccount> bankAccount = [];
  
  @override
  void initState() {
    bankAccount.addAll(widget.alertData.userKyc!.bankAccount!.where((element) => element.bankStatus!.toLowerCase() == "approved"));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: colorGrey),
        SizedBox(height: 14),
        Text('Name', style: TextStyle(color: colorDarkGray, fontSize: 12)),
        SizedBox(height: 2),
        Text(widget.alertData.userKyc!.fullname!,
            style: TextStyle(fontWeight: FontWeight.bold, color: appTheme, fontSize: 13)),
        SizedBox(height: 13),
        Text('Date of Birth', style: TextStyle(color: colorDarkGray, fontSize: 12)),
        SizedBox(height: 2),
        Text("**/**/${widget.alertData.userKyc!.dateOfBirth!.split("-")[0]}",
            style: TextStyle(fontWeight: FontWeight.bold, color: appTheme, fontSize: 13)),
        SizedBox(height: 13),
        Text('PAN Card', style: TextStyle(color: colorDarkGray, fontSize: 12)),
        SizedBox(height: 2),
        Text(widget.alertData.userKyc!.panNo!,
            style: TextStyle(fontWeight: FontWeight.bold, color: appTheme, fontSize: 13)),
        bankAccount.length != 0 ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 13),
            Text('Bank Details', style: TextStyle(color: colorDarkGray, fontSize: 12)),
            SizedBox(height: 2),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: bankAccount.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Wrap(
                    children: [
                      Text(bankAccount[index].bank!,
                          style: TextStyle(fontWeight: FontWeight.bold, color: appTheme, fontSize: 13)),
                      SizedBox(width: 5),
                      Text("A/c", style: TextStyle(fontWeight: FontWeight.bold, color: appTheme, fontSize: 13)),
                      SizedBox(width: 5),
                      Text(bankAccount[index].accountNumber!,
                          style: TextStyle(fontWeight: FontWeight.bold, color: appTheme, fontSize: 13)),
                    ],
                  ),
                );
              },
            ),
          ],
        ) : SizedBox(),
        SizedBox(height: 14),
      ],
    );
  }
}
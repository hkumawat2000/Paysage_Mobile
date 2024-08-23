// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/modules/login/data/models/bank_account_model.dart';

import 'package:lms/aa_getx/modules/login/domain/entity/alert_data_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/bank_account_entity.dart';

class ManageKycMenuView extends StatefulWidget {
  AlertDataResponseEntity alertDataResponseEntity;

  ManageKycMenuView({
    Key? key,
    required this.alertDataResponseEntity,
  }) : super(key: key);

  @override
  State<ManageKycMenuView> createState() => _ManageKycMenuViewState();
}

class _ManageKycMenuViewState extends State<ManageKycMenuView> {
  List<BankAccountEntity> bankAccount = [];

  @override
  void initState() {
    bankAccount.addAll(widget.alertDataResponseEntity.userKyc!.bankAccount!
        .where((element) => element.bankStatus!.toLowerCase() == "approved"));
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
        Text(widget.alertDataResponseEntity.userKyc!.fullname!,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: appTheme, fontSize: 13)),
        SizedBox(height: 13),
        Text('Date of Birth',
            style: TextStyle(color: colorDarkGray, fontSize: 12)),
        SizedBox(height: 2),
        Text(
            "**/**/${widget.alertDataResponseEntity.userKyc!.dateOfBirth!.split("-")[0]}",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: appTheme, fontSize: 13)),
        SizedBox(height: 13),
        Text('PAN Card', style: TextStyle(color: colorDarkGray, fontSize: 12)),
        SizedBox(height: 2),
        Text(widget.alertDataResponseEntity.userKyc!.panNo!,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: appTheme, fontSize: 13)),
        bankAccount.length != 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 13),
                  Text('Bank Details',
                      style: TextStyle(color: colorDarkGray, fontSize: 12)),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: appTheme,
                                    fontSize: 13)),
                            SizedBox(width: 5),
                            Text("A/c",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: appTheme,
                                    fontSize: 13)),
                            SizedBox(width: 5),
                            Text(bankAccount[index].accountNumber!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: appTheme,
                                    fontSize: 13)),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )
            : SizedBox(),
        SizedBox(height: 14),
      ],
    );
  }
}

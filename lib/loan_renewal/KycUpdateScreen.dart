import 'package:lms/complete_kyc/CkycConsentScreen1.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KycUpdateScreen extends StatefulWidget {
  String? kycDocName;
  String? loanName;
  String? loanRenewalName;

  KycUpdateScreen(this.kycDocName, this.loanName, this.loanRenewalName);

  @override
  State<KycUpdateScreen> createState() => _KycUpdateScreenState();
}

class _KycUpdateScreenState extends State<KycUpdateScreen> {
  int id = 1;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Center(
            widthFactor: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Image.asset(AssetsImagePath.tutorial_3, width: 195, height: 220),
                  SizedBox(
                    height: 10,
                  ),
                  largeHeadingText("Loan Renewal"),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        groupValue: id,
                        value: 1,
                        activeColor: appTheme,
                        splashRadius: 15,
                        onChanged: (value) {
                          setState(() {
                            id = 1;
                          });
                        },
                      ),
                      Text("No change in KYC", style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Expanded(child: Text("No change in address = No change in  KYC. All you need to do is click on save on the existing address",
                            style: TextStyle(color: colorDarkGray, fontSize: 14, fontWeight: FontWeight.normal))),
                      ],
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        groupValue: id,
                        value: 2,
                        activeColor: appTheme,
                        splashRadius: 15,
                        onChanged: (value) {
                          setState(() {
                            id = 2;
                          });
                        },
                      ),
                      Text("Update KYC", style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Expanded(child: Text("Change in address = Change in KYC. Click here to enable the modification in permanent and corresponding address",
                            style: TextStyle(color: colorDarkGray, fontSize: 14, fontWeight: FontWeight.normal))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: ArrowBackwardNavigation(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        height: 45,
                        width: 100,
                        child: Material(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          elevation: 1.0,
                          color: appTheme,
                          child: AbsorbPointer(
                            absorbing: false,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                Utility.isNetworkConnection().then((isNetwork) {
                                  if (isNetwork) {
                                    if(id == 1){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CkycConsentScreen1(widget.kycDocName, true, false, widget.loanName, widget.loanRenewalName)));
                                    }else{
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CkycConsentScreen1(widget.kycDocName, true, true, "", widget.loanRenewalName)));
                                    }
                                  } else {
                                    showSnackBar(_scaffoldKey);
                                  }
                                });
                              },
                              child: ArrowForwardNavigation(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

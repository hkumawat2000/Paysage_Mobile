import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/account_statement/data/data_sources/account_statement_data_source.dart';
import 'package:lms/aa_getx/modules/account_statement/data/repositories/account_statement_repository_impl.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/usecases/submit_loan_statement_usecase.dart';
import 'package:lms/aa_getx/modules/account_statement/presentation/controllers/download_statement_controller.dart';
import 'package:lms/account_statement/SuccessDownloadEmailView.dart';

// class DownloadStatementView extends GetView<DownloadStatementController> {
//   final loanName;
//   final isComingFrom;
//   final TabController tabController;
//   DownloadStatementView(this.loanName,this.isComingFrom,this.tabController);
  //final DownloadStatementController controller = DownloadStatementController(Get.find<ConnectionInfo>(), Get.find<SubmitLoanStatementUseCase>());


class DownloadStatementView extends StatefulWidget {
  final loanName;
  final isComingFrom;
  TabController tabController;

  DownloadStatementView(this.loanName, this.isComingFrom, this.tabController);

  @override
  State<StatefulWidget> createState() {
    return DownloadStatementViewState(loanName, isComingFrom, tabController);
  }
}

class DownloadStatementViewState extends State<DownloadStatementView> {
  final DownloadStatementController controller =
  Get.put(
    DownloadStatementController(
      Get.put(
        ConnectionInfoImpl(Connectivity()),
      ),
      Get.put(
        SubmitLoanStatementUseCase(
            Get.put(AccountStatementRepositoryImpl(Get.put(AccountStatementDataSourceImpl())))),
      ),
    ),
  );

  DownloadStatementViewState(this.loanName, this.isComingFrom, this.tabController);
  final loanName;
  final isComingFrom;
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    controller.loanName = loanName;
    controller.isComingFrom = isComingFrom;
    controller.tabController = tabController;

    return  SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Obx(()=>Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Which period do you need a statement?',
                        style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                periodDropDown(),
                Divider(
                  thickness: 0.2,
                  color: colorLightGray,
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: controller.isCustomDateVisible.value,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Select custom date of your choice',
                              style: TextStyle(
                                  color: appTheme, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(child: loanFromDate()),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: loanToDate()),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    formatDropDown(),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                requestRadioSection(),
                Visibility(
                  visible: controller.isSpaceVisible.value,
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                Visibility(visible: controller.isEmailVisible.value, child: showEmail()),
                nextPreWidget(),
                SizedBox(
                  height: 30,
                ),
                // loanStatementOperationButton(),
              ],
            ),
            ),
          ),
        ),
      ),
    );}

  Widget periodDropDown() {
    return Container(
      height: 30,
      child: DropdownButtonHideUnderline(
        child: Obx(()=>DropdownButton<TransactionDuration>(
          isDense: true,
          isExpanded: true,
          hint: Text('Duration'),
          value: controller.durationSelected.value,
          icon: Image.asset(AssetsImagePath.down_arrow, height: 20, width: 20),
          iconSize: 20,
          elevation: 16,
          onChanged: (TransactionDuration? newValue) => controller.durationSelectedFunction(newValue),
          items: controller.duration.map((TransactionDuration user) {
            return new DropdownMenuItem<TransactionDuration>(
              value: user,
              child: new Text(
                user.name,
                style: new TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
        ),
      ),
    ),
   );
  }

  Widget formatDropDown() {
    return Container(
      // padding: EdgeInsets.only(left: 10, right: 10),
      height: 40,
      width: 150,
      child: DropdownButton<String>(
        isDense: true,
        isExpanded: true,
       // value: controller.currentFormat!.value,
        value: controller.currentFormat.value.isEmpty ? null : controller.currentFormat.value,
        hint: Text('Format'),
        icon: Image.asset(AssetsImagePath.down_arrow, height: 20, width: 20),
        iconSize: 24,
        elevation: 16,
        onChanged: (value)=> controller.changedDropDownFormatItem(value),
        items: controller.dropDownFormatMenuFormat,
      ),
    );
  }

  Widget loanFromDate() {
    return GestureDetector(
      child: TextFormField(
        controller: controller.fromDateController,
        obscureText: false,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "From",
          focusColor: colorLightGray,
          suffixIcon: IconButton(
            icon: Image.asset(
              AssetsImagePath.calendar,
              width: 21.0,
              height: 21.05,
            ),
            onPressed: () {},
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: appTheme,
              width: 0.2,
            ),
          ),
        ),
        onTap: ()=>
          controller.selectFromDate(Get.context!),
        keyboardType: TextInputType.datetime,
      ),
    );
  }

  Widget loanToDate() {
    return GestureDetector(
      child: TextFormField(
        controller: controller.toDateController,
        obscureText: false,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "To",
          focusColor: colorLightGray,
          suffixIcon: IconButton(
            icon: Image.asset(
              AssetsImagePath.calendar,
              width: 21.0,
              height: 21.05,
            ),
            onPressed: () {},
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: appTheme,
              width: 0.2,
            ),
          ),
        ),
        onTap: ()=>
          controller.selectToDate(Get.context!),
        keyboardType: TextInputType.datetime,
      ),
    );
  }

  Widget requestRadioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Request",
          style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(child: addRadioButton(0, "Download")),
            Expanded(child: addRadioButton(1, "Email")),
          ],
        ),
      ],
    );
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: appTheme,
          value: controller.requestType[btnValue],
          groupValue: controller.radioButtonItem.value,
          onChanged: (value)=> controller.radioButtonChanged(value),
        ),
        Text(title, style: title == controller.radioButtonItem ? boldTextStyle_18 : boldTextStyle_18_gray)
      ],
    );
  }

  Widget showEmail() {
    return controller.email != null ? Column(
      children: <Widget>[
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Text(
              'Email',
              style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: <Widget>[
            Text(
              '${controller.email}',
              style: TextStyle(color: colorDarkGray, fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 40),
      ],
    ) :  SizedBox();
  }

  Widget loanStatementOperationButton() {
    return Container(
      width: 200,
      height: 40,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        elevation: 1.0,
        color: appTheme,
        child: MaterialButton(
          minWidth: Get.size.width,
          onPressed: () async {
            _downloadSuccessBottomSheet();
          },
          child: Text(
            'Download',
            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }


  void _downloadSuccessBottomSheet() {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      SuccessDownloadEmailView(),  ///todo Change the widget after developing SuccessDownloadEmailView
    );
  }

  Widget nextPreWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: ArrowBackwardNavigation(),
          onPressed: () {
            tabController.animateTo(tabController.index - 1);
            // Navigator.pop(context);
          },
        ),
        Container(
          height: 45,
          width: 100,
          child: Material(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 1.0,
            color: appTheme,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              minWidth: Get.size.width,
              onPressed: ()=>controller.submitStatement(),
              child: ArrowForwardNavigation(),
            ),
          ),
        )
      ],
    );
  }

}



// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';

import 'package:lms/aa_getx/modules/account_settings/presentation/controllers/manage_settings_controller.dart';
import 'package:lms/aa_getx/modules/account_settings/presentation/views/settings_menu_view.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/alert_data_response_entity.dart';

class ManageSettingsView extends StatefulWidget {
  bool isKYCCompleted;
  AlertDataResponseEntity alertDataResponseEntity;

  ManageSettingsView(
    this.isKYCCompleted,
    this.alertDataResponseEntity,
  );

  @override
  State<ManageSettingsView> createState() => _ManageSettingsViewState();
}

class _ManageSettingsViewState extends State<ManageSettingsView> {
  final ManageSettingsController manageSettingsController = Get.put(ManageSettingsController());

    @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: manageSettingsController.scaffoldKey,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(left: 14, right: 14),
        child: Container(
          height: (MediaQuery.of(context).size.height) - (200),
          width: double.infinity,
          margin: EdgeInsets.only(left: 4, right: 4),
          decoration: new BoxDecoration(
            color: colorWhite,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
          ),
          child: SettingsMenuView(isKYCCompleted: widget.isKYCCompleted, alertDataResponseEntity: widget.alertDataResponseEntity, isSettingOpen: 1,),
        ),
      ),
    );
  }
}

///TODO Why is 

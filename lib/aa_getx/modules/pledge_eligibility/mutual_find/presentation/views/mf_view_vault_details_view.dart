import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/presentation/controllers/mf_view_vault_details_controller.dart';

class MfViewVaultDetailsView extends GetView<MfViewVaultDetailsController>{
  MfViewVaultDetailsView();

    @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          key: controller.scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: colorBg,
          appBar: buildBar(context),
          body: getUpsertCartDetails(),
        ),
      ),
    );
  }

  Widget getUpsertCartDetails(){

  }

  
}
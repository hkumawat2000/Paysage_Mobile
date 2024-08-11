import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/account_settings/data/data_sources/account_settings_data_source.dart';
import 'package:lms/aa_getx/modules/account_settings/data/repositories/account_settings_repository_impl.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/repositories/account_settings_repository.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/usecases/account_settings_usecases.dart';
import 'package:lms/aa_getx/modules/account_settings/presentation/controllers/change_passowrd_controller.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ChangePassowrdController changePassowrdController =
      Get.put(ChangePassowrdController(
          Get.put(
            ConnectionInfoImpl(Connectivity()),
          ),
          Get.put(
            AccountSettingsUseCase(Get.put(AccountSettingsRepositoryImpl(
                Get.put(AccountSettingsDataSourceImpl())))),
          )));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: new Scaffold(
        key: changePassowrdController.scaffoldKey,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
              bottom: (MediaQuery.of(context).viewInsets.bottom -
                  (MediaQuery.of(context).viewInsets.bottom * 0.3))),
          child: Container(
            height: (MediaQuery.of(context).size.height) - (300),
            width: double.infinity,
            decoration: new BoxDecoration(
              color: colorWhite,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            child: ChangePasswordDialog(),
          ),
        ),
      ),
    );
  }

  Widget ChangePasswordDialog() {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              child: Container(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.cancel_outlined,
                  color: colorGrey,
                  size: 26,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Text(
              Strings.change_password,
              style: TextStyle(
                fontSize: 20,
                color: red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Theme(
              data: theme.copyWith(primaryColor: appTheme),
              child: TextFormField(
                decoration: InputDecoration(
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorBlack,
                    ),
                  ),
                  labelText: Strings.current_password,
                  labelStyle: TextStyle(
                    color: changePassowrdController.currentPinFocus.hasFocus
                        ? appTheme
                        : colorLightGray,
                  ),
                  hintText: Strings.current_password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      changePassowrdController.currentPasswordVisible.isTrue
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: appTheme,
                    ),
                    onPressed: () {
                      changePassowrdController.toChangePasswordVisibility();
                    },
                  ),
                ),
                enabled: true,
                maxLength: 4,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                focusNode: changePassowrdController.currentPinFocus,
                controller: changePassowrdController.currentPin,
                obscureText:
                    changePassowrdController.currentPasswordVisible.value,
                obscuringCharacter: '*',
                style: TextStyle(fontWeight: FontWeight.w600),
                onChanged: (text) {
                  if (text.length == 4) {
                    FocusScope.of(context)
                        .requestFocus(changePassowrdController.newPinFocus);
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            Theme(
              data: theme.copyWith(primaryColor: appTheme),
              child: TextFormField(
                decoration: InputDecoration(
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorBlack,
                    ),
                  ),
                  labelText: Strings.new_password,
                  labelStyle: TextStyle(
                    color: changePassowrdController.newPinFocus.hasFocus
                        ? appTheme
                        : colorLightGray,
                  ),
                  hintText: Strings.new_password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      changePassowrdController.newPasswordVisible.isTrue
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: appTheme,
                    ),
                    onPressed: () {
                      changePassowrdController.toChangeNewPasswordVisibility();
                    },
                  ),
                ),
                enabled: true,
                maxLength: 4,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                onChanged: (text) {
                  if (text.length == 4) {
                    FocusScope.of(context)
                        .requestFocus(changePassowrdController.confirmPinFocus);
                  }
                },
                focusNode: changePassowrdController.newPinFocus,
                controller: changePassowrdController.newPin,
                obscureText: changePassowrdController.newPasswordVisible.value,
                obscuringCharacter: '*',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 10),
            Theme(
              data: theme.copyWith(primaryColor: appTheme),
              child: TextFormField(
                decoration: InputDecoration(
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorBlack,
                    ),
                  ),
                  labelText: Strings.retype_password,
                  labelStyle: TextStyle(
                    color: changePassowrdController.confirmPinFocus.hasFocus
                        ? appTheme
                        : colorLightGray,
                  ),
                  hintText: Strings.retype_password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      changePassowrdController.reTypePasswordVisible.isTrue
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: appTheme,
                    ),
                    onPressed: () {
                      changePassowrdController
                          .toChangeReTypePasswordVisibility();
                    },
                  ),
                ),
                focusNode: changePassowrdController.confirmPinFocus,
                enabled: true,
                maxLength: 4,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                validator: (val) {
                  if (val!.isEmpty) {
                  } else if (val != changePassowrdController.newPin.text)
                    return 'Pin Not Match';
                  return null;
                },
                onChanged: (text) {
                  if (text.length == 4) {
                    FocusScope.of(context).unfocus();
                  }
                },
                controller: changePassowrdController.reTypePin,
                obscureText:
                    changePassowrdController.reTypePasswordVisible.value,
                obscuringCharacter: '*',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: GestureDetector(
                child: Image(
                    image: AssetImage(AssetsImagePath.change_pin_submit_icon)),
                // Card(
                //   elevation: 6.0,
                //   color: colorGreen,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(50)),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(12.0),
                //     child: Image(image: AssetImage(AssetsImagePath.change_pin_submit_icon)),
                //   ),
                // ),
                onTap: () async {
                  changePassowrdController.onChangePinSubmit();
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

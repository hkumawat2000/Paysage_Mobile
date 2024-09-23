import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/preferences.dart';

class AddBankController extends GetxController {

  bool accHolderNameValidator = true;
  bool iFSCValidator = true;
  bool validatorIFSC = true;
  bool isAvailable = false;
  bool isAPICalled = false;
  bool iFSCTextLen = true;
  bool accNumberValidator = true;
  bool reEnterAccNumberValidator = true;
  bool isVisible = false;
  bool reEnterAccNumberIsCorrect = false;
  List<BankData> bankData = [];
  BankMasterResponse? iFSCDetails;
  BankDetailBloc bankDetailBloc = BankDetailBloc();
  BankAccount bankAccount = BankAccount();
  Timer? timer;
  int pennyAPICallCount = 0;
  String? iFSCText = "HDFC BANK";
  final completeKYCBloc = CompleteKYCBloc();
  final ImagePicker chequePicker = ImagePicker();
  String? chequeByteImageString;
  File? chequeImage;
  double? cropKb ;
  double? cropMb ;
  bool imageInMb = false;
  FocusNode ifscFocusNode = FocusNode();
  Preferences preferences = Preferences();

  TextEditingController accHolderNameController = TextEditingController();
  TextEditingController iFSCController = TextEditingController();
  TextEditingController fieldTextEditingController = TextEditingController();
  TextEditingController accNumberController = TextEditingController();
  TextEditingController reEnterAccNumberController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController accTypeController = TextEditingController();

}
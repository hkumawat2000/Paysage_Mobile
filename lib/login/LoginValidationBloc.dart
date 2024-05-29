import 'dart:async';

import 'package:lms/util/Validators.dart';
import 'package:rxdart/subjects.dart';

class LoginValidatorBloc with Validators {
  final email = BehaviorSubject<String>();

  final firstName = BehaviorSubject<String>();

  final lastName = BehaviorSubject<String>();

  final password = BehaviorSubject<String>();
  final pin = BehaviorSubject<String>();
  final panNo = BehaviorSubject<String>();

  final errorMessage = BehaviorSubject<String>();

  final isLoggedIn = BehaviorSubject<bool>();

  get emailStream => email.stream.transform(validateEmail);

  get firstNameStream => firstName.stream.transform(validateFirstName);

  get lastNametream => lastName.stream.transform(validateLastName);

  get passwordStream => password.stream.transform(validatePassword);
  get pinStream => pin.stream.transform(validatePin);

  get panStream => panNo.stream.transform(validatePanNo);

  get loggedIn => isLoggedIn.stream;


  // Change data
  Function(String) get changeEmail => email.sink.add;

  Function(String) get changeFirstName => firstName.sink.add;
  Function(String) get changePanNo => panNo.sink.add;



  Function(String) get changeLastName => lastName.sink.add;

  Function(String) get changePassword => password.sink.add;
  Function(String) get changePin => pin.sink.add;

  Function(bool) get showProgressBar => isLoggedIn.sink.add;

  bool validateFields() {
    if (email.value != null &&
        email.value.isNotEmpty &&
        password.value != null &&
        password.value.isNotEmpty &&
        pin.value != null &&
        pin.value.isNotEmpty &&
        //email.value.contains('@')
        pin.value.length == 4) {
      return true;
    } else if (email.value != null && email.value.isEmpty) {
      return false;
    } else if (password.value != null && password.value.isEmpty) {
      return false;
    }else if (pin.value != null && pin.value.isEmpty) {
      return false;
    } else {
      return false;
    }
  }

  bool validateEmailFields() {
    if (email.value != null &&
        email.value.isNotEmpty &&
        //password.value != null &&
        //password.value.isNotEmpty &&
        email.value.contains('@')
    //password.value.length > 3
    ) {
      return true;
    } else if (email.value != null && email.value.isEmpty) {
      return false;
    } else if (password.value != null && password.value.isEmpty) {
      return false;
    } else {
      return false;
    }
  }

  bool validateSignUpFields() {
    if (email.value != null &&
        email.value.isNotEmpty &&
        firstName.value != null &&
        firstName.value.isNotEmpty &&
        lastName.value != null &&
        lastName.value.isNotEmpty&&
    panNo.value != null &&
    panNo.value.isNotEmpty
    //fullName.value.length > 3
    ) {
      return true;
    } else if (email.value != null && email.value.isEmpty) {
      return false;
    } else if (firstName.value != null && firstName.value.isEmpty) {
      return false;
    }else if (panNo.value != null && panNo.value.isEmpty) {
      return false;
    } else if (lastName.value != null && lastName.value.isEmpty) {
      return false;
    } else {
      return false;
    }
  }

  dispose() async {
    await email.drain();
    email.close();
    await password.drain();
    password.close();
    await pin.drain();
    pin.close();
    await errorMessage.drain();
    errorMessage.close();
    await isLoggedIn.drain();
    isLoggedIn.close();
  }
}

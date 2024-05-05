import 'dart:async';
import 'package:choice/util/strings.dart';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError(Strings.message_valid_mail);
    }
  });

  final validatePassword =
  StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError(Strings.message_valid_password);
    }
  });

  final validateFirstName =
  StreamTransformer<String, String>.fromHandlers(handleData: (fullName, sink) {
    if (fullName.length > 3) {
      sink.add(fullName);
    } else {
      sink.addError(Strings.message_valid_firstName);
    }
  });

  final validateLastName =
  StreamTransformer<String, String>.fromHandlers(handleData: (fullName, sink) {
    if (fullName.length > 3) {
      sink.add(fullName);
    } else {
      sink.addError(Strings.message_valid_lastName);
    }
  });

  final validatePanNo =
  StreamTransformer<String, String>.fromHandlers(handleData: (panNo, sink) {
    if (panNo.contains("[A-Z]{5}[0-9]{4}[A-Z]{1}")) {
      sink.add(panNo);
    } else {
      sink.addError(Strings.message_valid_panNo);
    }
  });

  final validatePin =
  StreamTransformer<String, String>.fromHandlers(handleData: (pin, sink) {
    if (pin.length == 4) {
      sink.add(pin);
    } else {
      sink.addError(Strings.message_valid_pin);
    }
  });
}

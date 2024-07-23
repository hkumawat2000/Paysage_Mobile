import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class Biometric {
  final LocalAuthentication _localAuthentication = LocalAuthentication();


  /// This method checks whether your device has support biometric or not
  Future<bool> isDeviceSupportedBiometric() async {
    final bool canAuthenticateWithBiometrics =
    await _localAuthentication.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics ||
        await _localAuthentication.isDeviceSupported();
    return canAuthenticate;
  }


  /// This method fetches all the available biometric of the device
  Future<List<BiometricType>> getAvailableBiometric() async {
    List<BiometricType> availableBiometricType = <BiometricType>[];
    try {
      availableBiometricType =
      await _localAuthentication.getAvailableBiometrics();
    } catch (e) {
      debugPrint(e.toString());
    }
    return availableBiometricType;
  }


  /// This method authentic with biometric
  Future<bool> authenticateMe() async {
    try {
      return await _localAuthentication.authenticate(
        localizedReason: 'Touch your finger on sensor to login',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: false,
          useErrorDialogs: false,
        ),
      );
    } on PlatformException catch (e) {
      if (e.code == auth_error.lockedOut) {
        Alert.showSnackBar(title: "Too many attempts. Try again after 30 seconds");
      } else if (e.code == auth_error.permanentlyLockedOut) {
        Alert.showSnackBar(title: "Too many incorrect attempts. Biometric authentication is disabled,until the user unlocks with strong authentication.");
      } else {
        Alert.showSnackBar(title: e.message.toString());
      }
      return false;
    }
  }
}

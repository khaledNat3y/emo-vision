import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Returns true if the device supports biometric authentication
  /// and has biometrics enrolled.
  Future<bool> isAvailable() async {
    try {
      final bool canCheck = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheck && isDeviceSupported;
    } catch (_) {
      return false;
    }
  }

  /// Prompts the biometric dialog.
  /// Returns true if authentication succeeded.
  Future<bool> authenticate() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Authenticate to access EmoVision',
        options: const AuthenticationOptions(
          biometricOnly: false, // allow PIN fallback
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  /// Call this after a successful email/password login
  /// to enable biometric for future logins.
  Future<void> enableBiometric() async {
    await SharedPrefHelper.setData(CacheConstants.isBiometricLogin, true);
  }

  /// Clears the biometric flag (called on logout).
  Future<void> disableBiometric() async {
    await SharedPrefHelper.removeData(CacheConstants.isBiometricLogin);
  }
}
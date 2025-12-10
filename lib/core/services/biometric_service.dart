import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  Future<bool> authenticateBiometric() async {
    try {
      final isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return isAuthenticated;
    } catch (e) {
      Logger.debug('Error: $e');
      return false;
    }
  }

  Future<bool> requestBiometric() async {
    await canCheckBiometrics();
    return await authenticateBiometric();
  }
}

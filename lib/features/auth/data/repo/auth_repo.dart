import 'package:facial_emotional_detection_graduation_project/core/networking/api_result.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/login_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/login_response.dart';

import '../../../../core/constant/cache_constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../models/register_request_body.dart';
import '../models/register_response.dart';

class AuthRepo {
  final AuthService authService;

  AuthRepo(this.authService);

  Future<ApiResult<LoginResponse>> login({
    required LoginRequestBody body,
  }) async {
    try {
      final response = await authService.loginUser(body: body);
      await SharedPrefHelper.setSecuredString(
        CacheConstants.accessToken,
        response.accessToken,
      );
      await SharedPrefHelper.setSecuredString(
        CacheConstants.refreshToken,
        response.refreshToken,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<RegisterResponse>> register({required RegisterRequestBody body,}) async {
    try {
      final response = await authService.register(body: body);
      return ApiResult.success(response);
    }catch(e) {
      return ApiResult.error(e);
    }
  }
}

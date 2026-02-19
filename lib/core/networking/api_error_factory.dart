import 'package:flutter/material.dart';

import 'api_error_model.dart';
import 'local_status_code.dart';

class ApiErrorFactory {
  static ApiErrorModel get defaultError => ApiErrorModel(
    message: "Something went wrong",
    icon: Icons.error,
    statusCode: LocalStatusCodes.defaultError,
    errors: ["Error Occurred!"],
  );
}
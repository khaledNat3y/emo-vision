import 'package:flutter/material.dart';

class ApiErrorModel {
  final int? statusCode;
  final String? message;
  final List<String> errors;
  final IconData? icon;

  ApiErrorModel({
    required this.statusCode,
    required this.message,
    required this.errors,
    this.icon,
  });

}

import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}


extension FormAutoScroll on GlobalKey<FormState> {
  bool validateAndScroll() {
    final bool isValid = currentState?.validate() ?? false;

    if (!isValid) {
      Element? firstErrorElement;

      void findFirstError(Element element) {
        if (firstErrorElement != null) return;

        if (element.widget is FormField) {
          final state = (element as StatefulElement).state;
          if (state is FormFieldState && state.hasError) {
            firstErrorElement = element;
            return;
          }
        }

        element.visitChildren(findFirstError);
      }

      currentContext?.visitChildElements(findFirstError);

      if (firstErrorElement != null) {
        Scrollable.ensureVisible(
          firstErrorElement!,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      }
    }

    return isValid;
  }
}
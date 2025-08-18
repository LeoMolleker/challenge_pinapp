import 'package:flutter/material.dart';


extension ContextExtension on BuildContext  {
  TextStyle? get bodyLargeTheme => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get titleLargeTheme => Theme.of(this).textTheme.titleLarge;
  TextStyle? get headlineLargeTheme => Theme.of(this).textTheme.headlineLarge;
  Object? get routeArguments => ModalRoute.of(this)?.settings.arguments;
}
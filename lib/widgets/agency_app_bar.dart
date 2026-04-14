import 'package:flutter/material.dart';
import 'package:ejari/theme/app_theme.dart';

/// شريط علوي بتدرج بورجوندي للمكتب العقاري (يتوافق مع لوحة الألوان الجديدة).
AppBar agencyGradientAppBar({
  required Widget title,
  Widget? leading,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    foregroundColor: EjariColors.onPrimaryFg,
    centerTitle: true,
    flexibleSpace: Container(
      decoration: const BoxDecoration(gradient: EjariGradients.appBar),
    ),
    leading: leading,
    title: title,
    actions: actions,
    bottom: bottom,
  );
}

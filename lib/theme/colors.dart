import 'package:flutter/material.dart';

/// لوحة إيجاري — بورجوندي ترابي فاخر (حكومي / رسمي).
abstract final class EjariColors {
  /// أساسي — بورجوندي غامق.
  static const Color primary = Color(0xFF6A1E3A);
  /// تفاعل / hover للأزرار الأساسية.
  static const Color primaryHover = Color(0xFF7E2A48);
  /// ثانوي — بورجوندي فاتح ترابي.
  static const Color secondary = Color(0xFF9B4B6E);
  /// ثانوي أغمق قليلاً (ضغط / تمييز).
  static const Color secondaryHover = Color(0xFF8A4062);
  /// خلفية التطبيق — بيج ترابي فاتح.
  static const Color background = Color(0xFFF9F5F0);
  /// بطاقات — أبيض دافئ.
  static const Color card = Color(0xFFFFFCF8);
  /// لمسة ذهبية ترابية.
  static const Color accent = Color(0xFFC9A87C);
  static const Color textPrimary = Color(0xFF2E1C24);
  static const Color textSecondary = Color(0xFF7D6B5E);
  /// أخضر زيتي — نجاح / دفع.
  static const Color success = Color(0xFF7A9E7E);
  /// أحمر طيني — خطأ / حذف.
  static const Color danger = Color(0xFFC45C5C);

  static const Color dangerForeground = Color(0xFF5C2A2A);
  static const Color onSuccess = Color(0xFF1E2E20);
  static const Color onPrimaryFg = Colors.white;
  static const Color onSecondaryFg = Colors.white;

  static const Color warning = Color(0xFFB8956A);
  static const Color warningMutedBg = Color(0xFFF3EDE6);
  static const Color successMutedBg = Color(0xFFE8F0E9);
  static const Color infoBadge = primary;

  /// روابط وعناوين تفاعلية (بورجوندي فاتح أو ذهبي حسب السياق).
  static const Color link = Color(0xFF9B4B6E);
  static const Color linkAccent = Color(0xFFC9A87C);

  /// أسطح خافتة وشِبَك عرض.
  static const Color surfaceMuted = Color(0xFFF0E8E4);
  /// حدود دافئة خفيفة (بديل عن الرمادي البارد).
  static const Color borderSubtle = Color(0xFFD4C9C2);
  static const Color iconMuted = Color(0xFF9A8B82);

  /// نجم التقييم المملوء (ذهبي) / الفارغ (ترابي فاتح).
  static const Color starFilled = accent;
  static const Color starEmpty = Color(0xFFD4C4BC);

  // ——— أسماء قديمة في الشاشات (تُوجَّه للبورجوندي) ———
  static const Color lavender = primary;
  static const Color lavenderLight = secondary;
  static const Color lavenderMuted = surfaceMuted;
  static const Color lavenderDeep = textPrimary;
  static const Color lavenderDeepDark = Color(0xFF1A1216);
  static const Color navy = primary;
  static const Color navyDark = Color(0xFF4A1528);
  static const Color royalBlue = primary;
  static const Color accentText = textPrimary;
  static const Color onLavender = onPrimaryFg;
  static const Color tealBadge = primary;
  static const Color securityBannerBg = Color(0xFFF7F2EC);

  static TextStyle get inputTextStyle => const TextStyle(
        color: textPrimary,
        fontSize: 16,
        height: 1.35,
      );

  static TextStyle get inputHintStyle => const TextStyle(
        color: textSecondary,
        fontSize: 16,
        height: 1.35,
      );
}

abstract final class EjariGradients {
  /// تدرج شريط العنوان والهيدرات: بورجوندي غامق → بورجوندي ترابي.
  static const LinearGradient appBar = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF6A1E3A),
      Color(0xFF9B4B6E),
    ],
  );

  /// تدرج للبانرات العريضة (يمكن إضافة لمسة ذهبية خفيفة في النهاية).
  static const LinearGradient header = LinearGradient(
    begin: Alignment(-1, -0.8),
    end: Alignment(1, 1),
    colors: [
      Color(0xFF6A1E3A),
      Color(0xFF9B4B6E),
      Color(0xFFC9A87C),
    ],
    stops: [0.0, 0.55, 1.0],
  );
}

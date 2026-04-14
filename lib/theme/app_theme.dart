import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

export 'colors.dart';

ThemeData buildEjariTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: EjariColors.primary,
    brightness: Brightness.light,
  ).copyWith(
    primary: EjariColors.primary,
    onPrimary: EjariColors.onPrimaryFg,
    primaryContainer: EjariColors.surfaceMuted,
    onPrimaryContainer: EjariColors.textPrimary,
    secondary: EjariColors.secondary,
    onSecondary: EjariColors.onSecondaryFg,
    secondaryContainer: EjariColors.accent.withValues(alpha: 0.22),
    onSecondaryContainer: EjariColors.textPrimary,
    tertiary: EjariColors.accent,
    onTertiary: EjariColors.textPrimary,
    surface: EjariColors.background,
    onSurface: EjariColors.textPrimary,
    onSurfaceVariant: EjariColors.textSecondary,
    error: EjariColors.danger,
    onError: EjariColors.onPrimaryFg,
    outline: EjariColors.accent,
    outlineVariant: EjariColors.borderSubtle,
    shadow: EjariColors.textPrimary.withValues(alpha: 0.12),
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: EjariColors.background,
    splashColor: EjariColors.primary.withValues(alpha: 0.12),
    highlightColor: EjariColors.accent.withValues(alpha: 0.2),
  );

  final textTheme = GoogleFonts.tajawalTextTheme(base.textTheme).copyWith(
    headlineLarge: GoogleFonts.tajawal(
      fontWeight: FontWeight.w800,
      fontSize: 26,
      color: Colors.white,
    ),
    headlineMedium: GoogleFonts.tajawal(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: EjariColors.textPrimary,
    ),
    titleLarge: GoogleFonts.tajawal(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: EjariColors.textPrimary,
    ),
    titleMedium: GoogleFonts.tajawal(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: EjariColors.textPrimary,
    ),
    titleSmall: GoogleFonts.tajawal(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: EjariColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.tajawal(fontSize: 16, color: EjariColors.textPrimary),
    bodyMedium: GoogleFonts.tajawal(fontSize: 14, color: EjariColors.textSecondary),
    bodySmall: GoogleFonts.tajawal(fontSize: 12, color: EjariColors.textSecondary),
    labelLarge: GoogleFonts.tajawal(
      fontWeight: FontWeight.w600,
      fontSize: 15,
      color: EjariColors.textPrimary,
    ),
  );

  final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  final cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: EjariColors.accent.withValues(alpha: 0.45), width: 1),
  );
  final inputRadius = BorderRadius.circular(12);

  return base.copyWith(
    textTheme: textTheme,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: EjariColors.primary,
      selectionColor: EjariColors.accent.withValues(alpha: 0.35),
      selectionHandleColor: EjariColors.primary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: EjariColors.primary,
      foregroundColor: EjariColors.onPrimaryFg,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: EjariColors.primary.withValues(alpha: 0.2),
      titleTextStyle: textTheme.titleLarge?.copyWith(color: EjariColors.onPrimaryFg),
    ),
    cardTheme: CardThemeData(
      color: EjariColors.card,
      elevation: 2,
      shadowColor: EjariColors.textPrimary.withValues(alpha: 0.08),
      shape: cardShape,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return EjariColors.primary.withValues(alpha: 0.38);
          }
          if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
            return EjariColors.primaryHover;
          }
          return EjariColors.primary;
        }),
        foregroundColor: WidgetStateProperty.all(EjariColors.onPrimaryFg),
        overlayColor: WidgetStateProperty.all(EjariColors.accent.withValues(alpha: 0.16)),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
        shape: WidgetStateProperty.all(buttonShape),
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return 0.0;
          if (states.contains(WidgetState.hovered)) return 2.0;
          return 1.0;
        }),
        textStyle: WidgetStateProperty.all(
          textTheme.labelLarge?.copyWith(color: EjariColors.onPrimaryFg),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: EjariColors.primary,
        foregroundColor: EjariColors.onPrimaryFg,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: buttonShape,
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return EjariColors.primary.withValues(alpha: 0.38);
          }
          if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
            return EjariColors.primaryHover;
          }
          return EjariColors.primary;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: EjariColors.onSecondaryFg,
        backgroundColor: EjariColors.secondary,
        side: BorderSide(color: EjariColors.secondary.withValues(alpha: 0.35), width: 1),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: buttonShape,
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return EjariColors.secondary.withValues(alpha: 0.45);
          }
          if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
            return EjariColors.secondaryHover;
          }
          return EjariColors.secondary;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
            return EjariColors.onPrimaryFg.withValues(alpha: 0.1);
          }
          return null;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return EjariColors.onPrimaryFg.withValues(alpha: 0.65);
          }
          return EjariColors.onSecondaryFg;
        }),
        textStyle: WidgetStateProperty.all(
          textTheme.labelLarge?.copyWith(color: EjariColors.onSecondaryFg),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: EjariColors.link,
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
            return EjariColors.accent.withValues(alpha: 0.28);
          }
          return null;
        }),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: EjariColors.primary,
      foregroundColor: EjariColors.onPrimaryFg,
      elevation: 3,
      highlightElevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: EjariColors.textPrimary,
      textColor: EjariColors.textPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: EjariColors.surfaceMuted,
      selectedColor: EjariColors.accent.withValues(alpha: 0.45),
      labelStyle: textTheme.bodyMedium?.copyWith(color: EjariColors.textPrimary),
      secondaryLabelStyle: textTheme.bodySmall,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(color: EjariColors.accent.withValues(alpha: 0.35)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: EjariColors.card,
      hintStyle: GoogleFonts.tajawal(
        fontSize: 16,
        color: EjariColors.textSecondary,
        height: 1.35,
      ),
      labelStyle: GoogleFonts.tajawal(
        fontSize: 16,
        color: EjariColors.textSecondary,
        height: 1.2,
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return GoogleFonts.tajawal(fontSize: 14, color: EjariColors.danger, height: 1.2);
        }
        if (states.contains(WidgetState.focused)) {
          return GoogleFonts.tajawal(fontSize: 14, color: EjariColors.primary, height: 1.2);
        }
        return GoogleFonts.tajawal(fontSize: 14, color: EjariColors.textSecondary, height: 1.2);
      }),
      helperStyle: GoogleFonts.tajawal(fontSize: 12, color: EjariColors.textSecondary),
      errorStyle: GoogleFonts.tajawal(fontSize: 12, color: EjariColors.danger),
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return EjariColors.textSecondary.withValues(alpha: 0.45);
        }
        return EjariColors.textSecondary;
      }),
      suffixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return EjariColors.textSecondary.withValues(alpha: 0.45);
        }
        return EjariColors.textSecondary;
      }),
      border: OutlineInputBorder(
        borderRadius: inputRadius,
        borderSide: BorderSide(color: EjariColors.accent.withValues(alpha: 0.85), width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: inputRadius,
        borderSide: BorderSide(color: EjariColors.accent.withValues(alpha: 0.75), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: inputRadius,
        borderSide: const BorderSide(color: EjariColors.secondary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: inputRadius,
        borderSide: const BorderSide(color: EjariColors.danger, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: inputRadius,
        borderSide: const BorderSide(color: EjariColors.danger, width: 2),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: EjariColors.card,
      indicatorColor: EjariColors.secondary.withValues(alpha: 0.35),
      labelTextStyle: WidgetStateProperty.all(
        textTheme.labelLarge?.copyWith(fontSize: 12, color: EjariColors.textSecondary),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: EjariColors.primary,
      linearTrackColor: EjariColors.surfaceMuted,
    ),
    dividerTheme: DividerThemeData(
      color: EjariColors.borderSubtle,
      thickness: 1,
    ),
  );
}

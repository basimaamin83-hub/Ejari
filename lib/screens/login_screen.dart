import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/l10n/app_localizations.dart';
import 'package:ejari/state/locale_notifier.dart';
import 'package:ejari/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: EjariColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              const _LoginHeader(),
              const SizedBox(height: 100),
              Expanded(child: Container(color: EjariColors.background)),
            ],
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 8,
            left: 12,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Material(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () => ejariLocaleNotifier.toggleArEn(),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.language_rounded, color: Colors.white, size: 22),
                        const SizedBox(width: 6),
                        Text(
                          isAr ? l10n.languageEnglishShort : l10n.languageArabicShort,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: 20,
            end: 20,
            top: 168,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 54,
                      child: FilledButton.icon(
                        onPressed: () => context.push(AppRoutes.sanadVerification),
                        icon: const Icon(Icons.verified_user_rounded, size: 24),
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        label: Text(
                          l10n.loginViaSanad,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.loginViaSanadHint,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: EjariColors.textSecondary,
                            height: 1.35,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          ejariSession.enterAsGuest();
                          context.go(AppRoutes.tenantDashboard);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: EjariColors.link,
                          textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        child: Text(l10n.browseAsGuest),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: 16,
            end: 16,
            bottom: 28,
            child: _SecurityBanner(text: l10n.loginSecureBanner),
          ),
        ],
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 52, 24, 88),
      decoration: const BoxDecoration(
        gradient: EjariGradients.header,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.85), width: 2),
            ),
            child: const Icon(Icons.verified_user_outlined, color: Colors.white, size: 36),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.loginWelcomeTitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.loginSubtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityBanner extends StatelessWidget {
  const _SecurityBanner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: EjariColors.securityBannerBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: EjariColors.primary.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, color: EjariColors.textPrimary, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: EjariColors.textPrimary,
                    height: 1.3,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

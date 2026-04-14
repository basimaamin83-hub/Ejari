import 'package:flutter/material.dart';
import 'package:ejari/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/sanad_login_mock.dart';
import 'package:ejari/theme/app_theme.dart';

/// بعد التحقق من سند: اختيار نوع الحساب قبل إكمال الجلسة.
class AccountTypeSelectionScreen extends StatelessWidget {
  const AccountTypeSelectionScreen({super.key});

  Future<void> _pick(BuildContext context, SanadAccountKind kind) async {
    await ejariSession.completeSanadLogin(kind);
    if (!context.mounted) return;
    switch (kind) {
      case SanadAccountKind.tenant:
        context.go(AppRoutes.tenantDashboard);
        break;
      case SanadAccountKind.landlord:
        context.go(AppRoutes.ownerDashboard);
        break;
      case SanadAccountKind.agency:
        context.go(AppRoutes.agencyDashboard);
        break;
    }
  }

  void _asGuest(BuildContext context) {
    ejariSession.clearPendingSanadIdentity();
    ejariSession.enterAsGuest();
    context.go(AppRoutes.tenantDashboard);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (ejariSession.pendingSanadIdentity == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(AppRoutes.login);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: AppBar(
          title: Text(l10n.accountTypeTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              ejariSession.clearPendingSanadIdentity();
              context.go(AppRoutes.login);
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            Text(
              l10n.accountTypeSubtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: EjariColors.textSecondary,
                    height: 1.4,
                  ),
            ),
            const SizedBox(height: 24),
            _AccountTypeCard(
              icon: Icons.person_outline_rounded,
              label: l10n.accountTypeTenant,
              onTap: () => _pick(context, SanadAccountKind.tenant),
            ),
            const SizedBox(height: 12),
            _AccountTypeCard(
              icon: Icons.home_work_outlined,
              label: l10n.accountTypeOwner,
              onTap: () => _pick(context, SanadAccountKind.landlord),
            ),
            const SizedBox(height: 12),
            _AccountTypeCard(
              icon: Icons.business_outlined,
              label: l10n.accountTypeAgency,
              onTap: () => _pick(context, SanadAccountKind.agency),
            ),
            const SizedBox(height: 28),
            Center(
              child: TextButton(
                onPressed: () => _asGuest(context),
                style: TextButton.styleFrom(foregroundColor: EjariColors.link),
                child: Text(l10n.registerAsGuest),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountTypeCard extends StatelessWidget {
  const _AccountTypeCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: EjariColors.card,
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              Icon(icon, size: 36, color: EjariColors.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const Icon(Icons.chevron_left, color: EjariColors.iconMuted),
            ],
          ),
        ),
      ),
    );
  }
}

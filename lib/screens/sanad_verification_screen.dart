import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/sanad_account_preferences.dart';
import 'package:ejari/data/sanad_login_mock.dart';
import 'package:ejari/l10n/app_localizations.dart';
import 'package:ejari/theme/app_theme.dart';

/// شاشة وهمية تحاكي التحقق عبر تطبيق سند (رقم هوية + رقم سري تجريبي).
class SanadVerificationScreen extends StatefulWidget {
  const SanadVerificationScreen({super.key});

  @override
  State<SanadVerificationScreen> createState() => _SanadVerificationScreenState();
}

class _SanadVerificationScreenState extends State<SanadVerificationScreen> {
  final _idCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _idCtrl.dispose();
    _pinCtrl.dispose();
    super.dispose();
  }

  void _goDashboard(SanadAccountKind kind) {
    switch (kind) {
      case SanadAccountKind.landlord:
        context.go(AppRoutes.ownerDashboard);
        break;
      case SanadAccountKind.agency:
        context.go(AppRoutes.agencyDashboard);
        break;
      case SanadAccountKind.tenant:
        context.go(AppRoutes.tenantDashboard);
        break;
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final id = _idCtrl.text.trim();
    final pin = _pinCtrl.text;
    if (id.length < 10) {
      setState(() => _error = l10n.sanadErrNationalId);
      return;
    }
    if (pin.isEmpty) {
      setState(() => _error = l10n.sanadErrPassword);
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final identity = await simulateSanadLogin(nationalId: id, pin: pin);
      final savedKind = await SanadAccountPreferences.getSavedKind(identity.nationalId);

      if (!mounted) return;

      if (savedKind != null) {
        await ejariSession.loginWithStoredAccountKind(identity, savedKind);
        if (!mounted) return;
        _goDashboard(savedKind);
      } else {
        ejariSession.setPendingSanadIdentity(identity);
        context.go(AppRoutes.accountTypeSelection);
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = l10n.sanadErrGeneric;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: EjariColors.background,
      appBar: AppBar(
        title: Text(l10n.sanadTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: _loading ? null : () => context.pop(),
        ),
      ),
      body: AbsorbPointer(
        absorbing: _loading,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            Icon(Icons.badge_outlined, size: 48, color: EjariColors.primary),
            const SizedBox(height: 12),
            Text(
              l10n.sanadIntro,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: EjariColors.textSecondary,
                    height: 1.4,
                  ),
            ),
            const SizedBox(height: 28),
            TextField(
              controller: _idCtrl,
              keyboardType: TextInputType.number,
              maxLength: 10,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: l10n.sanadNationalIdLabel,
                border: const OutlineInputBorder(),
                counterText: '',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pinCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.sanadPasswordLabel,
                border: const OutlineInputBorder(),
                helperText: l10n.sanadPasswordHelper,
              ),
              onSubmitted: (_) => _submit(),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(
                _error!,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.red.shade800, fontSize: 13),
              ),
            ],
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox(
                        width: 26,
                        height: 26,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      )
                    : Text(l10n.sanadVerifyContinue),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.sanadFooterNote,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

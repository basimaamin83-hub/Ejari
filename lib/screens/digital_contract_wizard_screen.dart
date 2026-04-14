import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/digital_contract_mock.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/models/digital_contract_wizard_args.dart';
import 'package:ejari/services/ejari_certificate_pdf.dart';
import 'package:ejari/state/tenant_contract_notifier.dart';
import 'package:ejari/l10n/app_localizations.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/utils/format_date_ar.dart';
import 'package:printing/printing.dart';

enum _SignAuthMethod { biometric, otp, pin }

/// حالة مسودة العقد عبر الخطوات.
class _Draft {
  String deedNumber = '';
  String parcelNumber = '';
  String landDescription = '';
  String linkedPropertyId = 'p-1';
  bool landLookupDone = false;

  int durationYears = 1;
  double monthlyRent = 350;
  int rentPayIndex = 0;
  double securityDeposit = 350;
  DateTime leaseStart = DateTime.now();

  String ownerName = '';
  String ownerNationalId = '';
  String ownerPhone = '';
  bool ownerConfirmed = false;

  String tenantName = '';
  String tenantNationalId = '';
  String tenantPhone = '';
  bool tenantConfirmed = false;

  bool localSignatureDone = false;
  bool counterpartySignatureSimulated = false;

  int? certPayIndex;

  DateTime leaseEnd() => DateTime(leaseStart.year + durationYears, leaseStart.month, leaseStart.day);
}

class DigitalContractWizardScreen extends StatefulWidget {
  const DigitalContractWizardScreen({super.key, required this.args});

  final DigitalContractWizardArgs args;

  @override
  State<DigitalContractWizardScreen> createState() => _DigitalContractWizardScreenState();
}

class _DigitalContractWizardScreenState extends State<DigitalContractWizardScreen> {
  int _step = 0;
  final _draft = _Draft();
  late int _certificationFee;

  final _deedCtl = TextEditingController();
  final _parcelCtl = TextEditingController();
  final _rentCtl = TextEditingController();
  final _depositCtl = TextEditingController();

  bool _landBusy = false;
  bool _certBusy = false;

  String _rentPayLabel(AppLocalizations l) {
    switch (_draft.rentPayIndex) {
      case 0:
        return l.dcRentPayBank;
      case 1:
        return l.dcRentPayCash;
      case 2:
        return l.dcRentPayWallet;
      default:
        return l.dcRentPayBank;
    }
  }

  @override
  void initState() {
    super.initState();
    _certificationFee = 10 + (DateTime.now().millisecondsSinceEpoch % 11);
    _depositCtl.text = _draft.securityDeposit.toStringAsFixed(0);
    _rentCtl.text = _draft.monthlyRent.toStringAsFixed(0);

    final u = ejariSession.user;
    if (u != null && !ejariSession.isGuest && u.role == 'tenant') {
      _draft.tenantNationalId = u.idNumber ?? '';
      _draft.tenantName = u.fullName;
      _draft.tenantPhone = u.phone ?? '';
    }
    _draft.ownerNationalId = mockOwnerUser.idNumber ?? '';
    _draft.ownerName = mockOwnerUser.fullName;
    _draft.ownerPhone = mockOwnerUser.phone ?? '';

    if (widget.args.isRenewal) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _prefillRenewal());
    } else {
      _deedCtl.text = _draft.deedNumber;
      _parcelCtl.text = _draft.parcelNumber;
    }
  }

  void _prefillRenewal() {
    final u = ejariSession.user;
    if (u == null || u.role != 'tenant') return;
    final c = tenantContractNotifier.activeContract(u.id);
    final p = propertyById(c.propertyId);

    final h = c.propertyId.hashCode.abs();
    _draft.deedNumber = '1250/${(h % 8000) + 1000}';
    _draft.parcelNumber = '${(h % 400) + 1}';
    _deedCtl.text = _draft.deedNumber;
    _parcelCtl.text = _draft.parcelNumber;

    if (p != null) {
      _draft.linkedPropertyId = p.id;
      _draft.landDescription = '${p.title} — ${p.location} (مساحة تقديرية ${p.areaSqm} م²)';
      _draft.landLookupDone = true;
    } else {
      _draft.landDescription = c.addressLabel;
      _draft.landLookupDone = true;
    }

    _draft.monthlyRent = c.monthlyRent;
    _rentCtl.text = _draft.monthlyRent.toStringAsFixed(0);
    if (c.leaseStartDate != null && c.leaseEndDate != null) {
      final spanDays = c.leaseEndDate!.difference(c.leaseStartDate!).inDays;
      final y = (spanDays / 365).round().clamp(1, 3);
      _draft.durationYears = y;
    }
    _draft.leaseStart = c.leaseEndDate ?? DateTime.now();
    _draft.ownerNationalId = mockOwnerUser.idNumber ?? _draft.ownerNationalId;
    _draft.ownerName = mockOwnerUser.fullName;
    _draft.tenantNationalId = u.idNumber ?? '';
    _draft.tenantName = u.fullName;
    _draft.tenantPhone = u.phone ?? '';
    _draft.securityDeposit = c.monthlyRent;
    _depositCtl.text = _draft.securityDeposit.toStringAsFixed(0);
    setState(() {});
  }

  @override
  void dispose() {
    _deedCtl.dispose();
    _parcelCtl.dispose();
    _rentCtl.dispose();
    _depositCtl.dispose();
    super.dispose();
  }

  bool _sessionIsTenant() => ejariSession.user?.role == 'tenant';

  Future<void> _runLandSearch() async {
    FocusScope.of(context).unfocus();
    setState(() => _landBusy = true);
    try {
      final res = await mockFetchLandRegistry(
        deedNumber: _deedCtl.text,
        parcelNumber: _parcelCtl.text,
      );
      setState(() {
        _draft.deedNumber = res.deedNumber;
        _draft.parcelNumber = res.parcelNumber;
        _draft.landDescription = '${res.descriptionAr} — ${res.regionLabel} — مساحة أرض القطعة تقديرياً ${res.areaSqm} م²';
        _draft.linkedPropertyId = res.linkedPropertyId;
        _draft.landLookupDone = true;
        _landBusy = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.dcSnackLandFetched)),
        );
      }
    } catch (e) {
      setState(() => _landBusy = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  Future<void> _loadDigitalId({required bool owner}) async {
    final id = owner ? _draft.ownerNationalId.trim() : _draft.tenantNationalId.trim();
    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.dcSnackEnterNationalId)),
      );
      return;
    }
    try {
      final p = await mockFetchDigitalId(nationalId: id);
      setState(() {
        if (owner) {
          _draft.ownerName = p.fullNameAr;
          _draft.ownerNationalId = p.nationalId;
          _draft.ownerPhone = p.phone;
        } else {
          _draft.tenantName = p.fullNameAr;
          _draft.tenantNationalId = p.nationalId;
          _draft.tenantPhone = p.phone;
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.dcSnackDigitalIdOk)),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.dcSnackDigitalIdFail)),
        );
      }
    }
  }

  Future<void> _openSignDialog() async {
    final l10n = AppLocalizations.of(context)!;
    _SignAuthMethod method = _SignAuthMethod.biometric;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final dl = AppLocalizations.of(ctx)!;
        return StatefulBuilder(
          builder: (context, setModal) {
            return AlertDialog(
              title: Text(dl.dcSignDialogTitle),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(dl.dcSignDialogBody),
                  const SizedBox(height: 12),
                  ...[
                    (_SignAuthMethod.biometric, dl.dcAuthBiometric),
                    (_SignAuthMethod.otp, dl.dcAuthOtp),
                    (_SignAuthMethod.pin, dl.dcAuthPin),
                  ].map(
                    (e) {
                      final selected = method == e.$1;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ChoiceChip(
                          label: Text(e.$2),
                          selected: selected,
                          onSelected: (_) => setModal(() => method = e.$1),
                        ),
                      );
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(dl.commonCancel)),
                FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(dl.dcSignNow)),
              ],
            );
          },
        );
      },
    );
    if (ok != true || !mounted) return;
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _draft.localSignatureDone = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.dcSnackNotifyOther)),
    );
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    if (!mounted) return;
    setState(() => _draft.counterpartySignatureSimulated = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.dcSnackOtherSigned)),
    );
  }

  Future<void> _issueCertificate() async {
    final uid = ejariSession.user?.id;
    if (uid == null) return;

    setState(() => _certBusy = true);
    try {
      final certId = 'EJR-${DateTime.now().millisecondsSinceEpoch}';
      final verifyUrl = 'https://verify.ejari.jo/$certId';
      final pdfBytes = await buildEjariCertificatePdf(
        certificateId: certId,
        verificationUrl: verifyUrl,
        propertySummary: _draft.landDescription,
        lessorName: _draft.ownerName,
        tenantName: _draft.tenantName,
        leaseStart: _draft.leaseStart,
        leaseEnd: _draft.leaseEnd(),
        monthlyRent: _draft.monthlyRent,
        isRenewal: widget.args.isRenewal,
      );
      tenantContractNotifier.applyDigitalContractCompletion(
        tenantId: uid,
        propertyId: _draft.linkedPropertyId,
        monthlyRent: _draft.monthlyRent,
        leaseStart: _draft.leaseStart,
        leaseEnd: _draft.leaseEnd(),
        addressLabel: _draft.landDescription.length > 120
            ? '${_draft.landDescription.substring(0, 120)}…'
            : _draft.landDescription,
      );

      if (!mounted) return;
      setState(() => _certBusy = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.dcSnackDashboardUpdated)),
      );
      await Printing.sharePdf(bytes: pdfBytes, filename: 'ejari-shahada-$certId.pdf');
      if (!mounted) return;
      context.pop();
    } catch (e) {
      if (mounted) {
        setState(() => _certBusy = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.dcSnackCertFail('$e'))),
        );
      }
    }
  }

  bool _validateStep(int i) {
    final l10n = AppLocalizations.of(context)!;
    switch (i) {
      case 0:
        if (!_draft.landLookupDone || _draft.landDescription.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.dcValidateLand)),
          );
          return false;
        }
        return true;
      case 1:
        final rent = double.tryParse(_rentCtl.text.replaceAll(',', '.'));
        final dep = double.tryParse(_depositCtl.text.replaceAll(',', '.'));
        if (rent == null || rent <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.dcValidateRent)),
          );
          return false;
        }
        if (dep == null || dep < 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.dcValidateDeposit)),
          );
          return false;
        }
        _draft.monthlyRent = rent;
        _draft.securityDeposit = dep;
        return true;
      case 2:
        if (!_draft.ownerConfirmed || !_draft.tenantConfirmed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.dcValidateConfirmParties)),
          );
          return false;
        }
        if (_draft.ownerName.isEmpty || _draft.tenantName.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.dcValidatePartyNames)),
          );
          return false;
        }
        return true;
      case 3:
        if (!_draft.localSignatureDone || !_draft.counterpartySignatureSimulated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.dcValidateSignatures)),
          );
          return false;
        }
        return true;
      case 4:
        if (_draft.certPayIndex == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.dcValidateCertPay)),
          );
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _goNext() {
    if (!_validateStep(_step)) return;
    if (_step < 4) {
      setState(() => _step++);
    }
  }

  void _goBack() {
    if (_step > 0) {
      setState(() => _step--);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (ejariSession.isGuest || !_sessionIsTenant()) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.digitalContractTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              l10n.digitalContractTenantOnly,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: EjariColors.background,
      appBar: AppBar(
        title: Text(widget.args.isRenewal ? l10n.digitalContractRenewTitle : l10n.digitalContractNewTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: _goBack,
        ),
      ),
      body: Column(
        children: [
          _ProgressHeader(step: _step, l10n: l10n),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: _stepContent(),
            ),
          ),
          _BottomBar(
            step: _step,
            onBack: _goBack,
            onNext: _step == 4 ? null : _goNext,
            onIssueCertificate: _step == 4 ? _issueCertificate : null,
            completeBusy: _certBusy,
            completeLabel: l10n.digitalContractIssueCert,
            l10n: l10n,
          ),
        ],
      ),
    );
  }

  Widget _stepContent() {
    switch (_step) {
      case 0:
        return _step1Land();
      case 1:
        return _step2Rent();
      case 2:
        return _step3Parties();
      case 3:
        return _step4Contract();
      default:
        return _step5Pay();
    }
  }

  Widget _step1Land() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionTitle(l10n.dcStep1Title),
        TextField(
          controller: _deedCtl,
          style: EjariColors.inputTextStyle,
          decoration: InputDecoration(
            labelText: l10n.dcLabelDeedRef,
            border: const OutlineInputBorder(),
          ),
          textAlign: TextAlign.right,
          onChanged: (_) {
            _draft.landLookupDone = false;
          },
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _parcelCtl,
          style: EjariColors.inputTextStyle,
          decoration: InputDecoration(
            labelText: l10n.dcLabelParcel,
            border: const OutlineInputBorder(),
          ),
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          onChanged: (_) => _draft.landLookupDone = false,
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _landBusy ? null : _runLandSearch,
          icon: _landBusy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: EjariColors.onPrimaryFg),
                )
              : const Icon(Icons.search),
          label: Text(_landBusy ? l10n.dcSearchingLand : l10n.dcSearchLand),
        ),
        if (_draft.landLookupDone) ...[
          const SizedBox(height: 20),
          Material(
            color: EjariColors.card,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(l10n.dcLandResultTitle, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text(_draft.landDescription, textAlign: TextAlign.right),
                  const SizedBox(height: 8),
                  Text(l10n.dcLinkedIdMock(_draft.linkedPropertyId), style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _step2Rent() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionTitle(l10n.dcStep2Title),
        DropdownButtonFormField<int>(
          initialValue: _draft.durationYears,
          style: EjariColors.inputTextStyle,
          dropdownColor: EjariColors.card,
          iconEnabledColor: EjariColors.textSecondary,
          decoration: InputDecoration(
            labelText: l10n.dcDurationLabel,
            border: const OutlineInputBorder(),
          ),
          items: [
            DropdownMenuItem(value: 1, child: Text(l10n.dcDurationOneYear)),
            DropdownMenuItem(value: 2, child: Text(l10n.dcDurationTwoYears)),
            DropdownMenuItem(value: 3, child: Text(l10n.dcDurationThreeYears)),
          ],
          onChanged: (v) => setState(() => _draft.durationYears = v ?? 1),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _rentCtl,
          style: EjariColors.inputTextStyle,
          decoration: InputDecoration(
            labelText: l10n.dcMonthlyRentLabel,
            border: const OutlineInputBorder(),
          ),
          textAlign: TextAlign.right,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<int>(
          initialValue: _draft.rentPayIndex,
          style: EjariColors.inputTextStyle,
          dropdownColor: EjariColors.card,
          iconEnabledColor: EjariColors.textSecondary,
          decoration: InputDecoration(
            labelText: l10n.dcRentPaymentMethod,
            border: const OutlineInputBorder(),
          ),
          items: [
            DropdownMenuItem(value: 0, child: Text(l10n.dcRentPayBank)),
            DropdownMenuItem(value: 1, child: Text(l10n.dcRentPayCash)),
            DropdownMenuItem(value: 2, child: Text(l10n.dcRentPayWallet)),
          ],
          onChanged: (v) => setState(() => _draft.rentPayIndex = v ?? 0),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _depositCtl,
          style: EjariColors.inputTextStyle,
          decoration: InputDecoration(
            labelText: l10n.dcDepositLabel,
            border: const OutlineInputBorder(),
          ),
          textAlign: TextAlign.right,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
        ),
        const SizedBox(height: 12),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.dcLeaseStartTitle),
          subtitle: Text(formatDateAr(_draft.leaseStart)),
          trailing: const Icon(Icons.calendar_month_outlined),
          onTap: () async {
            final d = await showDatePicker(
              context: context,
              initialDate: _draft.leaseStart,
              firstDate: DateTime(2020),
              lastDate: DateTime(2040),
            );
            if (d != null) setState(() => _draft.leaseStart = d);
          },
        ),
        const SizedBox(height: 8),
        Material(
          color: EjariColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  l10n.dcLeaseEndComputed(formatDateAr(_draft.leaseEnd())),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _step3Parties() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionTitle(l10n.dcStep3Title),
        Text(
          l10n.dcPartiesIntro,
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 16),
        _partyCard(
          title: l10n.dcPartyOwnerTitle,
          name: _draft.ownerName,
          onNameChanged: (v) => setState(() => _draft.ownerName = v),
          nationalId: _draft.ownerNationalId,
          onNationalIdChanged: (v) => setState(() => _draft.ownerNationalId = v),
          phone: _draft.ownerPhone,
          onPhoneChanged: (v) => setState(() => _draft.ownerPhone = v),
          confirmed: _draft.ownerConfirmed,
          onConfirmed: (v) => setState(() => _draft.ownerConfirmed = v ?? false),
          onFetch: () => _loadDigitalId(owner: true),
        ),
        const SizedBox(height: 16),
        _partyCard(
          title: l10n.dcPartyTenantTitle,
          name: _draft.tenantName,
          onNameChanged: (v) => setState(() => _draft.tenantName = v),
          nationalId: _draft.tenantNationalId,
          onNationalIdChanged: (v) => setState(() => _draft.tenantNationalId = v),
          phone: _draft.tenantPhone,
          onPhoneChanged: (v) => setState(() => _draft.tenantPhone = v),
          confirmed: _draft.tenantConfirmed,
          onConfirmed: (v) => setState(() => _draft.tenantConfirmed = v ?? false),
          onFetch: () => _loadDigitalId(owner: false),
        ),
      ],
    );
  }

  Widget _partyCard({
    required String title,
    required String name,
    required ValueChanged<String> onNameChanged,
    required String nationalId,
    required ValueChanged<String> onNationalIdChanged,
    required String phone,
    required ValueChanged<String> onPhoneChanged,
    required bool confirmed,
    required ValueChanged<bool?> onConfirmed,
    required VoidCallback onFetch,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: EjariColors.card,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            TextFormField(
              key: ValueKey('$title-name-$name'),
              initialValue: name,
              style: EjariColors.inputTextStyle,
              decoration: InputDecoration(labelText: l10n.dcFullName, border: const OutlineInputBorder()),
              textAlign: TextAlign.right,
              onChanged: onNameChanged,
            ),
            const SizedBox(height: 8),
            TextFormField(
              key: ValueKey('$title-nid-$nationalId'),
              initialValue: nationalId,
              style: EjariColors.inputTextStyle,
              decoration: InputDecoration(labelText: l10n.dcNationalId, border: const OutlineInputBorder()),
              textAlign: TextAlign.right,
              onChanged: onNationalIdChanged,
            ),
            const SizedBox(height: 8),
            TextFormField(
              key: ValueKey('$title-ph-$phone'),
              initialValue: phone,
              style: EjariColors.inputTextStyle,
              decoration: InputDecoration(labelText: l10n.commonPhone, border: const OutlineInputBorder()),
              textAlign: TextAlign.right,
              onChanged: onPhoneChanged,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: onFetch,
              icon: const Icon(Icons.badge_outlined),
              label: Text(l10n.dcFetchDigitalId),
            ),
            CheckboxListTile(
              value: confirmed,
              onChanged: onConfirmed,
              title: Text(l10n.dcConfirmData),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _step4Contract() {
    final l10n = AppLocalizations.of(context)!;
    const lawNotice =
        'يُعتد بالسجل الإلكتروني وبأي توقيع إلكتروني معتمد يطبق على هذا العقد — متى تحققت الشروط المنصوص عليها في القانون — '
        'وفق قانون المعاملات الإلكترونية الأردني رقم (15) لسنة 2015، ولهذه العناصر من الحجة ما للسجلات والتوقيعات الورقية والخطية.';
    final body =
        '''

عقد إيجار إلكتروني موثّق

طرفا هذا العقد:
- المؤجر: ${_draft.ownerName}، يحمل الرقم الوطني ${_draft.ownerNationalId}، هاتف ${_draft.ownerPhone}.
- المستأجر: ${_draft.tenantName}، يحمل الرقم الوطني ${_draft.tenantNationalId}، هاتف ${_draft.tenantPhone}.

أولاً — العين المؤجرة:
${_draft.landDescription}

ثانياً — المدة والأجر:
مدة العقد ${_draft.durationYears} ${_draft.durationYears == 1 ? l10n.wordYear : l10n.wordYears} تبدأ ${formatDateAr(_draft.leaseStart)} وتنتهي ${formatDateAr(_draft.leaseEnd())}.
الأجر الشهري ${_draft.monthlyRent.toStringAsFixed(0)} دينار أردني، وطريقة السداد: ${_rentPayLabel(l10n)}.
مبلغ التأمين ${_draft.securityDeposit.toStringAsFixed(0)} دينار أردني يودع لدى المؤجر وفق الاتفاق.

ثالثاً — التزامات الطرفين:
يلتزم المؤجر بتسليم العين بحالة صالحة للاستخدام المحدد، ويلتزم المستأجر بالمحافظة على العين واستخدامها للغرض المتفق عليه، ودفع الأجر في مواعيده.

رابعاً — الصيانة:
الصيانة الكبرى على المؤجر والصيانة الاعتيادية على المستأجر، ما لم يتفق الطرفان كتابة على خلاف ذلك.

خامساً — إنهاء العقد:
يجوز إنهاء العقد باتفاق الطرفين، أو لأسباب منصوص عليها في القانون، مع احترام الإخطارات والمدد المعقولة.

سادساً — حل النزاعات:
في حال نشوء نزاع يُحال — حسب الاتفاق — إلى الجهات القضائية المختصة في المملكة الأردنية الهاشمية.

سابعاً — التوقيع الإلكتروني:
يُنجز التوقيع عبر منظومة «إيجاري» بوسائل هوية رقمية معتمدة، وتُخزن نسخة العقد في السجل الإلكتروني.

$lawNotice
''';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionTitle(l10n.dcStep4Title),
        Text(
          l10n.dcPreviewIntro,
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 12),
        Material(
          color: EjariColors.card,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SelectableText(body, textAlign: TextAlign.right),
          ),
        ),
        const SizedBox(height: 16),
        if (!_draft.counterpartySignatureSimulated)
          FilledButton.icon(
            onPressed: _draft.localSignatureDone ? null : _openSignDialog,
            icon: const Icon(Icons.draw_outlined),
            label: Text(l10n.dcSignNowButton),
          )
        else
          Icon(Icons.check_circle, color: EjariColors.success, size: 40),
        if (_draft.localSignatureDone) ...[
          const SizedBox(height: 8),
          Text(
            _draft.counterpartySignatureSimulated ? l10n.dcSigningStatusBoth : l10n.dcSigningStatusWait,
            textAlign: TextAlign.right,
            style: const TextStyle(color: EjariColors.textPrimary, fontWeight: FontWeight.w600),
          ),
        ],
      ],
    );
  }

  Widget _step5Pay() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionTitle(l10n.dcStep5Title),
        Text(
          l10n.dcCertFeeLine('$_certificationFee'),
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<int>(
          initialValue: _draft.certPayIndex,
          style: EjariColors.inputTextStyle,
          dropdownColor: EjariColors.card,
          iconEnabledColor: EjariColors.textSecondary,
          decoration: InputDecoration(
            labelText: l10n.dcPayMethodMock,
            border: const OutlineInputBorder(),
          ),
          items: [
            DropdownMenuItem(value: 0, child: Text(l10n.dcCertPayCard)),
            DropdownMenuItem(value: 1, child: Text(l10n.dcCertPayGovWallet)),
            DropdownMenuItem(value: 2, child: Text(l10n.dcCertPayInstant)),
          ],
          onChanged: (v) => setState(() => _draft.certPayIndex = v),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.dcAfterPayBlurb,
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget _sectionTitle(String t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        t,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: EjariColors.primary,
            ),
        textAlign: TextAlign.right,
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.step, required this.l10n});

  final int step;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final labels = [
      l10n.dcProgressLabelProperty,
      l10n.dcProgressLabelRent,
      l10n.dcProgressLabelParties,
      l10n.dcProgressLabelSign,
      l10n.dcProgressLabelPay,
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
      color: EjariColors.card,
      child: Column(
        children: [
          Row(
            children: List.generate(5, (i) {
              final done = i <= step;
              return Expanded(
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: i == 0 ? 0 : 4),
                  height: 4,
                  decoration: BoxDecoration(
                    color: done ? EjariColors.primary : EjariColors.borderSubtle,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.dcProgressStep('${step + 1}', labels[step]),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.step,
    required this.onBack,
    required this.onNext,
    required this.onIssueCertificate,
    required this.completeBusy,
    required this.completeLabel,
    required this.l10n,
  });

  final int step;
  final VoidCallback onBack;
  final VoidCallback? onNext;
  final Future<void> Function()? onIssueCertificate;
  final bool completeBusy;
  final String completeLabel;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: EjariColors.card,
                  foregroundColor: EjariColors.primary,
                  side: BorderSide(color: EjariColors.accent.withValues(alpha: 0.85)),
                ),
                onPressed: onBack,
                child: Text(step == 0 ? l10n.dcBarCancel : l10n.dcBarBack),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: step < 4
                  ? FilledButton(onPressed: onNext, child: Text(l10n.commonNext))
                  : FilledButton(
                      onPressed: completeBusy ? null : () => onIssueCertificate?.call(),
                      child: completeBusy
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2, color: EjariColors.onPrimaryFg),
                            )
                          : Text(completeLabel),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/models/contract_model.dart';
import 'package:ejari/state/ratings_notifier.dart';

final tenantContractNotifier = TenantContractNotifier();

/// يحتفظ بنسخة معدّلة من عقد المستأجِر النشط (بعد التجديد أو إتمام العقد الرقمي).
class TenantContractNotifier extends ChangeNotifier {
  ContractModel? _override;

  void reset() {
    _override = null;
    ratingsNotifier.resetSession();
    notifyListeners();
  }

  /// عقد المستأجِر مع إعادة حساب الأيام المتبقية حتى الانتهاء.
  ContractModel activeContract(String tenantId) {
    final merged = _override ?? mockActiveContractForTenant(tenantId);
    return _withComputedDays(merged);
  }

  ContractModel _withComputedDays(ContractModel c) {
    final end = c.leaseEndDate;
    if (end == null) return c;
    final days = end.difference(DateTime.now()).inDays;
    return ContractModel(
      id: c.id,
      tenantId: c.tenantId,
      propertyId: c.propertyId,
      status: c.status,
      monthlyRent: c.monthlyRent,
      addressLabel: c.addressLabel,
      daysUntilExpiry: days < 0 ? 0 : days,
      annualProgressDays: c.annualProgressDays,
      annualTotalDays: c.annualTotalDays,
      startYear: c.startYear,
      endYear: c.endYear,
      leaseStartDate: c.leaseStartDate,
      leaseEndDate: c.leaseEndDate,
      landlordId: c.landlordId,
      agencyId: c.agencyId,
      commissionRatePercent: c.commissionRatePercent,
      tenantName: c.tenantName,
      landlordName: c.landlordName,
      pdfUrl: c.pdfUrl,
    );
  }

  /// تحديث العقد النشط بعد إتمام مسار العقد الرقمي الموثّق (إنشاء أو تجديد) وإصدار الشهادة.
  void applyDigitalContractCompletion({
    required String tenantId,
    required String propertyId,
    required double monthlyRent,
    required DateTime leaseStart,
    required DateTime leaseEnd,
    required String addressLabel,
  }) {
    final base = _override ?? mockActiveContractForTenant(tenantId);
    final landlordFromProperty = propertyById(propertyId)?.ownerId;
    final totalDays = leaseEnd.difference(leaseStart).inDays;
    final progressRaw = DateTime.now().difference(leaseStart).inDays;
    final progress = progressRaw < 0
        ? 0
        : (progressRaw > totalDays ? totalDays : progressRaw);

    _override = ContractModel(
      id: base.id,
      tenantId: tenantId,
      propertyId: propertyId,
      status: 'active',
      monthlyRent: monthlyRent,
      addressLabel: addressLabel,
      daysUntilExpiry: 0,
      annualProgressDays: totalDays <= 0 ? 0 : progress,
      annualTotalDays: totalDays <= 0 ? 365 : totalDays,
      startYear: leaseStart.year,
      endYear: leaseEnd.year,
      leaseStartDate: leaseStart,
      leaseEndDate: leaseEnd,
      landlordId: landlordFromProperty ?? base.landlordId,
      agencyId: base.agencyId,
      commissionRatePercent: base.commissionRatePercent,
      tenantName: base.tenantName,
      landlordName: base.landlordName,
      pdfUrl: base.pdfUrl,
    );
    notifyListeners();
  }
}

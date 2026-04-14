class ContractModel {
  const ContractModel({
    required this.id,
    required this.tenantId,
    required this.propertyId,
    required this.status,
    required this.monthlyRent,
    required this.addressLabel,
    this.daysUntilExpiry = 0,
    this.annualProgressDays = 0,
    this.annualTotalDays = 365,
    this.startYear,
    this.endYear,
    this.leaseStartDate,
    this.leaseEndDate,
    this.landlordId,
    this.agencyId,
    this.commissionRatePercent,
    this.tenantName,
    this.landlordName,
    this.pdfUrl,
  });

  final String id;
  final String tenantId;
  final String propertyId;
  final String status;
  final double monthlyRent;
  final String addressLabel;
  final int daysUntilExpiry;
  final int annualProgressDays;
  final int annualTotalDays;
  final int? startYear;
  final int? endYear;
  final DateTime? leaseStartDate;
  final DateTime? leaseEndDate;
  /// يُحدَّد من العقاد أو من العقار عند الحاجة.
  final String? landlordId;
  final String? agencyId;
  /// نسبة عمولة المكتب (٪).
  final double? commissionRatePercent;
  final String? tenantName;
  final String? landlordName;
  /// رابط تحميل وثيقة العقد (وهمي).
  final String? pdfUrl;
}

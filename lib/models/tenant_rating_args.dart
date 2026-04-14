/// وسائط شاشة تقييم المستأجر (من المالك).
class TenantRatingArgs {
  const TenantRatingArgs({
    required this.tenantId,
    required this.tenantName,
    required this.contractId,
  });

  final String tenantId;
  final String tenantName;
  final String contractId;
}

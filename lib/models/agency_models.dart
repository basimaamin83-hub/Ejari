import 'package:flutter/foundation.dart';

/// طلب إيجار وارد على المكتب.
@immutable
class AgencyRentalRequest {
  const AgencyRentalRequest({
    required this.id,
    required this.agencyId,
    required this.tenantId,
    required this.tenantName,
    required this.propertyId,
    required this.propertyTitle,
    required this.submittedAt,
    required this.status,
  });

  final String id;
  final String agencyId;
  final String tenantId;
  final String tenantName;
  final String propertyId;
  final String propertyTitle;
  final DateTime submittedAt;
  /// pending | accepted | rejected
  final String status;
}

/// عقد أُنجز عبر المكتب (عرض للوحة المكتب).
@immutable
class AgencyContractRecord {
  const AgencyContractRecord({
    required this.id,
    required this.agencyId,
    required this.propertyTitle,
    required this.tenantName,
    required this.landlordName,
    required this.startDate,
    required this.endDate,
    required this.monthlyRent,
    required this.commissionPercent,
    required this.status,
    this.pdfUrl = 'https://ejari.jo/mock/contract.pdf',
    this.tenantId,
    this.landlordId,
  });

  final String id;
  final String agencyId;
  final String propertyTitle;
  final String tenantName;
  final String landlordName;
  final DateTime startDate;
  final DateTime endDate;
  final double monthlyRent;
  final double commissionPercent;
  /// active | expired
  final String status;
  final String? pdfUrl;
  final String? tenantId;
  final String? landlordId;
}

/// مالك يتعامل مع المكتب.
@immutable
class AgencyOwnerRecord {
  const AgencyOwnerRecord({
    required this.ownerId,
    required this.agencyId,
    required this.fullName,
    required this.phone,
    required this.managedPropertiesCount,
    required this.rating,
  });

  final String ownerId;
  final String agencyId;
  final String fullName;
  final String phone;
  final int managedPropertiesCount;
  final double rating;
}

/// سطر في سجل العمولات.
@immutable
class AgencyCommissionRecord {
  const AgencyCommissionRecord({
    required this.id,
    required this.agencyId,
    required this.contractDate,
    required this.propertyTitle,
    required this.landlordName,
    required this.annualRent,
    required this.commissionPercent,
    required this.amountDue,
    required this.paid,
    this.contractId,
  });

  final String id;
  final String agencyId;
  final DateTime contractDate;
  final String propertyTitle;
  final String landlordName;
  final double annualRent;
  final double commissionPercent;
  final double amountDue;
  final bool paid;
  /// ربط وهمي بعقد لإصدار فاتورة عمولة.
  final String? contractId;
}

/// طلب صيانة مرتبط بعقار يديره المكتب.
@immutable
class AgencyMaintenanceRequestModel {
  const AgencyMaintenanceRequestModel({
    required this.id,
    required this.propertyId,
    required this.tenantName,
    required this.description,
    required this.reportedAt,
    required this.status,
    this.imageFileName,
  });

  final String id;
  final String propertyId;
  final String tenantName;
  final String description;
  final DateTime reportedAt;
  /// وهمي: اسم ملف مرفوع.
  final String? imageFileName;
  /// open | in_progress | completed
  final String status;

  AgencyMaintenanceRequestModel copyWith({
    String? status,
    String? description,
    String? imageFileName,
  }) {
    return AgencyMaintenanceRequestModel(
      id: id,
      propertyId: propertyId,
      tenantName: tenantName,
      description: description ?? this.description,
      reportedAt: reportedAt,
      status: status ?? this.status,
      imageFileName: imageFileName ?? this.imageFileName,
    );
  }
}

/// سجل دفع إيجار (وهمي) لعقار مُدار.
@immutable
class AgencyRentPaymentRecord {
  const AgencyRentPaymentRecord({
    required this.id,
    required this.propertyId,
    required this.tenantName,
    required this.dueDate,
    required this.amount,
    this.paidDate,
    required this.isPaid,
  });

  final String id;
  final String propertyId;
  final String tenantName;
  final DateTime dueDate;
  final DateTime? paidDate;
  final double amount;
  final bool isPaid;
}

/// تذكير وهمي باستحقاق الإيجار (يُعرض كإشعار داخل التطبيق).
@immutable
class AgencyRentDueReminder {
  const AgencyRentDueReminder({
    required this.id,
    required this.agencyId,
    required this.propertyId,
    required this.propertyTitle,
    required this.tenantName,
    required this.dueDate,
  });

  final String id;
  final String agencyId;
  final String propertyId;
  final String propertyTitle;
  final String tenantName;
  final DateTime dueDate;
}

/// استشارة قانونية وهمية (سجل).
@immutable
class AgencyLegalConsultRecord {
  const AgencyLegalConsultRecord({
    required this.id,
    required this.agencyId,
    required this.issueType,
    required this.description,
    required this.submittedAt,
    required this.status,
  });

  final String id;
  final String agencyId;
  final String issueType;
  final String description;
  final DateTime submittedAt;
  final String status;
}

/// حالة عرض سجل دفع إيجار في الواجهة.
enum AgencyRentPaymentDisplayStatus { paid, pending, overdue }

/// طلب مساعدة في ترخيص بلدي (وهمي).
@immutable
class AgencyBusinessLicenseRequest {
  const AgencyBusinessLicenseRequest({
    required this.id,
    required this.agencyId,
    required this.propertyName,
    required this.businessActivity,
    required this.buildingNumber,
    required this.submittedAt,
    required this.status,
  });

  final String id;
  final String agencyId;
  final String propertyName;
  final String businessActivity;
  final String buildingNumber;
  final DateTime submittedAt;
  final String status;
}

/// تقييم للمكتب العقاري.
@immutable
class AgencyOfficeReview {
  const AgencyOfficeReview({
    required this.id,
    required this.agencyId,
    required this.authorName,
    required this.reviewedAt,
    required this.stars,
    this.comment,
  });

  final String id;
  final String agencyId;
  final String authorName;
  final DateTime reviewedAt;
  final int stars;
  final String? comment;
}

/// معلومات المكتب للإعدادات.
@immutable
class AgencyProfile {
  const AgencyProfile({
    required this.id,
    required this.name,
    required this.licenseNumber,
    required this.phone,
    required this.email,
    required this.address,
    required this.defaultCommissionPercent,
  });

  final String id;
  final String name;
  final String licenseNumber;
  final String phone;
  final String email;
  final String address;
  final double defaultCommissionPercent;
}

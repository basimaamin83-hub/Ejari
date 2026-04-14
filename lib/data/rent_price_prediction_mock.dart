import 'package:flutter/foundation.dart';
import 'package:ejari/l10n/app_localizations.dart';

/// طابق العقار ضمن نموذج التسعير الوهمي.
enum PredictionFloor {
  /// أرضي +0٪
  ground,

  /// أول +5٪
  first,

  /// ثاني +3٪
  second,

  /// ثالث (لم يُذكر في المواصفات؛ +2٪ معقول بين الثاني والسطح)
  third,

  /// سطح −5٪
  roof,

  /// فيلا مستقلة +15٪
  standaloneVilla,
}

extension PredictionFloorLabels on PredictionFloor {
  String get arabicLabel {
    switch (this) {
      case PredictionFloor.ground:
        return 'أرضي';
      case PredictionFloor.first:
        return 'أول';
      case PredictionFloor.second:
        return 'ثاني';
      case PredictionFloor.third:
        return 'ثالث';
      case PredictionFloor.roof:
        return 'سطح';
      case PredictionFloor.standaloneVilla:
        return 'فيلا مستقلة';
    }
  }

  /// نسبة التعديل على السعر (ليست مئوية خام؛ تُقسم على 100 عند التطبيق).
  double get percentAdjustment {
    switch (this) {
      case PredictionFloor.ground:
        return 0;
      case PredictionFloor.first:
        return 5;
      case PredictionFloor.second:
        return 3;
      case PredictionFloor.third:
        return 2;
      case PredictionFloor.roof:
        return -5;
      case PredictionFloor.standaloneVilla:
        return 15;
    }
  }
}

/// يحدد الطابق المناسب من نص العقار (للبطاقة في تفاصيل الإعلان).
PredictionFloor predictionFloorFromPropertyText(String title, List<String> tags) {
  final s = '$title ${tags.join(' ')}'.toLowerCase();
  if (s.contains('فيلا')) {
    return PredictionFloor.standaloneVilla;
  }
  if (s.contains('سطح') || s.contains('روف') || s.contains('roof')) {
    return PredictionFloor.roof;
  }
  if (s.contains('أرضي') || s.contains('ارضي') || s.contains('ارضى')) {
    return PredictionFloor.ground;
  }
  if (s.contains('ثالث') || s.contains('طابق ثالث')) {
    return PredictionFloor.third;
  }
  if (s.contains('ثاني') || s.contains('طابق ثاني')) {
    return PredictionFloor.second;
  }
  if (s.contains('أول') || s.contains('اول') || s.contains('طابق اول')) {
    return PredictionFloor.first;
  }
  return PredictionFloor.first;
}

@immutable
class RentPricePredictionResult {
  const RentPricePredictionResult({
    required this.predictedMonthlyJod,
    required this.rangeLowJod,
    required this.rangeHighJod,
    required this.confidencePercent,
    required this.usedDistrictData,
    required this.governorate,
    required this.district,
  });

  final double predictedMonthlyJod;
  final double rangeLowJod;
  final double rangeHighJod;
  final int confidencePercent;
  final bool usedDistrictData;
  final String governorate;
  final String district;
}

/// السعر الأساسي بعد العمر والطابق والتقييم والصيانة، قبل دمج الأسعار المرجعية (إن وُجدت).
double computePriceBeforeReferenceBlend({
  required double houseAreaSqm,
  required double outdoorAreaSqm,
  required int buildingAgeYears,
  required PredictionFloor floor,
  double? tenantRating, // 1–5، اختياري
  required int maintenanceCountForBonus,
}) {
  double base = houseAreaSqm * 0.5 + outdoorAreaSqm * 0.2;
  double p = base - 2 * buildingAgeYears;
  if (p < 0) {
    p = 0;
  }

  final floorFactor = 1 + floor.percentAdjustment / 100;
  p *= floorFactor;

  if (tenantRating != null) {
    final r = tenantRating.clamp(1.0, 5.0);
    if (r > 3) {
      p *= 1 + (r - 3) * 0.03;
    } else if (r < 3) {
      p *= 1 - (3 - r) * 0.05;
    }
  }

  final cappedMaint = maintenanceCountForBonus.clamp(0, 3);
  p += cappedMaint * 5;

  return p;
}

/// توقع وهمي كامل: يدمج متوسط الأسعار المرجعية عند وجودها (متوسط بين السعر المحسوب والمتوسط المرجعي).
double computeFairMonthlyPrice({
  required double houseAreaSqm,
  required double outdoorAreaSqm,
  required int buildingAgeYears,
  required PredictionFloor floor,
  double? tenantRating,
  required int maintenanceEntriesCount,
  List<double> referenceMonthlyPrices = const [],
}) {
  final beforeRef = computePriceBeforeReferenceBlend(
    houseAreaSqm: houseAreaSqm,
    outdoorAreaSqm: outdoorAreaSqm,
    buildingAgeYears: buildingAgeYears,
    floor: floor,
    tenantRating: tenantRating,
    maintenanceCountForBonus: maintenanceEntriesCount,
  );

  if (referenceMonthlyPrices.isEmpty) {
    return beforeRef;
  }

  final sum = referenceMonthlyPrices.fold<double>(0, (a, b) => a + b);
  final avgRef = sum / referenceMonthlyPrices.length;
  return (beforeRef + avgRef) / 2;
}

/// ملخص للمقارنة في بطاقة «هل السعر عادل؟» من تفاصيل العقار.
RentPricePredictionResult predictRentPriceForPropertyListing({
  required String governorate,
  required String district,
  required double houseAreaSqm,
  double outdoorAreaSqm = 0,
  int buildingAgeYears = 10,
  required PredictionFloor floor,
  double? tenantRating,
  int maintenanceCount = 0,
}) {
  final fair = computeFairMonthlyPrice(
    houseAreaSqm: houseAreaSqm,
    outdoorAreaSqm: outdoorAreaSqm,
    buildingAgeYears: buildingAgeYears,
    floor: floor,
    tenantRating: tenantRating,
    maintenanceEntriesCount: maintenanceCount,
    referenceMonthlyPrices: const [],
  );

  final low = fair * 0.9;
  final high = fair * 1.1;

  return RentPricePredictionResult(
    predictedMonthlyJod: fair,
    rangeLowJod: low,
    rangeHighJod: high,
    confidencePercent: 72,
    usedDistrictData: false,
    governorate: governorate,
    district: district,
  );
}

/// مقارنة سعر إعلان فعلي مع التوقع (لشاشة تفاصيل العقار).
String compareListingToPrediction({
  required double listingPriceMonthly,
  required RentPricePredictionResult prediction,
  required AppLocalizations l10n,
}) {
  if (listingPriceMonthly > prediction.rangeHighJod) {
    return l10n.compareAboveExpected;
  }
  if (listingPriceMonthly < prediction.rangeLowJod) {
    return l10n.compareBelowExpected;
  }
  return l10n.compareWithinExpected;
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get accountTypeTitle => 'اختر نوع الحساب';

  @override
  String get accountTypeSubtitle =>
      'سيتم استخدام هذا النوع لتخصيص واجهتك وصلاحياتك في التطبيق';

  @override
  String get accountTypeTenant => 'مستأجر';

  @override
  String get accountTypeOwner => 'مالك';

  @override
  String get accountTypeAgency => 'مكتب عقاري';

  @override
  String get registerAsGuest => 'تسجيل كزائر';

  @override
  String get appTitle => 'إيجاري';

  @override
  String get appTagline => 'إدارة وتوثيق عقود الإيجار في الأردن';

  @override
  String get loginWelcomeTitle => 'مرحباً بك في إيجاري';

  @override
  String get loginSubtitle => 'منصة توثيق عقود الإيجار الإلكترونية';

  @override
  String get loginViaSanad => 'تسجيل الدخول عبر سند';

  @override
  String get loginViaSanadHint => 'دخول آمن عبر الهوية الرقمية الأردنية';

  @override
  String get browseAsGuest => 'تصفح كزائر';

  @override
  String get loginSecureBanner =>
      'تسجيل الدخول آمن ومشفر — بياناتك محمية وفق السياسات الحكومية';

  @override
  String get tooltipSwitchLanguage => 'تبديل اللغة';

  @override
  String get languageEnglishShort => 'EN';

  @override
  String get languageArabicShort => 'عربي';

  @override
  String get commonOk => 'حسناً';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonError => 'خطأ';

  @override
  String get commonNotFound => 'غير موجود';

  @override
  String get commonUnauthorized => 'غير مصرح';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonSend => 'إرسال';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonEdit => 'تعديل';

  @override
  String get commonDetails => 'التفاصيل';

  @override
  String get commonMore => 'المزيد';

  @override
  String get commonNext => 'التالي';

  @override
  String get commonPrevious => 'السابق';

  @override
  String get commonSearch => 'بحث';

  @override
  String get commonFilter => 'تصفية';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get commonReview => 'مراجعة';

  @override
  String get commonNotifications => 'الإشعارات';

  @override
  String get commonProfile => 'الملف الشخصي';

  @override
  String get commonLogout => 'تسجيل الخروج';

  @override
  String get commonPhone => 'الهاتف';

  @override
  String get commonGuest => 'زائر';

  @override
  String get commonDays => 'يوم';

  @override
  String get commonDay => 'يوم';

  @override
  String get commonJod => 'د.أ';

  @override
  String get commonJodPerMonth => 'د.أ / شهر';

  @override
  String get commonPercent => '٪';

  @override
  String get commonLoading => 'جاري التحميل…';

  @override
  String get sanadTitle => 'التحقق عبر سند';

  @override
  String get sanadIntro =>
      'أدخل بيانات الهوية الرقمية كما في تطبيق سند (وضع تجريبي).';

  @override
  String get sanadNationalIdLabel => 'رقم الهوية الوطنية';

  @override
  String get sanadPasswordLabel => 'الرقم السري لسند';

  @override
  String get sanadPasswordHelper => 'أي قيمة مقبولة في الوضع التجريبي';

  @override
  String get sanadVerifyContinue => 'تحقق ومتابعة';

  @override
  String get sanadFooterNote =>
      'بعد التحقق ستختار نوع حسابك في إيجاري (مستأجر، مالك، أو مكتب عقاري).';

  @override
  String get sanadErrNationalId => 'أدخل رقم الهوية الوطنية كاملاً (10 أرقام).';

  @override
  String get sanadErrPassword => 'أدخل الرقم السري لسند (تجريبي).';

  @override
  String get sanadErrGeneric => 'تعذر إكمال التحقق. حاول مرة أخرى.';

  @override
  String get roleGuest => 'زائر';

  @override
  String get roleOwner => 'المالك';

  @override
  String get roleAgency => 'مكتب عقاري';

  @override
  String get roleTenant => 'المستأجر';

  @override
  String welcomeUser(Object name) {
    return 'مرحباً، $name';
  }

  @override
  String get ownerRoleLabel => 'مالك عقار';

  @override
  String get tenantFabNewContractTooltip => 'عقد إيجار رقمي جديد';

  @override
  String get notificationsSnackbar => 'الإشعارات';

  @override
  String get contractActive => 'نشط';

  @override
  String get contractMyCurrent => 'عقدي الحالي';

  @override
  String get labelAddress => 'العنوان: ';

  @override
  String get labelLandlord => 'المالك: ';

  @override
  String get labelMonthlyRentDinar => 'الإيجار الشهري: ';

  @override
  String labelMonthlyRentJod(Object amount) {
    return 'الإيجار الشهري: $amount دينار';
  }

  @override
  String get endsOn => 'ينتهي في: ';

  @override
  String annualProgress(Object current, Object total) {
    return 'التقدم السنوي: $current/$total يوم';
  }

  @override
  String get pastContracts => 'عقود سابقة';

  @override
  String get searchFindHome => 'ابحث عن مسكنك';

  @override
  String get searchDiscover => 'اكتشف أفضل الشقق المتاحة';

  @override
  String get aiPredictTitle => 'توقع سعر الشقة بالذكاء الاصطناعي';

  @override
  String get aiPredictSubtitle =>
      'تقدير حسب المساحة والطابق والعمر والصيانة والأسعار المرجعية';

  @override
  String get recentNotifications => 'الإشعارات الأخيرة';

  @override
  String get notifRentReceivedTitle => 'تم استلام إيجار شهر مارس';

  @override
  String get notifRentReceivedTime => 'منذ يومين';

  @override
  String get notifContractEndingTitle => 'تذكير: العقد ينتهي خلال 45 يوم';

  @override
  String get notifContractEndingTime => 'منذ أسبوع';

  @override
  String get quickRateLandlord => 'قيم المالك';

  @override
  String get quickRateLandlordSub => 'شارك تجربتك';

  @override
  String get quickRenewContract => 'تجديد العقد';

  @override
  String get quickRenewContractSub => 'جدد عقدك الآن';

  @override
  String get needActiveContract =>
      'يتطلب ذلك عقداً نشطاً. سجّل الدخول كمستأجر.';

  @override
  String get ownerStatRented => 'عقارات مؤجرة';

  @override
  String get ownerStatVacant => 'شاغرة';

  @override
  String get ownerStatTotalRent => 'إجمالي الإيجار';

  @override
  String get ownerMyRented => 'عقاراتي المؤجرة';

  @override
  String get ownerMyVacant => 'عقاراتي الشاغرة';

  @override
  String ownerProposedRent(Object amount) {
    return 'طلب إيجار مقترح: $amount د.أ';
  }

  @override
  String get rateTenant => 'قيّم المستأجر';

  @override
  String get publishProperty => 'نشر عقار';

  @override
  String get propertyNotFoundTitle => 'غير موجود';

  @override
  String get propertyNotFoundBody => 'العقار غير موجود';

  @override
  String get propertyAvailableNow => 'متاحة الآن';

  @override
  String get propertyNotAvailable => 'غير متاحة';

  @override
  String get propertyPricePerMonth => 'السعر / شهر';

  @override
  String get propertyArea => 'المساحة';

  @override
  String get propertyDescription => 'الوصف';

  @override
  String get propertyOwnerSection => 'مالك العقار';

  @override
  String get propertyCall => 'اتصل';

  @override
  String get propertyWhatsapp => 'واتساب';

  @override
  String get propertySubmitRentalRequest => 'تقدم بطلب إيجار';

  @override
  String get propertyTenantReviews => 'آراء المستأجرين';

  @override
  String get propertyIsPriceFair => 'هل السعر عادل؟';

  @override
  String propertyExpectedRange(Object low, Object high) {
    return 'النطاق المتوقع للمنطقة: $low–$high د.أ / شهر';
  }

  @override
  String get propertySmartPredictionDetails => 'تفاصيل التوقع الذكي';

  @override
  String propertyOwnerListingsCount(Object count) {
    return '· $count عقارات';
  }

  @override
  String propertyRoomsCount(Object n) {
    return '$n غرف';
  }

  @override
  String propertyBathsCount(Object n) {
    return '$n حمام';
  }

  @override
  String get searchAll => 'الكل';

  @override
  String get searchPageTitle => 'ابحث عن مسكنك';

  @override
  String get searchPageSubtitle => 'اكتشف أفضل الشقق المتاحة للإيجار في الأردن';

  @override
  String get searchBack => 'رجوع';

  @override
  String get searchFilterTooltip => 'تصفية';

  @override
  String get searchPricePredictTooltip => 'توقع السعر حسب المنطقة';

  @override
  String get searchFieldHint => 'ابحث بالمنطقة أو المدينة...';

  @override
  String searchDistrictLabel(Object district) {
    return 'المنطقة: $district';
  }

  @override
  String searchFoundCount(Object count) {
    return 'تم العثور على $count عقار';
  }

  @override
  String get searchOwnerRating => 'تقييم المالك';

  @override
  String get searchJodPerMonthShort => 'د.أ/شهر';

  @override
  String get rentalRequestErrorTitle => 'خطأ';

  @override
  String get rentalRequestTitle => 'طلب إيجار';

  @override
  String get rentalRequestSummary => 'ملخص الطلب';

  @override
  String get rentalRequestSentTitle => 'تم الإرسال';

  @override
  String get rentalRequestSentBody =>
      'تم استلام طلبك بنجاح. سيتواصل معك المالك أو المنصة قريباً.';

  @override
  String get rentalRequestSubmit => 'إرسال الطلب';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileNoUser => 'لا يوجد مستخدم مسجّل.';

  @override
  String get profileMyRatingsTitle => 'سجل تقييماتي';

  @override
  String get profileMyRatingsSubtitle => 'عرض سمعتك والتقييمات التي استلمتها';

  @override
  String get addPropertyTitle => 'إضافة عقار جديد';

  @override
  String get addPropertyPlaceholder =>
      'سيتم هنا لاحقاً إدخال عنوان العقار والسعر والصور والموقع على الخريطة.';

  @override
  String get addPropertyFieldLabel => 'عنوان العقار (تجريبي)';

  @override
  String get addPropertyClose => 'إغلاق';

  @override
  String get myRatingsTitle => 'سجل تقييماتي';

  @override
  String get myRatingsLoginRequired => 'سجّل الدخول لعرض تقييماتك.';

  @override
  String get myRatingsWrongAccount => 'لا يتوفر سجل لنوع حسابك.';

  @override
  String get myRatingsStarDistribution => 'توزيع النجوم';

  @override
  String get myRatingsAllReviews => 'جميع التقييمات';

  @override
  String get myRatingsEmpty => 'لا توجد تقييمات بعد.';

  @override
  String get myRatingsAverageGeneral => 'متوسط التقييم العام';

  @override
  String get myRatingsCriteriaAsLandlord => 'معايير تقييمك كمالك';

  @override
  String get myRatingsCriteriaAsTenant => 'معايير تقييمك كمستأجر';

  @override
  String get criteriaCooperation => 'التعاون والتواصل';

  @override
  String get criteriaMaintenance => 'صيانة العقار';

  @override
  String get criteriaResponsiveness => 'الاستجابة للطلبات';

  @override
  String get criteriaTransparency => 'الشفافية';

  @override
  String get criteriaPayment => 'الالتزام بالدفع';

  @override
  String get criteriaPropertyCare => 'المحافظة على العقار';

  @override
  String get criteriaTenantCooperation => 'التعاون';

  @override
  String get criteriaContractCompliance => 'الالتزام بالعقد';

  @override
  String get publicProfileTitle => 'الملف العام';

  @override
  String get publicProfileNotFound => 'المستخدم غير موجود.';

  @override
  String publicProfilePhone(Object phone) {
    return 'الهاتف: $phone';
  }

  @override
  String publicProfileReviewCount(Object count) {
    return '($count تقييم)';
  }

  @override
  String get publicProfilePropertyTitles =>
      'عناوين العقارات (بدون تفاصيل حساسة)';

  @override
  String publicProfileRoomCount(Object title, Object rooms) {
    return '$title — $rooms غرف';
  }

  @override
  String get publicProfileViewAllReviews => 'عرض كل التقييمات';

  @override
  String get publicAllReviewsTitle => 'كل التقييمات';

  @override
  String get publicNoReviews => 'لا توجد تقييمات.';

  @override
  String get landlordReviewsTitle => 'كل تقييمات المالك';

  @override
  String get sortNewest => 'الأحدث';

  @override
  String get sortHighestRating => 'الأعلى تقييماً';

  @override
  String get sortLowestRating => 'الأقل تقييماً';

  @override
  String get tenantReputationAvg => 'متوسط التقييم من 5';

  @override
  String get reportReviewTitle => 'إبلاغ عن تقييم مسيء';

  @override
  String get reportReviewBody =>
      'سيتم إرسال البلاغ لفريق إيجاري للمراجعة (تجريبي).';

  @override
  String get reportReviewHint => 'سبب البلاغ (اختياري)';

  @override
  String get reportReviewSubmit => 'إرسال';

  @override
  String reportReviewReceived(Object id) {
    return 'تم استلام البلاغ رقم #$id وسيتم مراجعته.';
  }

  @override
  String reportReviewReceivedWithNote(Object id, Object note) {
    return 'تم استلام البلاغ #$id: $note';
  }

  @override
  String get pricePredictionTitle => 'توقع سعر الإيجار بالذكاء الاصطناعي';

  @override
  String get pricePredictionIntro =>
      'توقع ذكي — أدخل المعايير أدناه لحساب سعر إيجار عادل تقريبي (نموذج وهمي).';

  @override
  String get pricePredictionHintAreaExample => 'مثال: 120';

  @override
  String get pricePredictionHintOutdoor => 'يمكن أن تكون 0';

  @override
  String get pricePredictionNoneNoEffect => 'بدون — لا يؤثر';

  @override
  String pricePredictionStarsOfFive(Object n) {
    return '$n من 5';
  }

  @override
  String get pricePredictionMaintHint => 'وصف بسيط، مثال: تبديل مكيف';

  @override
  String get pricePredictionDeleteTooltip => 'حذف';

  @override
  String get pricePredictionAddMaintenance => 'إضافة صيانة';

  @override
  String pricePredictionRefPriceHint(Object n) {
    return 'سعر $n';
  }

  @override
  String get pricePredictionAddRefPrice => 'إضافة سعر مرجعي';

  @override
  String get pricePredictionComputing => 'جاري الحساب...';

  @override
  String get pricePredictionPredict => 'توقع السعر';

  @override
  String get pricePredictionSmart => 'توقع ذكي';

  @override
  String pricePredictionFairExpected(Object amount) {
    return 'السعر العادل المتوقع: $amount دينار/شهر';
  }

  @override
  String get pricePredictionDisclaimer =>
      'الحساب وهمي ويُفترض إدخالاً دقيقاً؛ يُستخدم كدليل تقريبي فقط.';

  @override
  String get pricePredictionErrHouseArea =>
      'أدخل مساحة البيت بقيمة أكبر من صفر.';

  @override
  String get pricePredictionErrOutdoorNegative =>
      'مساحة الأرض حول المنزل لا يمكن أن تكون سالبة.';

  @override
  String get floorGround => 'أرضي';

  @override
  String get floorFirst => 'أول';

  @override
  String get floorSecond => 'ثاني';

  @override
  String get floorThird => 'ثالث';

  @override
  String get floorRoof => 'سطح';

  @override
  String get floorVilla => 'فيلا مستقلة';

  @override
  String get compareAboveExpected => 'أعلى من المتوقع';

  @override
  String get compareBelowExpected => 'أقل من المتوقع';

  @override
  String get compareWithinExpected => 'ضمن النطاق المتوقع';

  @override
  String get landlordRatingTitle => 'تقييم المالك';

  @override
  String get landlordRatingNoContract => 'لا يوجد عقد نشط لعرضه.';

  @override
  String get landlordRatingErrCriteria =>
      'يرجى اختيار جميع المعايير (نجمة واحدة على الأقل لكل بند)';

  @override
  String get landlordRatingErrDuplicate =>
      'تم تقييم هذا المالك على هذا العقد مسبقاً.';

  @override
  String get landlordRatingErrOwner => 'تعذر تحديد المالك من العقد.';

  @override
  String get landlordRatingSuccessTitle => 'تم';

  @override
  String get landlordRatingSuccessBody =>
      'تم إرسال تقييمك بنجاح وسيظهر في سجل المالك.';

  @override
  String get landlordRatingAnonymousTitle => 'إخفاء اسمي وعرض «مستخدم محظوظ»';

  @override
  String get landlordRatingSubmit => 'إرسال التقييم';

  @override
  String get tenantRatingTitle => 'تقييم المستأجر';

  @override
  String get tenantRatingErrOwnerOnly => 'يجب تسجيل الدخول كمالك.';

  @override
  String get tenantRatingErrCriteria => 'يرجى اختيار جميع المعايير.';

  @override
  String get tenantRatingErrDuplicate =>
      'تم تقييم هذا المستأجر على هذا العقد مسبقاً.';

  @override
  String get tenantRatingSuccessTitle => 'تم';

  @override
  String get tenantRatingSuccessBody =>
      'تم إرسال تقييمك بنجاح وسيظهر في سجل المستأجر.';

  @override
  String get tenantRatingSubmit => 'إرسال التقييم';

  @override
  String get agencyUnauthorized => 'غير مصرح';

  @override
  String get agencyContractsTitle => 'العقود';

  @override
  String agencyContractNumber(Object id) {
    return 'رقم العقد: $id';
  }

  @override
  String agencyPropertyLabel(Object title) {
    return 'العقار: $title';
  }

  @override
  String get agencyTenantLabel => 'المستأجر: ';

  @override
  String get agencyOwnerLabel => 'المالك: ';

  @override
  String get agencyContractStatusActive => 'نشط';

  @override
  String get agencyContractStatusEnded => 'منتهٍ';

  @override
  String agencyDateRange(Object start, Object end) {
    return 'من $start إلى $end';
  }

  @override
  String agencyMonthlyRent(Object amount) {
    return 'الإيجار الشهري: $amount د.أ';
  }

  @override
  String agencyCommissionPercent(Object p) {
    return 'نسبة العمولة: $p٪';
  }

  @override
  String agencyPdfSnack(Object url) {
    return 'تحميل PDF: $url';
  }

  @override
  String get agencyRenewMock => 'تجديد العقد بالنيابة (وهمي) — يُرسل للطرفين';

  @override
  String get agencyRenewContract => 'تجديد العقد';

  @override
  String get agencyPropertiesTitle => 'عقارات المكتب';

  @override
  String get agencyAddPropertyNew => 'إضافة عقار جديد';

  @override
  String get agencyVacant => 'شاغر';

  @override
  String get agencyRented => 'مؤجر';

  @override
  String get agencyEditMock => 'تعديل العقار (تجريبي)';

  @override
  String get agencyDeleteMock => 'حذف العقار (تجريبي)';

  @override
  String get agencyRequestTitle => 'طلب إيجار';

  @override
  String get agencyRequestNotFound => 'الطلب غير موجود';

  @override
  String get agencyRequestReviewTitle => 'مراجعة الطلب';

  @override
  String get agencyStatusPending => 'قيد المراجعة';

  @override
  String get agencyStatusAccepted => 'مقبول';

  @override
  String get agencyStatusRejected => 'مرفوض';

  @override
  String agencyPropertyLine(Object title) {
    return 'العقار: $title';
  }

  @override
  String agencyDateLine(Object date) {
    return 'التاريخ: $date';
  }

  @override
  String agencyStatusLine(Object status) {
    return 'الحالة: $status';
  }

  @override
  String get agencyTenantRecord => 'سجل المستأجر';

  @override
  String get agencyAcceptMock => 'تم قبول الطلب (وهمي)';

  @override
  String get agencyAccept => 'قبول';

  @override
  String get agencyRejectMock => 'تم رفض الطلب (وهمي)';

  @override
  String get agencyReject => 'رفض';

  @override
  String get agencyRequestsTitle => 'طلبات الإيجار';

  @override
  String get agencyOwnersTitle => 'المالكون';

  @override
  String get agencyAddOwner => 'إضافة مالك';

  @override
  String get agencyAddOwnerDialogTitle => 'إضافة مالك جديد';

  @override
  String get agencyAddOwnerDialogBody =>
      'أدخل رقم الهوية لجلب البيانات (وهمي).';

  @override
  String get agencyNationalIdLabel => 'رقم الهوية';

  @override
  String agencyFetchMock(Object id) {
    return 'تم جلب بيانات المالك وهمياً للهوية $id';
  }

  @override
  String get agencyFetchData => 'جلب البيانات';

  @override
  String get agencyDashboardTitle => 'مكتب عقاري';

  @override
  String get agencyDashboardNoOffice => 'لا يوجد مكتب مرتبط بحسابك.';

  @override
  String get agencyAddProperty => 'إضافة عقار';

  @override
  String get agencyShowAllProperties => 'عرض كل العقارات';

  @override
  String get agencyIncomingRequests => 'طلبات الإيجار الواردة';

  @override
  String get agencyShowAllRequests => 'عرض كل الطلبات';

  @override
  String get agencyContractsViaOffice => 'العقود عبر المكتب';

  @override
  String get agencyShowAll => 'عرض الكل';

  @override
  String get agencyCommissionLog => 'سجل العمولات';

  @override
  String get agencyShowFullLog => 'عرض السجل الكامل';

  @override
  String get agencyOfficeRating => 'تقييم المكتب';

  @override
  String get agencyShowAllReviews => 'عرض كل التقييمات';

  @override
  String get agencyReview => 'مراجعة';

  @override
  String agencyCommissionLine(Object p) {
    return 'عمولة $p٪';
  }

  @override
  String get agencyPdfOpenMock => 'سيتم فتح رابط PDF (تجريبي)';

  @override
  String agencyCommissionAmount(Object amount, Object state) {
    return '$amount د.أ — $state';
  }

  @override
  String get agencyPaid => 'مدفوع';

  @override
  String get agencyDue => 'مستحق';

  @override
  String get agencyAddPropertyScreenTitle => 'إضافة عقار للمكتب';

  @override
  String get agencyDelegatedOwner => 'المالك الموكل';

  @override
  String get agencySelectOwnerSnack => 'اختر المالك الموكل';

  @override
  String get agencySavePropertyMock => 'تم حفظ الطلب وهمياً — سيتم مراجعته';

  @override
  String get agencySaveProperty => 'حفظ العقار';

  @override
  String get agencyReviewsTitle => 'تقييمات المكتب';

  @override
  String get agencyAvgOfficeRating => 'متوسط تقييم المكتب';

  @override
  String get agencySettingsTitle => 'إعدادات المكتب';

  @override
  String get agencySettingsSavedMock => 'تم حفظ الإعدادات (وهمي)';

  @override
  String get agencyExportMock => 'تم تصدير التقرير (وهمي)';

  @override
  String get agencyExport => 'تصدير';

  @override
  String get agencyCommissionsTitle => 'سجل العمولات';

  @override
  String get agencyColContractDate => 'تاريخ العقد';

  @override
  String get agencyColProperty => 'العقار';

  @override
  String get agencyColAnnualRent => 'إيجار سنوي';

  @override
  String get agencyColCommissionPct => 'العمولة %';

  @override
  String get agencyColAmount => 'المبلغ';

  @override
  String get agencyColPayment => 'الدفع';

  @override
  String get digitalContractTitle => 'العقد الرقمي الموثّق';

  @override
  String get digitalContractTenantOnly =>
      'العقد الرقمي الموثّق متاح للمستأجرين. سجّل الدخول كمستأجر من الشاشة الرئيسية.';

  @override
  String get digitalContractRenewTitle => 'تجديد العقد الرقمي';

  @override
  String get digitalContractNewTitle => 'عقد إيجار رقمي موثّق';

  @override
  String get digitalContractIssueCert => 'إصدار الشهادة والتنزيل';

  @override
  String get dcStep1Title =>
      '1. معلومات العقار (دائرة الأراضي والمساحة — وهمي)';

  @override
  String get dcStep2Title => '2. تفاصيل الإيجار';

  @override
  String get dcStep3Title => '3. أطراف العقد (الهوية الرقمية — وهمي)';

  @override
  String get dcStep4Title => '4. معاينة العقد والتوقيع الإلكتروني';

  @override
  String get dcStep5Title => '5. رسوم التوثيق والدفع';

  @override
  String get dcLabelDeedRef => 'رقم صك الملكية / مرجع الوثيقة';

  @override
  String get dcLabelParcel => 'رقم القطعة / الحوض';

  @override
  String get dcSearchLand => 'بحث في السجلات (محاكاة)';

  @override
  String get dcSearchingLand => 'جاري البحث…';

  @override
  String get dcLandResultTitle => 'نتيجة الاستعلام';

  @override
  String dcLinkedIdMock(Object id) {
    return 'معرّف مرتبط (وهمي): $id';
  }

  @override
  String get dcSnackLandFetched =>
      'تم جلب بيانات العقار (محاكاة دائرة الأراضي).';

  @override
  String get dcSnackEnterNationalId => 'أدخل الرقم الوطني أولاً';

  @override
  String get dcSnackDigitalIdOk => 'تم الجلب من الهوية الرقمية (وهمي).';

  @override
  String get dcSnackDigitalIdFail => 'تعذر الجلب — تحقق من الرقم الوطني';

  @override
  String get dcSignDialogTitle => 'تأكيد الهوية للتوقيع';

  @override
  String get dcSignDialogBody =>
      'اختر وسيلة التحقق (وهمية). بعد التأكيد يُرسل إشعار للطرف الآخر لإتمام توقيعه وفق قانون المعاملات الإلكترونية.';

  @override
  String get dcAuthBiometric => 'بصمة';

  @override
  String get dcAuthOtp => 'رمز OTP';

  @override
  String get dcAuthPin => 'رمز سري';

  @override
  String get dcSignNow => 'توقيع الآن';

  @override
  String get dcSnackNotifyOther =>
      'تم التحقق. جاري إخطار الطرف الآخر لتوقيع العقد إلكترونياً (إشعار وهمي).';

  @override
  String get dcSnackOtherSigned =>
      'تم استلام توقيع الطرف الآخر (محاكاة). يمكنك المتابعة للدفع وإصدار الشهادة.';

  @override
  String get dcSnackDashboardUpdated => 'تم تحديث عقدك في لوحة التحكم.';

  @override
  String dcSnackCertFail(Object error) {
    return 'تعذر إصدار الشهادة: $error';
  }

  @override
  String get dcValidateLand =>
      'استخدم «بحث» لجلب بيانات العقار من دائرة الأراضي (وهمي).';

  @override
  String get dcValidateRent => 'أدخل إيجاراً شهرياً صالحاً';

  @override
  String get dcValidateDeposit => 'أدخل مبلغ تأمين صالحاً';

  @override
  String get dcValidateConfirmParties =>
      'أكّد بيانات المالك والمستأجر من الهوية الرقمية.';

  @override
  String get dcValidatePartyNames => 'أكمل بيانات الأطراف';

  @override
  String get dcValidateSignatures =>
      'أكمل التوقيع الإلكتروني وانتظر محاكاة توقيع الطرف الآخر';

  @override
  String get dcValidateCertPay => 'اختر طريقة دفع رسوم التوثيق';

  @override
  String get dcDurationLabel => 'مدة العقد';

  @override
  String get dcDurationOneYear => 'سنة واحدة';

  @override
  String get dcDurationTwoYears => 'سنتان';

  @override
  String get dcDurationThreeYears => '3 سنوات';

  @override
  String get dcMonthlyRentLabel => 'القيمة الإيجارية الشهرية (د.أ)';

  @override
  String get dcRentPaymentMethod => 'طريقة دفع الإيجار';

  @override
  String get dcDepositLabel => 'مبلغ التأمين (د.أ)';

  @override
  String get dcLeaseStartTitle => 'تاريخ بدء العقد';

  @override
  String dcLeaseEndComputed(Object date) {
    return 'تاريخ انتهاء العقد (محسوب): $date';
  }

  @override
  String get dcPartyOwnerTitle => 'بيانات المؤجر';

  @override
  String get dcPartyTenantTitle => 'بيانات المستأجر';

  @override
  String get dcPartiesIntro =>
      'تُسترد البيانات تلقائياً من نظام الهوية الرقمية لغايات التوثيق. يمكنك التأكيد بعد المراجعة.';

  @override
  String get dcFullName => 'الاسم الكامل';

  @override
  String get dcNationalId => 'الرقم الوطني';

  @override
  String get dcFetchDigitalId => 'جلب من الهوية الرقمية';

  @override
  String get dcConfirmData => 'أؤكد صحة البيانات المعروضة';

  @override
  String get dcPreviewIntro =>
      'النص أدناه يجمع البنود الأساسية المتفق عليها شائعاً في عقود الإيجار ومراعاة للإطار القانوني الأردني؛ يُستكمل لاحقاً بملاحق فنية حسب الحاجة.';

  @override
  String get dcSignNowButton => 'توقيع الآن';

  @override
  String get dcSigningStatusBoth => 'اكتمل التوقيع من الطرفين (محاكاة)';

  @override
  String get dcSigningStatusWait => 'بانتظار محاكاة توقيع الطرف الآخر…';

  @override
  String dcCertFeeLine(Object fee) {
    return 'رسوم إصدار شهادة «إيجاري» لهذا العقد: $fee د.أ (وهمي، ضمن النطاق 10–20 د.أ).';
  }

  @override
  String get dcPayMethodMock => 'طريقة الدفع (محاكاة)';

  @override
  String get dcAfterPayBlurb =>
      'بعد الدفع ستُنشأ «شهادة إيجاري» بصيغة PDF تحتوي على رمز QR للتحقق، ويُحدَّث عقدك في لوحة التحكم.';

  @override
  String dcProgressStep(Object step, Object label) {
    return 'الخطوة $step من 5 — $label';
  }

  @override
  String get dcProgressLabelProperty => 'العقار';

  @override
  String get dcProgressLabelRent => 'الإيجار';

  @override
  String get dcProgressLabelParties => 'الأطراف';

  @override
  String get dcProgressLabelSign => 'التوقيع';

  @override
  String get dcProgressLabelPay => 'الدفع';

  @override
  String get dcBarCancel => 'إلغاء';

  @override
  String get dcBarBack => 'السابق';

  @override
  String get dcRentPayBank => 'تحويل بنكي شهري';

  @override
  String get dcRentPayCash => 'كاش عند الاستحقاق';

  @override
  String get dcRentPayWallet => 'محفظة إلكترونية';

  @override
  String get dcCertPayCard => 'بطاقة بنكية (وهمي)';

  @override
  String get dcCertPayGovWallet => 'محفظة حكومية (وهمي)';

  @override
  String get dcCertPayInstant => 'تحويل فوري';

  @override
  String get dcConfirmSignDialogVerified =>
      'تم التحقق. جاري إخطار الطرف الآخر لتوقيع العقد إلكترونياً (إشعار وهمي).';

  @override
  String landlordReviewStars(Object n) {
    return '$n/5';
  }

  @override
  String get wordYear => 'سنة';

  @override
  String get wordYears => 'سنوات';
}

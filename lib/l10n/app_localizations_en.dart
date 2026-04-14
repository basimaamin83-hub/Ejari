// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get accountTypeTitle => 'Choose account type';

  @override
  String get accountTypeSubtitle =>
      'This selection customizes your interface and permissions in the app.';

  @override
  String get accountTypeTenant => 'Tenant';

  @override
  String get accountTypeOwner => 'Property owner';

  @override
  String get accountTypeAgency => 'Real estate agency';

  @override
  String get registerAsGuest => 'Continue as guest';

  @override
  String get appTitle => 'Ejari';

  @override
  String get appTagline => 'Manage and certify rental contracts in Jordan';

  @override
  String get loginWelcomeTitle => 'Welcome to Ejari';

  @override
  String get loginSubtitle =>
      'Electronic rental contract certification platform';

  @override
  String get loginViaSanad => 'Sign in with Sanad';

  @override
  String get loginViaSanadHint => 'Secure login via Jordan Digital Identity';

  @override
  String get browseAsGuest => 'Browse as guest';

  @override
  String get loginSecureBanner =>
      'Login is secure and encrypted — your data is protected under government policies';

  @override
  String get tooltipSwitchLanguage => 'Switch language';

  @override
  String get languageEnglishShort => 'EN';

  @override
  String get languageArabicShort => 'عربي';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonBack => 'Back';

  @override
  String get commonError => 'Error';

  @override
  String get commonNotFound => 'Not found';

  @override
  String get commonUnauthorized => 'Unauthorized';

  @override
  String get commonSave => 'Save';

  @override
  String get commonSend => 'Send';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonDetails => 'Details';

  @override
  String get commonMore => 'More';

  @override
  String get commonNext => 'Next';

  @override
  String get commonPrevious => 'Previous';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonFilter => 'Filter';

  @override
  String get commonClose => 'Close';

  @override
  String get commonReview => 'Review';

  @override
  String get commonNotifications => 'Notifications';

  @override
  String get commonProfile => 'Profile';

  @override
  String get commonLogout => 'Log out';

  @override
  String get commonPhone => 'Phone';

  @override
  String get commonGuest => 'Guest';

  @override
  String get commonDays => 'days';

  @override
  String get commonDay => 'day';

  @override
  String get commonJod => 'JOD';

  @override
  String get commonJodPerMonth => 'JOD / month';

  @override
  String get commonPercent => '%';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get sanadTitle => 'Verify with Sanad';

  @override
  String get sanadIntro =>
      'Enter your digital identity details as in the Sanad app (demo mode).';

  @override
  String get sanadNationalIdLabel => 'National ID number';

  @override
  String get sanadPasswordLabel => 'Sanad password';

  @override
  String get sanadPasswordHelper => 'Any value is accepted in demo mode';

  @override
  String get sanadVerifyContinue => 'Verify and continue';

  @override
  String get sanadFooterNote =>
      'After verification you will choose your Ejari account type (tenant, landlord, or agency).';

  @override
  String get sanadErrNationalId => 'Enter the full national ID (10 digits).';

  @override
  String get sanadErrPassword => 'Enter the Sanad password (demo).';

  @override
  String get sanadErrGeneric =>
      'Verification could not be completed. Try again.';

  @override
  String get roleGuest => 'Guest';

  @override
  String get roleOwner => 'Landlord';

  @override
  String get roleAgency => 'Real estate agency';

  @override
  String get roleTenant => 'Tenant';

  @override
  String welcomeUser(Object name) {
    return 'Hello, $name';
  }

  @override
  String get ownerRoleLabel => 'Property owner';

  @override
  String get tenantFabNewContractTooltip => 'New digital lease contract';

  @override
  String get notificationsSnackbar => 'Notifications';

  @override
  String get contractActive => 'Active';

  @override
  String get contractMyCurrent => 'My current contract';

  @override
  String get labelAddress => 'Address: ';

  @override
  String get labelLandlord => 'Landlord: ';

  @override
  String get labelMonthlyRentDinar => 'Monthly rent: ';

  @override
  String labelMonthlyRentJod(Object amount) {
    return 'Monthly rent: $amount JOD';
  }

  @override
  String get endsOn => 'Ends in: ';

  @override
  String annualProgress(Object current, Object total) {
    return 'Annual progress: $current/$total days';
  }

  @override
  String get pastContracts => 'Past contracts';

  @override
  String get searchFindHome => 'Find your home';

  @override
  String get searchDiscover => 'Discover the best available apartments';

  @override
  String get aiPredictTitle => 'Predict rent with AI';

  @override
  String get aiPredictSubtitle =>
      'Estimate from area, floor, age, maintenance, and reference prices';

  @override
  String get recentNotifications => 'Recent notifications';

  @override
  String get notifRentReceivedTitle => 'March rent received';

  @override
  String get notifRentReceivedTime => '2 days ago';

  @override
  String get notifContractEndingTitle => 'Reminder: contract ends in 45 days';

  @override
  String get notifContractEndingTime => 'A week ago';

  @override
  String get quickRateLandlord => 'Rate landlord';

  @override
  String get quickRateLandlordSub => 'Share your experience';

  @override
  String get quickRenewContract => 'Renew contract';

  @override
  String get quickRenewContractSub => 'Renew your contract now';

  @override
  String get needActiveContract =>
      'This requires an active contract. Sign in as a tenant.';

  @override
  String get ownerStatRented => 'Rented';

  @override
  String get ownerStatVacant => 'Vacant';

  @override
  String get ownerStatTotalRent => 'Total rent';

  @override
  String get ownerMyRented => 'My rented properties';

  @override
  String get ownerMyVacant => 'My vacant properties';

  @override
  String ownerProposedRent(Object amount) {
    return 'Suggested rent: $amount JOD';
  }

  @override
  String get rateTenant => 'Rate tenant';

  @override
  String get publishProperty => 'Publish listing';

  @override
  String get propertyNotFoundTitle => 'Not found';

  @override
  String get propertyNotFoundBody => 'Property not found';

  @override
  String get propertyAvailableNow => 'Available now';

  @override
  String get propertyNotAvailable => 'Not available';

  @override
  String get propertyPricePerMonth => 'Price / month';

  @override
  String get propertyArea => 'Area';

  @override
  String get propertyDescription => 'Description';

  @override
  String get propertyOwnerSection => 'Property owner';

  @override
  String get propertyCall => 'Call';

  @override
  String get propertyWhatsapp => 'WhatsApp';

  @override
  String get propertySubmitRentalRequest => 'Submit rental request';

  @override
  String get propertyTenantReviews => 'Tenant reviews';

  @override
  String get propertyIsPriceFair => 'Is the price fair?';

  @override
  String propertyExpectedRange(Object low, Object high) {
    return 'Expected range for the area: $low–$high JOD / month';
  }

  @override
  String get propertySmartPredictionDetails => 'Smart prediction details';

  @override
  String propertyOwnerListingsCount(Object count) {
    return '· $count listings';
  }

  @override
  String propertyRoomsCount(Object n) {
    return '$n rooms';
  }

  @override
  String propertyBathsCount(Object n) {
    return '$n baths';
  }

  @override
  String get searchAll => 'All';

  @override
  String get searchPageTitle => 'Find your home';

  @override
  String get searchPageSubtitle =>
      'Discover the best apartments for rent in Jordan';

  @override
  String get searchBack => 'Back';

  @override
  String get searchFilterTooltip => 'Filter';

  @override
  String get searchPricePredictTooltip => 'Predict price by area';

  @override
  String get searchFieldHint => 'Search by area or city…';

  @override
  String searchDistrictLabel(Object district) {
    return 'Area: $district';
  }

  @override
  String searchFoundCount(Object count) {
    return 'Found $count properties';
  }

  @override
  String get searchOwnerRating => 'Landlord rating';

  @override
  String get searchJodPerMonthShort => 'JOD/mo';

  @override
  String get rentalRequestErrorTitle => 'Error';

  @override
  String get rentalRequestTitle => 'Rental request';

  @override
  String get rentalRequestSummary => 'Request summary';

  @override
  String get rentalRequestSentTitle => 'Sent';

  @override
  String get rentalRequestSentBody =>
      'Your request was received. The owner or platform will contact you soon.';

  @override
  String get rentalRequestSubmit => 'Submit request';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileNoUser => 'No registered user.';

  @override
  String get profileMyRatingsTitle => 'My ratings';

  @override
  String get profileMyRatingsSubtitle =>
      'View your reputation and received ratings';

  @override
  String get addPropertyTitle => 'Add new property';

  @override
  String get addPropertyPlaceholder =>
      'Property address, price, photos, and map location will be entered here later.';

  @override
  String get addPropertyFieldLabel => 'Property title (demo)';

  @override
  String get addPropertyClose => 'Close';

  @override
  String get myRatingsTitle => 'My ratings';

  @override
  String get myRatingsLoginRequired => 'Sign in to view your ratings.';

  @override
  String get myRatingsWrongAccount => 'No history for your account type.';

  @override
  String get myRatingsStarDistribution => 'Star distribution';

  @override
  String get myRatingsAllReviews => 'All reviews';

  @override
  String get myRatingsEmpty => 'No ratings yet.';

  @override
  String get myRatingsAverageGeneral => 'Overall average';

  @override
  String get myRatingsCriteriaAsLandlord => 'Your criteria as landlord';

  @override
  String get myRatingsCriteriaAsTenant => 'Your criteria as tenant';

  @override
  String get criteriaCooperation => 'Cooperation & communication';

  @override
  String get criteriaMaintenance => 'Property maintenance';

  @override
  String get criteriaResponsiveness => 'Responsiveness';

  @override
  String get criteriaTransparency => 'Transparency';

  @override
  String get criteriaPayment => 'Payment timeliness';

  @override
  String get criteriaPropertyCare => 'Property care';

  @override
  String get criteriaTenantCooperation => 'Cooperation';

  @override
  String get criteriaContractCompliance => 'Contract compliance';

  @override
  String get publicProfileTitle => 'Public profile';

  @override
  String get publicProfileNotFound => 'User not found.';

  @override
  String publicProfilePhone(Object phone) {
    return 'Phone: $phone';
  }

  @override
  String publicProfileReviewCount(Object count) {
    return '($count reviews)';
  }

  @override
  String get publicProfilePropertyTitles =>
      'Property titles (no sensitive details)';

  @override
  String publicProfileRoomCount(Object title, Object rooms) {
    return '$title — $rooms rooms';
  }

  @override
  String get publicProfileViewAllReviews => 'View all reviews';

  @override
  String get publicAllReviewsTitle => 'All reviews';

  @override
  String get publicNoReviews => 'No reviews.';

  @override
  String get landlordReviewsTitle => 'All landlord reviews';

  @override
  String get sortNewest => 'Newest';

  @override
  String get sortHighestRating => 'Highest rating';

  @override
  String get sortLowestRating => 'Lowest rating';

  @override
  String get tenantReputationAvg => 'Average rating out of 5';

  @override
  String get reportReviewTitle => 'Report abusive review';

  @override
  String get reportReviewBody =>
      'The report will be sent to the Ejari team for review (demo).';

  @override
  String get reportReviewHint => 'Reason (optional)';

  @override
  String get reportReviewSubmit => 'Submit';

  @override
  String reportReviewReceived(Object id) {
    return 'Report #$id received and will be reviewed.';
  }

  @override
  String reportReviewReceivedWithNote(Object id, Object note) {
    return 'Report #$id: $note';
  }

  @override
  String get pricePredictionTitle => 'AI rent price prediction';

  @override
  String get pricePredictionIntro =>
      'Smart prediction — enter the criteria below for a fair approximate rent (mock model).';

  @override
  String get pricePredictionHintAreaExample => 'e.g. 120';

  @override
  String get pricePredictionHintOutdoor => 'Can be 0';

  @override
  String get pricePredictionNoneNoEffect => 'None — no effect';

  @override
  String pricePredictionStarsOfFive(Object n) {
    return '$n of 5';
  }

  @override
  String get pricePredictionMaintHint => 'Short description, e.g. AC service';

  @override
  String get pricePredictionDeleteTooltip => 'Remove';

  @override
  String get pricePredictionAddMaintenance => 'Add maintenance';

  @override
  String pricePredictionRefPriceHint(Object n) {
    return 'Price $n';
  }

  @override
  String get pricePredictionAddRefPrice => 'Add reference price';

  @override
  String get pricePredictionComputing => 'Computing…';

  @override
  String get pricePredictionPredict => 'Predict price';

  @override
  String get pricePredictionSmart => 'Smart prediction';

  @override
  String pricePredictionFairExpected(Object amount) {
    return 'Expected fair price: $amount JOD/month';
  }

  @override
  String get pricePredictionDisclaimer =>
      'The calculation is mock and assumes accurate input; use only as a rough guide.';

  @override
  String get pricePredictionErrHouseArea =>
      'Enter a house area greater than zero.';

  @override
  String get pricePredictionErrOutdoorNegative =>
      'Outdoor land area cannot be negative.';

  @override
  String get floorGround => 'Ground floor';

  @override
  String get floorFirst => 'First floor';

  @override
  String get floorSecond => 'Second floor';

  @override
  String get floorThird => 'Third floor';

  @override
  String get floorRoof => 'Roof / penthouse';

  @override
  String get floorVilla => 'Standalone villa';

  @override
  String get compareAboveExpected => 'Above expected range';

  @override
  String get compareBelowExpected => 'Below expected range';

  @override
  String get compareWithinExpected => 'Within expected range';

  @override
  String get landlordRatingTitle => 'Rate landlord';

  @override
  String get landlordRatingNoContract => 'No active contract to show.';

  @override
  String get landlordRatingErrCriteria =>
      'Please select all criteria (at least one star each).';

  @override
  String get landlordRatingErrDuplicate =>
      'You already rated this landlord for this contract.';

  @override
  String get landlordRatingErrOwner =>
      'Could not determine landlord from contract.';

  @override
  String get landlordRatingSuccessTitle => 'Done';

  @override
  String get landlordRatingSuccessBody =>
      'Your rating was sent and will appear in the landlord’s record.';

  @override
  String get landlordRatingAnonymousTitle =>
      'Hide my name and show “Lucky user”';

  @override
  String get landlordRatingSubmit => 'Submit rating';

  @override
  String get tenantRatingTitle => 'Rate tenant';

  @override
  String get tenantRatingErrOwnerOnly => 'You must be signed in as a landlord.';

  @override
  String get tenantRatingErrCriteria => 'Please select all criteria.';

  @override
  String get tenantRatingErrDuplicate =>
      'You already rated this tenant for this contract.';

  @override
  String get tenantRatingSuccessTitle => 'Done';

  @override
  String get tenantRatingSuccessBody =>
      'Your rating was sent and will appear in the tenant’s record.';

  @override
  String get tenantRatingSubmit => 'Submit rating';

  @override
  String get agencyUnauthorized => 'Unauthorized';

  @override
  String get agencyContractsTitle => 'Contracts';

  @override
  String agencyContractNumber(Object id) {
    return 'Contract #: $id';
  }

  @override
  String agencyPropertyLabel(Object title) {
    return 'Property: $title';
  }

  @override
  String get agencyTenantLabel => 'Tenant: ';

  @override
  String get agencyOwnerLabel => 'Owner: ';

  @override
  String get agencyContractStatusActive => 'Active';

  @override
  String get agencyContractStatusEnded => 'Ended';

  @override
  String agencyDateRange(Object start, Object end) {
    return 'From $start to $end';
  }

  @override
  String agencyMonthlyRent(Object amount) {
    return 'Monthly rent: $amount JOD';
  }

  @override
  String agencyCommissionPercent(Object p) {
    return 'Commission: $p%';
  }

  @override
  String agencyPdfSnack(Object url) {
    return 'Download PDF: $url';
  }

  @override
  String get agencyRenewMock =>
      'Renew contract on behalf (mock) — sent to both parties';

  @override
  String get agencyRenewContract => 'Renew contract';

  @override
  String get agencyPropertiesTitle => 'Office properties';

  @override
  String get agencyAddPropertyNew => 'Add new property';

  @override
  String get agencyVacant => 'Vacant';

  @override
  String get agencyRented => 'Rented';

  @override
  String get agencyEditMock => 'Edit property (demo)';

  @override
  String get agencyDeleteMock => 'Delete property (demo)';

  @override
  String get agencyRequestTitle => 'Rental request';

  @override
  String get agencyRequestNotFound => 'Request not found';

  @override
  String get agencyRequestReviewTitle => 'Review request';

  @override
  String get agencyStatusPending => 'Pending review';

  @override
  String get agencyStatusAccepted => 'Accepted';

  @override
  String get agencyStatusRejected => 'Rejected';

  @override
  String agencyPropertyLine(Object title) {
    return 'Property: $title';
  }

  @override
  String agencyDateLine(Object date) {
    return 'Date: $date';
  }

  @override
  String agencyStatusLine(Object status) {
    return 'Status: $status';
  }

  @override
  String get agencyTenantRecord => 'Tenant record';

  @override
  String get agencyAcceptMock => 'Request accepted (mock)';

  @override
  String get agencyAccept => 'Accept';

  @override
  String get agencyRejectMock => 'Request rejected (mock)';

  @override
  String get agencyReject => 'Reject';

  @override
  String get agencyRequestsTitle => 'Rental requests';

  @override
  String get agencyOwnersTitle => 'Owners';

  @override
  String get agencyAddOwner => 'Add owner';

  @override
  String get agencyAddOwnerDialogTitle => 'Add new owner';

  @override
  String get agencyAddOwnerDialogBody =>
      'Enter national ID to fetch data (mock).';

  @override
  String get agencyNationalIdLabel => 'National ID';

  @override
  String agencyFetchMock(Object id) {
    return 'Owner data loaded (mock) for ID $id';
  }

  @override
  String get agencyFetchData => 'Fetch data';

  @override
  String get agencyDashboardTitle => 'Real estate office';

  @override
  String get agencyDashboardNoOffice => 'No office linked to your account.';

  @override
  String get agencyAddProperty => 'Add property';

  @override
  String get agencyShowAllProperties => 'View all properties';

  @override
  String get agencyIncomingRequests => 'Incoming rental requests';

  @override
  String get agencyShowAllRequests => 'View all requests';

  @override
  String get agencyContractsViaOffice => 'Contracts via office';

  @override
  String get agencyShowAll => 'View all';

  @override
  String get agencyCommissionLog => 'Commission log';

  @override
  String get agencyShowFullLog => 'View full log';

  @override
  String get agencyOfficeRating => 'Office rating';

  @override
  String get agencyShowAllReviews => 'View all ratings';

  @override
  String get agencyReview => 'Review';

  @override
  String agencyCommissionLine(Object p) {
    return 'Commission $p%';
  }

  @override
  String get agencyPdfOpenMock => 'Opening PDF link (demo)';

  @override
  String agencyCommissionAmount(Object amount, Object state) {
    return '$amount JOD — $state';
  }

  @override
  String get agencyPaid => 'Paid';

  @override
  String get agencyDue => 'Due';

  @override
  String get agencyAddPropertyScreenTitle => 'Add property for office';

  @override
  String get agencyDelegatedOwner => 'Delegated owner';

  @override
  String get agencySelectOwnerSnack => 'Select delegated owner';

  @override
  String get agencySavePropertyMock => 'Request saved (mock) — pending review';

  @override
  String get agencySaveProperty => 'Save property';

  @override
  String get agencyReviewsTitle => 'Office reviews';

  @override
  String get agencyAvgOfficeRating => 'Office average rating';

  @override
  String get agencySettingsTitle => 'Office settings';

  @override
  String get agencySettingsSavedMock => 'Settings saved (mock)';

  @override
  String get agencyExportMock => 'Report exported (mock)';

  @override
  String get agencyExport => 'Export';

  @override
  String get agencyCommissionsTitle => 'Commission history';

  @override
  String get agencyColContractDate => 'Contract date';

  @override
  String get agencyColProperty => 'Property';

  @override
  String get agencyColAnnualRent => 'Annual rent';

  @override
  String get agencyColCommissionPct => 'Commission %';

  @override
  String get agencyColAmount => 'Amount';

  @override
  String get agencyColPayment => 'Payment';

  @override
  String get digitalContractTitle => 'Certified digital contract';

  @override
  String get digitalContractTenantOnly =>
      'The certified digital contract is available to tenants. Sign in as a tenant from the home screen.';

  @override
  String get digitalContractRenewTitle => 'Renew digital contract';

  @override
  String get digitalContractNewTitle => 'Certified digital lease';

  @override
  String get digitalContractIssueCert => 'Issue certificate & download';

  @override
  String get dcStep1Title => '1. Property info (Land Department — mock)';

  @override
  String get dcStep2Title => '2. Rent details';

  @override
  String get dcStep3Title => '3. Parties (Digital ID — mock)';

  @override
  String get dcStep4Title => '4. Contract preview & e-signature';

  @override
  String get dcStep5Title => '5. Certification fee & payment';

  @override
  String get dcLabelDeedRef => 'Deed / document reference';

  @override
  String get dcLabelParcel => 'Parcel / basin number';

  @override
  String get dcSearchLand => 'Search registry (simulation)';

  @override
  String get dcSearchingLand => 'Searching…';

  @override
  String get dcLandResultTitle => 'Lookup result';

  @override
  String dcLinkedIdMock(Object id) {
    return 'Linked ID (mock): $id';
  }

  @override
  String get dcSnackLandFetched =>
      'Property data loaded (Land Department simulation).';

  @override
  String get dcSnackEnterNationalId => 'Enter national ID first';

  @override
  String get dcSnackDigitalIdOk => 'Fetched from digital ID (mock).';

  @override
  String get dcSnackDigitalIdFail => 'Could not fetch — check national ID';

  @override
  String get dcSignDialogTitle => 'Confirm identity to sign';

  @override
  String get dcSignDialogBody =>
      'Choose a verification method (mock). After confirmation, the other party is notified to complete their signature per e-transactions law.';

  @override
  String get dcAuthBiometric => 'Biometric';

  @override
  String get dcAuthOtp => 'OTP code';

  @override
  String get dcAuthPin => 'PIN';

  @override
  String get dcSignNow => 'Sign now';

  @override
  String get dcSnackNotifyOther =>
      'Verified. Notifying the other party to sign electronically (mock).';

  @override
  String get dcSnackOtherSigned =>
      'Other party’s signature received (simulation). Continue to payment and certificate.';

  @override
  String get dcSnackDashboardUpdated =>
      'Your contract was updated on the dashboard.';

  @override
  String dcSnackCertFail(Object error) {
    return 'Could not issue certificate: $error';
  }

  @override
  String get dcValidateLand =>
      'Use “Search” to load property data from the Land Department (mock).';

  @override
  String get dcValidateRent => 'Enter a valid monthly rent';

  @override
  String get dcValidateDeposit => 'Enter a valid deposit amount';

  @override
  String get dcValidateConfirmParties =>
      'Confirm landlord and tenant data from digital ID.';

  @override
  String get dcValidatePartyNames => 'Complete party details';

  @override
  String get dcValidateSignatures =>
      'Complete e-signature and wait for the other party (simulation)';

  @override
  String get dcValidateCertPay => 'Select a certification fee payment method';

  @override
  String get dcDurationLabel => 'Contract duration';

  @override
  String get dcDurationOneYear => 'One year';

  @override
  String get dcDurationTwoYears => 'Two years';

  @override
  String get dcDurationThreeYears => '3 years';

  @override
  String get dcMonthlyRentLabel => 'Monthly rent (JOD)';

  @override
  String get dcRentPaymentMethod => 'Rent payment method';

  @override
  String get dcDepositLabel => 'Security deposit (JOD)';

  @override
  String get dcLeaseStartTitle => 'Lease start date';

  @override
  String dcLeaseEndComputed(Object date) {
    return 'Computed end date: $date';
  }

  @override
  String get dcPartyOwnerTitle => 'Landlord details';

  @override
  String get dcPartyTenantTitle => 'Tenant details';

  @override
  String get dcPartiesIntro =>
      'Data is retrieved automatically from the digital identity system for certification. Confirm after review.';

  @override
  String get dcFullName => 'Full name';

  @override
  String get dcNationalId => 'National ID';

  @override
  String get dcFetchDigitalId => 'Fetch from digital ID';

  @override
  String get dcConfirmData => 'I confirm the displayed data is correct';

  @override
  String get dcPreviewIntro =>
      'The text below summarizes common rental terms aligned with Jordanian law; technical schedules may be added later.';

  @override
  String get dcSignNowButton => 'Sign now';

  @override
  String get dcSigningStatusBoth =>
      'Signatures from both parties completed (simulation)';

  @override
  String get dcSigningStatusWait =>
      'Waiting for other party’s signature (simulation)…';

  @override
  String dcCertFeeLine(Object fee) {
    return 'Ejari certificate fee for this contract: $fee JOD (mock, range 10–20 JOD).';
  }

  @override
  String get dcPayMethodMock => 'Payment method (simulation)';

  @override
  String get dcAfterPayBlurb =>
      'After payment, an Ejari PDF certificate with QR verification is created and your dashboard contract is updated.';

  @override
  String dcProgressStep(Object step, Object label) {
    return 'Step $step of 5 — $label';
  }

  @override
  String get dcProgressLabelProperty => 'Property';

  @override
  String get dcProgressLabelRent => 'Rent';

  @override
  String get dcProgressLabelParties => 'Parties';

  @override
  String get dcProgressLabelSign => 'Signature';

  @override
  String get dcProgressLabelPay => 'Payment';

  @override
  String get dcBarCancel => 'Cancel';

  @override
  String get dcBarBack => 'Back';

  @override
  String get dcRentPayBank => 'Monthly bank transfer';

  @override
  String get dcRentPayCash => 'Cash when due';

  @override
  String get dcRentPayWallet => 'E-wallet';

  @override
  String get dcCertPayCard => 'Bank card (mock)';

  @override
  String get dcCertPayGovWallet => 'Government wallet (mock)';

  @override
  String get dcCertPayInstant => 'Instant transfer';

  @override
  String get dcConfirmSignDialogVerified =>
      'Verified. Notifying the other party to sign the contract electronically (mock).';

  @override
  String landlordReviewStars(Object n) {
    return '$n/5';
  }

  @override
  String get wordYear => 'year';

  @override
  String get wordYears => 'years';
}

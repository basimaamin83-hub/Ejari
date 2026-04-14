import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @accountTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose account type'**
  String get accountTypeTitle;

  /// No description provided for @accountTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This selection customizes your interface and permissions in the app.'**
  String get accountTypeSubtitle;

  /// No description provided for @accountTypeTenant.
  ///
  /// In en, this message translates to:
  /// **'Tenant'**
  String get accountTypeTenant;

  /// No description provided for @accountTypeOwner.
  ///
  /// In en, this message translates to:
  /// **'Property owner'**
  String get accountTypeOwner;

  /// No description provided for @accountTypeAgency.
  ///
  /// In en, this message translates to:
  /// **'Real estate agency'**
  String get accountTypeAgency;

  /// No description provided for @registerAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get registerAsGuest;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Ejari'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Manage and certify rental contracts in Jordan'**
  String get appTagline;

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Ejari'**
  String get loginWelcomeTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Electronic rental contract certification platform'**
  String get loginSubtitle;

  /// No description provided for @loginViaSanad.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Sanad'**
  String get loginViaSanad;

  /// No description provided for @loginViaSanadHint.
  ///
  /// In en, this message translates to:
  /// **'Secure login via Jordan Digital Identity'**
  String get loginViaSanadHint;

  /// No description provided for @browseAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Browse as guest'**
  String get browseAsGuest;

  /// No description provided for @loginSecureBanner.
  ///
  /// In en, this message translates to:
  /// **'Login is secure and encrypted — your data is protected under government policies'**
  String get loginSecureBanner;

  /// No description provided for @tooltipSwitchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get tooltipSwitchLanguage;

  /// No description provided for @languageEnglishShort.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get languageEnglishShort;

  /// No description provided for @languageArabicShort.
  ///
  /// In en, this message translates to:
  /// **'عربي'**
  String get languageArabicShort;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get commonError;

  /// No description provided for @commonNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get commonNotFound;

  /// No description provided for @commonUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get commonUnauthorized;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get commonSend;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get commonDetails;

  /// No description provided for @commonMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get commonMore;

  /// No description provided for @commonNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get commonNext;

  /// No description provided for @commonPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get commonPrevious;

  /// No description provided for @commonSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get commonSearch;

  /// No description provided for @commonFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get commonFilter;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get commonReview;

  /// No description provided for @commonNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get commonNotifications;

  /// No description provided for @commonProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get commonProfile;

  /// No description provided for @commonLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get commonLogout;

  /// No description provided for @commonPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get commonPhone;

  /// No description provided for @commonGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get commonGuest;

  /// No description provided for @commonDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get commonDays;

  /// No description provided for @commonDay.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get commonDay;

  /// No description provided for @commonJod.
  ///
  /// In en, this message translates to:
  /// **'JOD'**
  String get commonJod;

  /// No description provided for @commonJodPerMonth.
  ///
  /// In en, this message translates to:
  /// **'JOD / month'**
  String get commonJodPerMonth;

  /// No description provided for @commonPercent.
  ///
  /// In en, this message translates to:
  /// **'%'**
  String get commonPercent;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get commonLoading;

  /// No description provided for @sanadTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify with Sanad'**
  String get sanadTitle;

  /// No description provided for @sanadIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter your digital identity details as in the Sanad app (demo mode).'**
  String get sanadIntro;

  /// No description provided for @sanadNationalIdLabel.
  ///
  /// In en, this message translates to:
  /// **'National ID number'**
  String get sanadNationalIdLabel;

  /// No description provided for @sanadPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Sanad password'**
  String get sanadPasswordLabel;

  /// No description provided for @sanadPasswordHelper.
  ///
  /// In en, this message translates to:
  /// **'Any value is accepted in demo mode'**
  String get sanadPasswordHelper;

  /// No description provided for @sanadVerifyContinue.
  ///
  /// In en, this message translates to:
  /// **'Verify and continue'**
  String get sanadVerifyContinue;

  /// No description provided for @sanadFooterNote.
  ///
  /// In en, this message translates to:
  /// **'After verification you will choose your Ejari account type (tenant, landlord, or agency).'**
  String get sanadFooterNote;

  /// No description provided for @sanadErrNationalId.
  ///
  /// In en, this message translates to:
  /// **'Enter the full national ID (10 digits).'**
  String get sanadErrNationalId;

  /// No description provided for @sanadErrPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter the Sanad password (demo).'**
  String get sanadErrPassword;

  /// No description provided for @sanadErrGeneric.
  ///
  /// In en, this message translates to:
  /// **'Verification could not be completed. Try again.'**
  String get sanadErrGeneric;

  /// No description provided for @roleGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get roleGuest;

  /// No description provided for @roleOwner.
  ///
  /// In en, this message translates to:
  /// **'Landlord'**
  String get roleOwner;

  /// No description provided for @roleAgency.
  ///
  /// In en, this message translates to:
  /// **'Real estate agency'**
  String get roleAgency;

  /// No description provided for @roleTenant.
  ///
  /// In en, this message translates to:
  /// **'Tenant'**
  String get roleTenant;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String welcomeUser(Object name);

  /// No description provided for @ownerRoleLabel.
  ///
  /// In en, this message translates to:
  /// **'Property owner'**
  String get ownerRoleLabel;

  /// No description provided for @tenantFabNewContractTooltip.
  ///
  /// In en, this message translates to:
  /// **'New digital lease contract'**
  String get tenantFabNewContractTooltip;

  /// No description provided for @notificationsSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsSnackbar;

  /// No description provided for @contractActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get contractActive;

  /// No description provided for @contractMyCurrent.
  ///
  /// In en, this message translates to:
  /// **'My current contract'**
  String get contractMyCurrent;

  /// No description provided for @labelAddress.
  ///
  /// In en, this message translates to:
  /// **'Address: '**
  String get labelAddress;

  /// No description provided for @labelLandlord.
  ///
  /// In en, this message translates to:
  /// **'Landlord: '**
  String get labelLandlord;

  /// No description provided for @labelMonthlyRentDinar.
  ///
  /// In en, this message translates to:
  /// **'Monthly rent: '**
  String get labelMonthlyRentDinar;

  /// No description provided for @labelMonthlyRentJod.
  ///
  /// In en, this message translates to:
  /// **'Monthly rent: {amount} JOD'**
  String labelMonthlyRentJod(Object amount);

  /// No description provided for @endsOn.
  ///
  /// In en, this message translates to:
  /// **'Ends in: '**
  String get endsOn;

  /// No description provided for @annualProgress.
  ///
  /// In en, this message translates to:
  /// **'Annual progress: {current}/{total} days'**
  String annualProgress(Object current, Object total);

  /// No description provided for @pastContracts.
  ///
  /// In en, this message translates to:
  /// **'Past contracts'**
  String get pastContracts;

  /// No description provided for @searchFindHome.
  ///
  /// In en, this message translates to:
  /// **'Find your home'**
  String get searchFindHome;

  /// No description provided for @searchDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover the best available apartments'**
  String get searchDiscover;

  /// No description provided for @aiPredictTitle.
  ///
  /// In en, this message translates to:
  /// **'Predict rent with AI'**
  String get aiPredictTitle;

  /// No description provided for @aiPredictSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Estimate from area, floor, age, maintenance, and reference prices'**
  String get aiPredictSubtitle;

  /// No description provided for @recentNotifications.
  ///
  /// In en, this message translates to:
  /// **'Recent notifications'**
  String get recentNotifications;

  /// No description provided for @notifRentReceivedTitle.
  ///
  /// In en, this message translates to:
  /// **'March rent received'**
  String get notifRentReceivedTitle;

  /// No description provided for @notifRentReceivedTime.
  ///
  /// In en, this message translates to:
  /// **'2 days ago'**
  String get notifRentReceivedTime;

  /// No description provided for @notifContractEndingTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder: contract ends in 45 days'**
  String get notifContractEndingTitle;

  /// No description provided for @notifContractEndingTime.
  ///
  /// In en, this message translates to:
  /// **'A week ago'**
  String get notifContractEndingTime;

  /// No description provided for @quickRateLandlord.
  ///
  /// In en, this message translates to:
  /// **'Rate landlord'**
  String get quickRateLandlord;

  /// No description provided for @quickRateLandlordSub.
  ///
  /// In en, this message translates to:
  /// **'Share your experience'**
  String get quickRateLandlordSub;

  /// No description provided for @quickRenewContract.
  ///
  /// In en, this message translates to:
  /// **'Renew contract'**
  String get quickRenewContract;

  /// No description provided for @quickRenewContractSub.
  ///
  /// In en, this message translates to:
  /// **'Renew your contract now'**
  String get quickRenewContractSub;

  /// No description provided for @needActiveContract.
  ///
  /// In en, this message translates to:
  /// **'This requires an active contract. Sign in as a tenant.'**
  String get needActiveContract;

  /// No description provided for @ownerStatRented.
  ///
  /// In en, this message translates to:
  /// **'Rented'**
  String get ownerStatRented;

  /// No description provided for @ownerStatVacant.
  ///
  /// In en, this message translates to:
  /// **'Vacant'**
  String get ownerStatVacant;

  /// No description provided for @ownerStatTotalRent.
  ///
  /// In en, this message translates to:
  /// **'Total rent'**
  String get ownerStatTotalRent;

  /// No description provided for @ownerMyRented.
  ///
  /// In en, this message translates to:
  /// **'My rented properties'**
  String get ownerMyRented;

  /// No description provided for @ownerMyVacant.
  ///
  /// In en, this message translates to:
  /// **'My vacant properties'**
  String get ownerMyVacant;

  /// No description provided for @ownerProposedRent.
  ///
  /// In en, this message translates to:
  /// **'Suggested rent: {amount} JOD'**
  String ownerProposedRent(Object amount);

  /// No description provided for @rateTenant.
  ///
  /// In en, this message translates to:
  /// **'Rate tenant'**
  String get rateTenant;

  /// No description provided for @publishProperty.
  ///
  /// In en, this message translates to:
  /// **'Publish listing'**
  String get publishProperty;

  /// No description provided for @propertyNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get propertyNotFoundTitle;

  /// No description provided for @propertyNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'Property not found'**
  String get propertyNotFoundBody;

  /// No description provided for @propertyAvailableNow.
  ///
  /// In en, this message translates to:
  /// **'Available now'**
  String get propertyAvailableNow;

  /// No description provided for @propertyNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get propertyNotAvailable;

  /// No description provided for @propertyPricePerMonth.
  ///
  /// In en, this message translates to:
  /// **'Price / month'**
  String get propertyPricePerMonth;

  /// No description provided for @propertyArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get propertyArea;

  /// No description provided for @propertyDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get propertyDescription;

  /// No description provided for @propertyOwnerSection.
  ///
  /// In en, this message translates to:
  /// **'Property owner'**
  String get propertyOwnerSection;

  /// No description provided for @propertyCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get propertyCall;

  /// No description provided for @propertyWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get propertyWhatsapp;

  /// No description provided for @propertySubmitRentalRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit rental request'**
  String get propertySubmitRentalRequest;

  /// No description provided for @propertyTenantReviews.
  ///
  /// In en, this message translates to:
  /// **'Tenant reviews'**
  String get propertyTenantReviews;

  /// No description provided for @propertyIsPriceFair.
  ///
  /// In en, this message translates to:
  /// **'Is the price fair?'**
  String get propertyIsPriceFair;

  /// No description provided for @propertyExpectedRange.
  ///
  /// In en, this message translates to:
  /// **'Expected range for the area: {low}–{high} JOD / month'**
  String propertyExpectedRange(Object low, Object high);

  /// No description provided for @propertySmartPredictionDetails.
  ///
  /// In en, this message translates to:
  /// **'Smart prediction details'**
  String get propertySmartPredictionDetails;

  /// No description provided for @propertyOwnerListingsCount.
  ///
  /// In en, this message translates to:
  /// **'· {count} listings'**
  String propertyOwnerListingsCount(Object count);

  /// No description provided for @propertyRoomsCount.
  ///
  /// In en, this message translates to:
  /// **'{n} rooms'**
  String propertyRoomsCount(Object n);

  /// No description provided for @propertyBathsCount.
  ///
  /// In en, this message translates to:
  /// **'{n} baths'**
  String propertyBathsCount(Object n);

  /// No description provided for @searchAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get searchAll;

  /// No description provided for @searchPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Find your home'**
  String get searchPageTitle;

  /// No description provided for @searchPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover the best apartments for rent in Jordan'**
  String get searchPageSubtitle;

  /// No description provided for @searchBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get searchBack;

  /// No description provided for @searchFilterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get searchFilterTooltip;

  /// No description provided for @searchPricePredictTooltip.
  ///
  /// In en, this message translates to:
  /// **'Predict price by area'**
  String get searchPricePredictTooltip;

  /// No description provided for @searchFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Search by area or city…'**
  String get searchFieldHint;

  /// No description provided for @searchDistrictLabel.
  ///
  /// In en, this message translates to:
  /// **'Area: {district}'**
  String searchDistrictLabel(Object district);

  /// No description provided for @searchFoundCount.
  ///
  /// In en, this message translates to:
  /// **'Found {count} properties'**
  String searchFoundCount(Object count);

  /// No description provided for @searchOwnerRating.
  ///
  /// In en, this message translates to:
  /// **'Landlord rating'**
  String get searchOwnerRating;

  /// No description provided for @searchJodPerMonthShort.
  ///
  /// In en, this message translates to:
  /// **'JOD/mo'**
  String get searchJodPerMonthShort;

  /// No description provided for @rentalRequestErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get rentalRequestErrorTitle;

  /// No description provided for @rentalRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Rental request'**
  String get rentalRequestTitle;

  /// No description provided for @rentalRequestSummary.
  ///
  /// In en, this message translates to:
  /// **'Request summary'**
  String get rentalRequestSummary;

  /// No description provided for @rentalRequestSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get rentalRequestSentTitle;

  /// No description provided for @rentalRequestSentBody.
  ///
  /// In en, this message translates to:
  /// **'Your request was received. The owner or platform will contact you soon.'**
  String get rentalRequestSentBody;

  /// No description provided for @rentalRequestSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit request'**
  String get rentalRequestSubmit;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileNoUser.
  ///
  /// In en, this message translates to:
  /// **'No registered user.'**
  String get profileNoUser;

  /// No description provided for @profileMyRatingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My ratings'**
  String get profileMyRatingsTitle;

  /// No description provided for @profileMyRatingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View your reputation and received ratings'**
  String get profileMyRatingsSubtitle;

  /// No description provided for @addPropertyTitle.
  ///
  /// In en, this message translates to:
  /// **'Add new property'**
  String get addPropertyTitle;

  /// No description provided for @addPropertyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Property address, price, photos, and map location will be entered here later.'**
  String get addPropertyPlaceholder;

  /// No description provided for @addPropertyFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Property title (demo)'**
  String get addPropertyFieldLabel;

  /// No description provided for @addPropertyClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get addPropertyClose;

  /// No description provided for @myRatingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My ratings'**
  String get myRatingsTitle;

  /// No description provided for @myRatingsLoginRequired.
  ///
  /// In en, this message translates to:
  /// **'Sign in to view your ratings.'**
  String get myRatingsLoginRequired;

  /// No description provided for @myRatingsWrongAccount.
  ///
  /// In en, this message translates to:
  /// **'No history for your account type.'**
  String get myRatingsWrongAccount;

  /// No description provided for @myRatingsStarDistribution.
  ///
  /// In en, this message translates to:
  /// **'Star distribution'**
  String get myRatingsStarDistribution;

  /// No description provided for @myRatingsAllReviews.
  ///
  /// In en, this message translates to:
  /// **'All reviews'**
  String get myRatingsAllReviews;

  /// No description provided for @myRatingsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No ratings yet.'**
  String get myRatingsEmpty;

  /// No description provided for @myRatingsAverageGeneral.
  ///
  /// In en, this message translates to:
  /// **'Overall average'**
  String get myRatingsAverageGeneral;

  /// No description provided for @myRatingsCriteriaAsLandlord.
  ///
  /// In en, this message translates to:
  /// **'Your criteria as landlord'**
  String get myRatingsCriteriaAsLandlord;

  /// No description provided for @myRatingsCriteriaAsTenant.
  ///
  /// In en, this message translates to:
  /// **'Your criteria as tenant'**
  String get myRatingsCriteriaAsTenant;

  /// No description provided for @criteriaCooperation.
  ///
  /// In en, this message translates to:
  /// **'Cooperation & communication'**
  String get criteriaCooperation;

  /// No description provided for @criteriaMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Property maintenance'**
  String get criteriaMaintenance;

  /// No description provided for @criteriaResponsiveness.
  ///
  /// In en, this message translates to:
  /// **'Responsiveness'**
  String get criteriaResponsiveness;

  /// No description provided for @criteriaTransparency.
  ///
  /// In en, this message translates to:
  /// **'Transparency'**
  String get criteriaTransparency;

  /// No description provided for @criteriaPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment timeliness'**
  String get criteriaPayment;

  /// No description provided for @criteriaPropertyCare.
  ///
  /// In en, this message translates to:
  /// **'Property care'**
  String get criteriaPropertyCare;

  /// No description provided for @criteriaTenantCooperation.
  ///
  /// In en, this message translates to:
  /// **'Cooperation'**
  String get criteriaTenantCooperation;

  /// No description provided for @criteriaContractCompliance.
  ///
  /// In en, this message translates to:
  /// **'Contract compliance'**
  String get criteriaContractCompliance;

  /// No description provided for @publicProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Public profile'**
  String get publicProfileTitle;

  /// No description provided for @publicProfileNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get publicProfileNotFound;

  /// No description provided for @publicProfilePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone: {phone}'**
  String publicProfilePhone(Object phone);

  /// No description provided for @publicProfileReviewCount.
  ///
  /// In en, this message translates to:
  /// **'({count} reviews)'**
  String publicProfileReviewCount(Object count);

  /// No description provided for @publicProfilePropertyTitles.
  ///
  /// In en, this message translates to:
  /// **'Property titles (no sensitive details)'**
  String get publicProfilePropertyTitles;

  /// No description provided for @publicProfileRoomCount.
  ///
  /// In en, this message translates to:
  /// **'{title} — {rooms} rooms'**
  String publicProfileRoomCount(Object title, Object rooms);

  /// No description provided for @publicProfileViewAllReviews.
  ///
  /// In en, this message translates to:
  /// **'View all reviews'**
  String get publicProfileViewAllReviews;

  /// No description provided for @publicAllReviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'All reviews'**
  String get publicAllReviewsTitle;

  /// No description provided for @publicNoReviews.
  ///
  /// In en, this message translates to:
  /// **'No reviews.'**
  String get publicNoReviews;

  /// No description provided for @landlordReviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'All landlord reviews'**
  String get landlordReviewsTitle;

  /// No description provided for @sortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get sortNewest;

  /// No description provided for @sortHighestRating.
  ///
  /// In en, this message translates to:
  /// **'Highest rating'**
  String get sortHighestRating;

  /// No description provided for @sortLowestRating.
  ///
  /// In en, this message translates to:
  /// **'Lowest rating'**
  String get sortLowestRating;

  /// No description provided for @tenantReputationAvg.
  ///
  /// In en, this message translates to:
  /// **'Average rating out of 5'**
  String get tenantReputationAvg;

  /// No description provided for @reportReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Report abusive review'**
  String get reportReviewTitle;

  /// No description provided for @reportReviewBody.
  ///
  /// In en, this message translates to:
  /// **'The report will be sent to the Ejari team for review (demo).'**
  String get reportReviewBody;

  /// No description provided for @reportReviewHint.
  ///
  /// In en, this message translates to:
  /// **'Reason (optional)'**
  String get reportReviewHint;

  /// No description provided for @reportReviewSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get reportReviewSubmit;

  /// No description provided for @reportReviewReceived.
  ///
  /// In en, this message translates to:
  /// **'Report #{id} received and will be reviewed.'**
  String reportReviewReceived(Object id);

  /// No description provided for @reportReviewReceivedWithNote.
  ///
  /// In en, this message translates to:
  /// **'Report #{id}: {note}'**
  String reportReviewReceivedWithNote(Object id, Object note);

  /// No description provided for @pricePredictionTitle.
  ///
  /// In en, this message translates to:
  /// **'AI rent price prediction'**
  String get pricePredictionTitle;

  /// No description provided for @pricePredictionIntro.
  ///
  /// In en, this message translates to:
  /// **'Smart prediction — enter the criteria below for a fair approximate rent (mock model).'**
  String get pricePredictionIntro;

  /// No description provided for @pricePredictionHintAreaExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. 120'**
  String get pricePredictionHintAreaExample;

  /// No description provided for @pricePredictionHintOutdoor.
  ///
  /// In en, this message translates to:
  /// **'Can be 0'**
  String get pricePredictionHintOutdoor;

  /// No description provided for @pricePredictionNoneNoEffect.
  ///
  /// In en, this message translates to:
  /// **'None — no effect'**
  String get pricePredictionNoneNoEffect;

  /// No description provided for @pricePredictionStarsOfFive.
  ///
  /// In en, this message translates to:
  /// **'{n} of 5'**
  String pricePredictionStarsOfFive(Object n);

  /// No description provided for @pricePredictionMaintHint.
  ///
  /// In en, this message translates to:
  /// **'Short description, e.g. AC service'**
  String get pricePredictionMaintHint;

  /// No description provided for @pricePredictionDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get pricePredictionDeleteTooltip;

  /// No description provided for @pricePredictionAddMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Add maintenance'**
  String get pricePredictionAddMaintenance;

  /// No description provided for @pricePredictionRefPriceHint.
  ///
  /// In en, this message translates to:
  /// **'Price {n}'**
  String pricePredictionRefPriceHint(Object n);

  /// No description provided for @pricePredictionAddRefPrice.
  ///
  /// In en, this message translates to:
  /// **'Add reference price'**
  String get pricePredictionAddRefPrice;

  /// No description provided for @pricePredictionComputing.
  ///
  /// In en, this message translates to:
  /// **'Computing…'**
  String get pricePredictionComputing;

  /// No description provided for @pricePredictionPredict.
  ///
  /// In en, this message translates to:
  /// **'Predict price'**
  String get pricePredictionPredict;

  /// No description provided for @pricePredictionSmart.
  ///
  /// In en, this message translates to:
  /// **'Smart prediction'**
  String get pricePredictionSmart;

  /// No description provided for @pricePredictionFairExpected.
  ///
  /// In en, this message translates to:
  /// **'Expected fair price: {amount} JOD/month'**
  String pricePredictionFairExpected(Object amount);

  /// No description provided for @pricePredictionDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'The calculation is mock and assumes accurate input; use only as a rough guide.'**
  String get pricePredictionDisclaimer;

  /// No description provided for @pricePredictionErrHouseArea.
  ///
  /// In en, this message translates to:
  /// **'Enter a house area greater than zero.'**
  String get pricePredictionErrHouseArea;

  /// No description provided for @pricePredictionErrOutdoorNegative.
  ///
  /// In en, this message translates to:
  /// **'Outdoor land area cannot be negative.'**
  String get pricePredictionErrOutdoorNegative;

  /// No description provided for @floorGround.
  ///
  /// In en, this message translates to:
  /// **'Ground floor'**
  String get floorGround;

  /// No description provided for @floorFirst.
  ///
  /// In en, this message translates to:
  /// **'First floor'**
  String get floorFirst;

  /// No description provided for @floorSecond.
  ///
  /// In en, this message translates to:
  /// **'Second floor'**
  String get floorSecond;

  /// No description provided for @floorThird.
  ///
  /// In en, this message translates to:
  /// **'Third floor'**
  String get floorThird;

  /// No description provided for @floorRoof.
  ///
  /// In en, this message translates to:
  /// **'Roof / penthouse'**
  String get floorRoof;

  /// No description provided for @floorVilla.
  ///
  /// In en, this message translates to:
  /// **'Standalone villa'**
  String get floorVilla;

  /// No description provided for @compareAboveExpected.
  ///
  /// In en, this message translates to:
  /// **'Above expected range'**
  String get compareAboveExpected;

  /// No description provided for @compareBelowExpected.
  ///
  /// In en, this message translates to:
  /// **'Below expected range'**
  String get compareBelowExpected;

  /// No description provided for @compareWithinExpected.
  ///
  /// In en, this message translates to:
  /// **'Within expected range'**
  String get compareWithinExpected;

  /// No description provided for @landlordRatingTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate landlord'**
  String get landlordRatingTitle;

  /// No description provided for @landlordRatingNoContract.
  ///
  /// In en, this message translates to:
  /// **'No active contract to show.'**
  String get landlordRatingNoContract;

  /// No description provided for @landlordRatingErrCriteria.
  ///
  /// In en, this message translates to:
  /// **'Please select all criteria (at least one star each).'**
  String get landlordRatingErrCriteria;

  /// No description provided for @landlordRatingErrDuplicate.
  ///
  /// In en, this message translates to:
  /// **'You already rated this landlord for this contract.'**
  String get landlordRatingErrDuplicate;

  /// No description provided for @landlordRatingErrOwner.
  ///
  /// In en, this message translates to:
  /// **'Could not determine landlord from contract.'**
  String get landlordRatingErrOwner;

  /// No description provided for @landlordRatingSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get landlordRatingSuccessTitle;

  /// No description provided for @landlordRatingSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'Your rating was sent and will appear in the landlord’s record.'**
  String get landlordRatingSuccessBody;

  /// No description provided for @landlordRatingAnonymousTitle.
  ///
  /// In en, this message translates to:
  /// **'Hide my name and show “Lucky user”'**
  String get landlordRatingAnonymousTitle;

  /// No description provided for @landlordRatingSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit rating'**
  String get landlordRatingSubmit;

  /// No description provided for @tenantRatingTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate tenant'**
  String get tenantRatingTitle;

  /// No description provided for @tenantRatingErrOwnerOnly.
  ///
  /// In en, this message translates to:
  /// **'You must be signed in as a landlord.'**
  String get tenantRatingErrOwnerOnly;

  /// No description provided for @tenantRatingErrCriteria.
  ///
  /// In en, this message translates to:
  /// **'Please select all criteria.'**
  String get tenantRatingErrCriteria;

  /// No description provided for @tenantRatingErrDuplicate.
  ///
  /// In en, this message translates to:
  /// **'You already rated this tenant for this contract.'**
  String get tenantRatingErrDuplicate;

  /// No description provided for @tenantRatingSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get tenantRatingSuccessTitle;

  /// No description provided for @tenantRatingSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'Your rating was sent and will appear in the tenant’s record.'**
  String get tenantRatingSuccessBody;

  /// No description provided for @tenantRatingSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit rating'**
  String get tenantRatingSubmit;

  /// No description provided for @agencyUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get agencyUnauthorized;

  /// No description provided for @agencyContractsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contracts'**
  String get agencyContractsTitle;

  /// No description provided for @agencyContractNumber.
  ///
  /// In en, this message translates to:
  /// **'Contract #: {id}'**
  String agencyContractNumber(Object id);

  /// No description provided for @agencyPropertyLabel.
  ///
  /// In en, this message translates to:
  /// **'Property: {title}'**
  String agencyPropertyLabel(Object title);

  /// No description provided for @agencyTenantLabel.
  ///
  /// In en, this message translates to:
  /// **'Tenant: '**
  String get agencyTenantLabel;

  /// No description provided for @agencyOwnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner: '**
  String get agencyOwnerLabel;

  /// No description provided for @agencyContractStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get agencyContractStatusActive;

  /// No description provided for @agencyContractStatusEnded.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get agencyContractStatusEnded;

  /// No description provided for @agencyDateRange.
  ///
  /// In en, this message translates to:
  /// **'From {start} to {end}'**
  String agencyDateRange(Object start, Object end);

  /// No description provided for @agencyMonthlyRent.
  ///
  /// In en, this message translates to:
  /// **'Monthly rent: {amount} JOD'**
  String agencyMonthlyRent(Object amount);

  /// No description provided for @agencyCommissionPercent.
  ///
  /// In en, this message translates to:
  /// **'Commission: {p}%'**
  String agencyCommissionPercent(Object p);

  /// No description provided for @agencyPdfSnack.
  ///
  /// In en, this message translates to:
  /// **'Download PDF: {url}'**
  String agencyPdfSnack(Object url);

  /// No description provided for @agencyRenewMock.
  ///
  /// In en, this message translates to:
  /// **'Renew contract on behalf (mock) — sent to both parties'**
  String get agencyRenewMock;

  /// No description provided for @agencyRenewContract.
  ///
  /// In en, this message translates to:
  /// **'Renew contract'**
  String get agencyRenewContract;

  /// No description provided for @agencyPropertiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Office properties'**
  String get agencyPropertiesTitle;

  /// No description provided for @agencyAddPropertyNew.
  ///
  /// In en, this message translates to:
  /// **'Add new property'**
  String get agencyAddPropertyNew;

  /// No description provided for @agencyVacant.
  ///
  /// In en, this message translates to:
  /// **'Vacant'**
  String get agencyVacant;

  /// No description provided for @agencyRented.
  ///
  /// In en, this message translates to:
  /// **'Rented'**
  String get agencyRented;

  /// No description provided for @agencyEditMock.
  ///
  /// In en, this message translates to:
  /// **'Edit property (demo)'**
  String get agencyEditMock;

  /// No description provided for @agencyDeleteMock.
  ///
  /// In en, this message translates to:
  /// **'Delete property (demo)'**
  String get agencyDeleteMock;

  /// No description provided for @agencyRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Rental request'**
  String get agencyRequestTitle;

  /// No description provided for @agencyRequestNotFound.
  ///
  /// In en, this message translates to:
  /// **'Request not found'**
  String get agencyRequestNotFound;

  /// No description provided for @agencyRequestReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review request'**
  String get agencyRequestReviewTitle;

  /// No description provided for @agencyStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending review'**
  String get agencyStatusPending;

  /// No description provided for @agencyStatusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get agencyStatusAccepted;

  /// No description provided for @agencyStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get agencyStatusRejected;

  /// No description provided for @agencyPropertyLine.
  ///
  /// In en, this message translates to:
  /// **'Property: {title}'**
  String agencyPropertyLine(Object title);

  /// No description provided for @agencyDateLine.
  ///
  /// In en, this message translates to:
  /// **'Date: {date}'**
  String agencyDateLine(Object date);

  /// No description provided for @agencyStatusLine.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String agencyStatusLine(Object status);

  /// No description provided for @agencyTenantRecord.
  ///
  /// In en, this message translates to:
  /// **'Tenant record'**
  String get agencyTenantRecord;

  /// No description provided for @agencyAcceptMock.
  ///
  /// In en, this message translates to:
  /// **'Request accepted (mock)'**
  String get agencyAcceptMock;

  /// No description provided for @agencyAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get agencyAccept;

  /// No description provided for @agencyRejectMock.
  ///
  /// In en, this message translates to:
  /// **'Request rejected (mock)'**
  String get agencyRejectMock;

  /// No description provided for @agencyReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get agencyReject;

  /// No description provided for @agencyRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Rental requests'**
  String get agencyRequestsTitle;

  /// No description provided for @agencyOwnersTitle.
  ///
  /// In en, this message translates to:
  /// **'Owners'**
  String get agencyOwnersTitle;

  /// No description provided for @agencyAddOwner.
  ///
  /// In en, this message translates to:
  /// **'Add owner'**
  String get agencyAddOwner;

  /// No description provided for @agencyAddOwnerDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Add new owner'**
  String get agencyAddOwnerDialogTitle;

  /// No description provided for @agencyAddOwnerDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Enter national ID to fetch data (mock).'**
  String get agencyAddOwnerDialogBody;

  /// No description provided for @agencyNationalIdLabel.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get agencyNationalIdLabel;

  /// No description provided for @agencyFetchMock.
  ///
  /// In en, this message translates to:
  /// **'Owner data loaded (mock) for ID {id}'**
  String agencyFetchMock(Object id);

  /// No description provided for @agencyFetchData.
  ///
  /// In en, this message translates to:
  /// **'Fetch data'**
  String get agencyFetchData;

  /// No description provided for @agencyDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Real estate office'**
  String get agencyDashboardTitle;

  /// No description provided for @agencyDashboardNoOffice.
  ///
  /// In en, this message translates to:
  /// **'No office linked to your account.'**
  String get agencyDashboardNoOffice;

  /// No description provided for @agencyAddProperty.
  ///
  /// In en, this message translates to:
  /// **'Add property'**
  String get agencyAddProperty;

  /// No description provided for @agencyShowAllProperties.
  ///
  /// In en, this message translates to:
  /// **'View all properties'**
  String get agencyShowAllProperties;

  /// No description provided for @agencyIncomingRequests.
  ///
  /// In en, this message translates to:
  /// **'Incoming rental requests'**
  String get agencyIncomingRequests;

  /// No description provided for @agencyShowAllRequests.
  ///
  /// In en, this message translates to:
  /// **'View all requests'**
  String get agencyShowAllRequests;

  /// No description provided for @agencyContractsViaOffice.
  ///
  /// In en, this message translates to:
  /// **'Contracts via office'**
  String get agencyContractsViaOffice;

  /// No description provided for @agencyShowAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get agencyShowAll;

  /// No description provided for @agencyCommissionLog.
  ///
  /// In en, this message translates to:
  /// **'Commission log'**
  String get agencyCommissionLog;

  /// No description provided for @agencyShowFullLog.
  ///
  /// In en, this message translates to:
  /// **'View full log'**
  String get agencyShowFullLog;

  /// No description provided for @agencyOfficeRating.
  ///
  /// In en, this message translates to:
  /// **'Office rating'**
  String get agencyOfficeRating;

  /// No description provided for @agencyShowAllReviews.
  ///
  /// In en, this message translates to:
  /// **'View all ratings'**
  String get agencyShowAllReviews;

  /// No description provided for @agencyReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get agencyReview;

  /// No description provided for @agencyCommissionLine.
  ///
  /// In en, this message translates to:
  /// **'Commission {p}%'**
  String agencyCommissionLine(Object p);

  /// No description provided for @agencyPdfOpenMock.
  ///
  /// In en, this message translates to:
  /// **'Opening PDF link (demo)'**
  String get agencyPdfOpenMock;

  /// No description provided for @agencyCommissionAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} JOD — {state}'**
  String agencyCommissionAmount(Object amount, Object state);

  /// No description provided for @agencyPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get agencyPaid;

  /// No description provided for @agencyDue.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get agencyDue;

  /// No description provided for @agencyAddPropertyScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Add property for office'**
  String get agencyAddPropertyScreenTitle;

  /// No description provided for @agencyDelegatedOwner.
  ///
  /// In en, this message translates to:
  /// **'Delegated owner'**
  String get agencyDelegatedOwner;

  /// No description provided for @agencySelectOwnerSnack.
  ///
  /// In en, this message translates to:
  /// **'Select delegated owner'**
  String get agencySelectOwnerSnack;

  /// No description provided for @agencySavePropertyMock.
  ///
  /// In en, this message translates to:
  /// **'Request saved (mock) — pending review'**
  String get agencySavePropertyMock;

  /// No description provided for @agencySaveProperty.
  ///
  /// In en, this message translates to:
  /// **'Save property'**
  String get agencySaveProperty;

  /// No description provided for @agencyReviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Office reviews'**
  String get agencyReviewsTitle;

  /// No description provided for @agencyAvgOfficeRating.
  ///
  /// In en, this message translates to:
  /// **'Office average rating'**
  String get agencyAvgOfficeRating;

  /// No description provided for @agencySettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Office settings'**
  String get agencySettingsTitle;

  /// No description provided for @agencySettingsSavedMock.
  ///
  /// In en, this message translates to:
  /// **'Settings saved (mock)'**
  String get agencySettingsSavedMock;

  /// No description provided for @agencyExportMock.
  ///
  /// In en, this message translates to:
  /// **'Report exported (mock)'**
  String get agencyExportMock;

  /// No description provided for @agencyExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get agencyExport;

  /// No description provided for @agencyCommissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Commission history'**
  String get agencyCommissionsTitle;

  /// No description provided for @agencyColContractDate.
  ///
  /// In en, this message translates to:
  /// **'Contract date'**
  String get agencyColContractDate;

  /// No description provided for @agencyColProperty.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get agencyColProperty;

  /// No description provided for @agencyColAnnualRent.
  ///
  /// In en, this message translates to:
  /// **'Annual rent'**
  String get agencyColAnnualRent;

  /// No description provided for @agencyColCommissionPct.
  ///
  /// In en, this message translates to:
  /// **'Commission %'**
  String get agencyColCommissionPct;

  /// No description provided for @agencyColAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get agencyColAmount;

  /// No description provided for @agencyColPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get agencyColPayment;

  /// No description provided for @digitalContractTitle.
  ///
  /// In en, this message translates to:
  /// **'Certified digital contract'**
  String get digitalContractTitle;

  /// No description provided for @digitalContractTenantOnly.
  ///
  /// In en, this message translates to:
  /// **'The certified digital contract is available to tenants. Sign in as a tenant from the home screen.'**
  String get digitalContractTenantOnly;

  /// No description provided for @digitalContractRenewTitle.
  ///
  /// In en, this message translates to:
  /// **'Renew digital contract'**
  String get digitalContractRenewTitle;

  /// No description provided for @digitalContractNewTitle.
  ///
  /// In en, this message translates to:
  /// **'Certified digital lease'**
  String get digitalContractNewTitle;

  /// No description provided for @digitalContractIssueCert.
  ///
  /// In en, this message translates to:
  /// **'Issue certificate & download'**
  String get digitalContractIssueCert;

  /// No description provided for @dcStep1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Property info (Land Department — mock)'**
  String get dcStep1Title;

  /// No description provided for @dcStep2Title.
  ///
  /// In en, this message translates to:
  /// **'2. Rent details'**
  String get dcStep2Title;

  /// No description provided for @dcStep3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Parties (Digital ID — mock)'**
  String get dcStep3Title;

  /// No description provided for @dcStep4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Contract preview & e-signature'**
  String get dcStep4Title;

  /// No description provided for @dcStep5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Certification fee & payment'**
  String get dcStep5Title;

  /// No description provided for @dcLabelDeedRef.
  ///
  /// In en, this message translates to:
  /// **'Deed / document reference'**
  String get dcLabelDeedRef;

  /// No description provided for @dcLabelParcel.
  ///
  /// In en, this message translates to:
  /// **'Parcel / basin number'**
  String get dcLabelParcel;

  /// No description provided for @dcSearchLand.
  ///
  /// In en, this message translates to:
  /// **'Search registry (simulation)'**
  String get dcSearchLand;

  /// No description provided for @dcSearchingLand.
  ///
  /// In en, this message translates to:
  /// **'Searching…'**
  String get dcSearchingLand;

  /// No description provided for @dcLandResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Lookup result'**
  String get dcLandResultTitle;

  /// No description provided for @dcLinkedIdMock.
  ///
  /// In en, this message translates to:
  /// **'Linked ID (mock): {id}'**
  String dcLinkedIdMock(Object id);

  /// No description provided for @dcSnackLandFetched.
  ///
  /// In en, this message translates to:
  /// **'Property data loaded (Land Department simulation).'**
  String get dcSnackLandFetched;

  /// No description provided for @dcSnackEnterNationalId.
  ///
  /// In en, this message translates to:
  /// **'Enter national ID first'**
  String get dcSnackEnterNationalId;

  /// No description provided for @dcSnackDigitalIdOk.
  ///
  /// In en, this message translates to:
  /// **'Fetched from digital ID (mock).'**
  String get dcSnackDigitalIdOk;

  /// No description provided for @dcSnackDigitalIdFail.
  ///
  /// In en, this message translates to:
  /// **'Could not fetch — check national ID'**
  String get dcSnackDigitalIdFail;

  /// No description provided for @dcSignDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm identity to sign'**
  String get dcSignDialogTitle;

  /// No description provided for @dcSignDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Choose a verification method (mock). After confirmation, the other party is notified to complete their signature per e-transactions law.'**
  String get dcSignDialogBody;

  /// No description provided for @dcAuthBiometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric'**
  String get dcAuthBiometric;

  /// No description provided for @dcAuthOtp.
  ///
  /// In en, this message translates to:
  /// **'OTP code'**
  String get dcAuthOtp;

  /// No description provided for @dcAuthPin.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get dcAuthPin;

  /// No description provided for @dcSignNow.
  ///
  /// In en, this message translates to:
  /// **'Sign now'**
  String get dcSignNow;

  /// No description provided for @dcSnackNotifyOther.
  ///
  /// In en, this message translates to:
  /// **'Verified. Notifying the other party to sign electronically (mock).'**
  String get dcSnackNotifyOther;

  /// No description provided for @dcSnackOtherSigned.
  ///
  /// In en, this message translates to:
  /// **'Other party’s signature received (simulation). Continue to payment and certificate.'**
  String get dcSnackOtherSigned;

  /// No description provided for @dcSnackDashboardUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your contract was updated on the dashboard.'**
  String get dcSnackDashboardUpdated;

  /// No description provided for @dcSnackCertFail.
  ///
  /// In en, this message translates to:
  /// **'Could not issue certificate: {error}'**
  String dcSnackCertFail(Object error);

  /// No description provided for @dcValidateLand.
  ///
  /// In en, this message translates to:
  /// **'Use “Search” to load property data from the Land Department (mock).'**
  String get dcValidateLand;

  /// No description provided for @dcValidateRent.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid monthly rent'**
  String get dcValidateRent;

  /// No description provided for @dcValidateDeposit.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid deposit amount'**
  String get dcValidateDeposit;

  /// No description provided for @dcValidateConfirmParties.
  ///
  /// In en, this message translates to:
  /// **'Confirm landlord and tenant data from digital ID.'**
  String get dcValidateConfirmParties;

  /// No description provided for @dcValidatePartyNames.
  ///
  /// In en, this message translates to:
  /// **'Complete party details'**
  String get dcValidatePartyNames;

  /// No description provided for @dcValidateSignatures.
  ///
  /// In en, this message translates to:
  /// **'Complete e-signature and wait for the other party (simulation)'**
  String get dcValidateSignatures;

  /// No description provided for @dcValidateCertPay.
  ///
  /// In en, this message translates to:
  /// **'Select a certification fee payment method'**
  String get dcValidateCertPay;

  /// No description provided for @dcDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Contract duration'**
  String get dcDurationLabel;

  /// No description provided for @dcDurationOneYear.
  ///
  /// In en, this message translates to:
  /// **'One year'**
  String get dcDurationOneYear;

  /// No description provided for @dcDurationTwoYears.
  ///
  /// In en, this message translates to:
  /// **'Two years'**
  String get dcDurationTwoYears;

  /// No description provided for @dcDurationThreeYears.
  ///
  /// In en, this message translates to:
  /// **'3 years'**
  String get dcDurationThreeYears;

  /// No description provided for @dcMonthlyRentLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly rent (JOD)'**
  String get dcMonthlyRentLabel;

  /// No description provided for @dcRentPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Rent payment method'**
  String get dcRentPaymentMethod;

  /// No description provided for @dcDepositLabel.
  ///
  /// In en, this message translates to:
  /// **'Security deposit (JOD)'**
  String get dcDepositLabel;

  /// No description provided for @dcLeaseStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Lease start date'**
  String get dcLeaseStartTitle;

  /// No description provided for @dcLeaseEndComputed.
  ///
  /// In en, this message translates to:
  /// **'Computed end date: {date}'**
  String dcLeaseEndComputed(Object date);

  /// No description provided for @dcPartyOwnerTitle.
  ///
  /// In en, this message translates to:
  /// **'Landlord details'**
  String get dcPartyOwnerTitle;

  /// No description provided for @dcPartyTenantTitle.
  ///
  /// In en, this message translates to:
  /// **'Tenant details'**
  String get dcPartyTenantTitle;

  /// No description provided for @dcPartiesIntro.
  ///
  /// In en, this message translates to:
  /// **'Data is retrieved automatically from the digital identity system for certification. Confirm after review.'**
  String get dcPartiesIntro;

  /// No description provided for @dcFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get dcFullName;

  /// No description provided for @dcNationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get dcNationalId;

  /// No description provided for @dcFetchDigitalId.
  ///
  /// In en, this message translates to:
  /// **'Fetch from digital ID'**
  String get dcFetchDigitalId;

  /// No description provided for @dcConfirmData.
  ///
  /// In en, this message translates to:
  /// **'I confirm the displayed data is correct'**
  String get dcConfirmData;

  /// No description provided for @dcPreviewIntro.
  ///
  /// In en, this message translates to:
  /// **'The text below summarizes common rental terms aligned with Jordanian law; technical schedules may be added later.'**
  String get dcPreviewIntro;

  /// No description provided for @dcSignNowButton.
  ///
  /// In en, this message translates to:
  /// **'Sign now'**
  String get dcSignNowButton;

  /// No description provided for @dcSigningStatusBoth.
  ///
  /// In en, this message translates to:
  /// **'Signatures from both parties completed (simulation)'**
  String get dcSigningStatusBoth;

  /// No description provided for @dcSigningStatusWait.
  ///
  /// In en, this message translates to:
  /// **'Waiting for other party’s signature (simulation)…'**
  String get dcSigningStatusWait;

  /// No description provided for @dcCertFeeLine.
  ///
  /// In en, this message translates to:
  /// **'Ejari certificate fee for this contract: {fee} JOD (mock, range 10–20 JOD).'**
  String dcCertFeeLine(Object fee);

  /// No description provided for @dcPayMethodMock.
  ///
  /// In en, this message translates to:
  /// **'Payment method (simulation)'**
  String get dcPayMethodMock;

  /// No description provided for @dcAfterPayBlurb.
  ///
  /// In en, this message translates to:
  /// **'After payment, an Ejari PDF certificate with QR verification is created and your dashboard contract is updated.'**
  String get dcAfterPayBlurb;

  /// No description provided for @dcProgressStep.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of 5 — {label}'**
  String dcProgressStep(Object step, Object label);

  /// No description provided for @dcProgressLabelProperty.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get dcProgressLabelProperty;

  /// No description provided for @dcProgressLabelRent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get dcProgressLabelRent;

  /// No description provided for @dcProgressLabelParties.
  ///
  /// In en, this message translates to:
  /// **'Parties'**
  String get dcProgressLabelParties;

  /// No description provided for @dcProgressLabelSign.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get dcProgressLabelSign;

  /// No description provided for @dcProgressLabelPay.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get dcProgressLabelPay;

  /// No description provided for @dcBarCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dcBarCancel;

  /// No description provided for @dcBarBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get dcBarBack;

  /// No description provided for @dcRentPayBank.
  ///
  /// In en, this message translates to:
  /// **'Monthly bank transfer'**
  String get dcRentPayBank;

  /// No description provided for @dcRentPayCash.
  ///
  /// In en, this message translates to:
  /// **'Cash when due'**
  String get dcRentPayCash;

  /// No description provided for @dcRentPayWallet.
  ///
  /// In en, this message translates to:
  /// **'E-wallet'**
  String get dcRentPayWallet;

  /// No description provided for @dcCertPayCard.
  ///
  /// In en, this message translates to:
  /// **'Bank card (mock)'**
  String get dcCertPayCard;

  /// No description provided for @dcCertPayGovWallet.
  ///
  /// In en, this message translates to:
  /// **'Government wallet (mock)'**
  String get dcCertPayGovWallet;

  /// No description provided for @dcCertPayInstant.
  ///
  /// In en, this message translates to:
  /// **'Instant transfer'**
  String get dcCertPayInstant;

  /// No description provided for @dcConfirmSignDialogVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified. Notifying the other party to sign the contract electronically (mock).'**
  String get dcConfirmSignDialogVerified;

  /// No description provided for @landlordReviewStars.
  ///
  /// In en, this message translates to:
  /// **'{n}/5'**
  String landlordReviewStars(Object n);

  /// No description provided for @wordYear.
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get wordYear;

  /// No description provided for @wordYears.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get wordYears;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

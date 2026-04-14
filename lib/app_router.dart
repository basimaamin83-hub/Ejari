import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/screens/add_property_screen.dart';
import 'package:ejari/models/digital_contract_wizard_args.dart';
import 'package:ejari/models/tenant_rating_args.dart';
import 'package:ejari/screens/digital_contract_wizard_screen.dart';
import 'package:ejari/screens/landlord_rating_screen.dart';
import 'package:ejari/screens/landlord_reviews_full_screen.dart';
import 'package:ejari/screens/login_screen.dart';
import 'package:ejari/screens/sanad_verification_screen.dart';
import 'package:ejari/screens/account_type_selection_screen.dart';
import 'package:ejari/screens/my_ratings_screen.dart';
import 'package:ejari/screens/profile_screen.dart';
import 'package:ejari/screens/splash_screen.dart';
import 'package:ejari/screens/owner_dashboard_screen.dart';
import 'package:ejari/screens/property_detail_screen.dart';
import 'package:ejari/screens/property_search_screen.dart';
import 'package:ejari/screens/rental_request_screen.dart';
import 'package:ejari/screens/tenant_rating_screen.dart';
import 'package:ejari/state/ratings_notifier.dart';
import 'package:ejari/state/tenant_contract_notifier.dart';
import 'package:ejari/screens/tenant_dashboard_screen.dart';
import 'package:ejari/screens/agency/agency_add_property_screen.dart';
import 'package:ejari/screens/agency/agency_business_licenses.dart';
import 'package:ejari/screens/agency/agency_commissions.dart';
import 'package:ejari/screens/agency/agency_contracts.dart';
import 'package:ejari/screens/agency/agency_dashboard.dart';
import 'package:ejari/screens/agency/agency_legal_services.dart';
import 'package:ejari/screens/agency/agency_owners.dart';
import 'package:ejari/screens/agency/agency_properties.dart';
import 'package:ejari/screens/agency/agency_property_management.dart';
import 'package:ejari/screens/agency/agency_reviews.dart';
import 'package:ejari/screens/agency/agency_settings.dart';
import 'package:ejari/screens/public_profile_screen.dart';
import 'package:ejari/screens/price_prediction_screen.dart';
import 'package:ejari/state/locale_notifier.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const sanadVerification = '/sanad-verification';
  static const accountTypeSelection = '/account-type-selection';
  static const tenantDashboard = '/tenant-dashboard';
  static const ownerDashboard = '/owner-dashboard';
  static const search = '/search';
  static const property = '/property';
  static const addProperty = '/add-property';
  static const landlordRating = '/landlord-rating';
  static const digitalContract = '/digital-contract';
  static const profile = '/profile';
  static const myRatings = '/my-ratings';
  static const tenantRating = '/tenant-rating';
  static const landlordReviews = '/landlord-reviews';

  static String propertyPath(String id) => '$property/$id';
  static String rentalRequestPath(String id) => '$property/$id/rent';
  static String landlordReviewsFullPath(String ownerId) => '$landlordReviews/$ownerId';

  static const agencyDashboard = '/agency';
  static const agencyProperties = '/agency/properties';
  static const agencyAddProperty = '/agency/add-property';
  static const agencyContracts = '/agency/contracts';
  static const agencyOwners = '/agency/owners';
  static const agencyCommissions = '/agency/commissions';
  static const agencyReviews = '/agency/reviews';
  static const agencySettings = '/agency/settings';
  static const agencyPropertyManagement = '/agency/property-management';
  static const agencyLegalServices = '/agency/legal-services';
  static const agencyBusinessLicenses = '/agency/business-licenses';

  static String agencyManagedPropertyPath(String propertyId) => '/agency/managed-property/$propertyId';
  static String agencyManagedOwnerPath(String ownerId) => '/agency/managed-owner/$ownerId';

  static const publicUser = '/user';
  static String publicUserPath(String userId) => '$publicUser/$userId';

  static const pricePrediction = '/price-prediction';
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: Listenable.merge([
      ejariSession,
      tenantContractNotifier,
      ratingsNotifier,
      ejariLocaleNotifier,
    ]),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.sanadVerification,
        builder: (context, state) => const SanadVerificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.accountTypeSelection,
        builder: (context, state) => const AccountTypeSelectionScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.publicUser}/:uid',
        builder: (context, state) {
          final id = state.pathParameters['uid'] ?? '';
          return PublicProfileScreen(userId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.tenantDashboard,
        builder: (context, state) => const TenantDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.ownerDashboard,
        builder: (context, state) => const OwnerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.agencyDashboard,
        builder: (context, state) => const AgencyDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.agencyProperties,
        builder: (context, state) => const AgencyPropertiesScreen(),
      ),
      GoRoute(
        path: AppRoutes.agencyAddProperty,
        builder: (context, state) {
          final extra = state.extra;
          final initial = extra is AgencyAddPropertyArgs ? extra.initialOwnerId : null;
          return AgencyAddPropertyScreen(initialOwnerId: initial);
        },
      ),
      GoRoute(
        path: AppRoutes.agencyContracts,
        builder: (context, state) => const AgencyContractsScreen(),
      ),
      GoRoute(
        path: AppRoutes.agencyOwners,
        builder: (context, state) => const AgencyOwnersScreen(),
      ),
      GoRoute(
        path: AppRoutes.agencyCommissions,
        builder: (context, state) => const AgencyCommissionsScreen(),
      ),
      GoRoute(
        path: AppRoutes.agencyReviews,
        builder: (context, state) => const AgencyReviewsScreen(),
      ),
      GoRoute(
        path: AppRoutes.agencySettings,
        builder: (context, state) => const AgencySettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.agencyPropertyManagement,
        builder: (context, state) => const AgencyPropertyManagementScreen(),
      ),
      GoRoute(
        path: '/agency/managed-property/:pid',
        builder: (context, state) {
          final id = state.pathParameters['pid'] ?? '';
          final extra = state.extra;
          final ownerLabel = extra is AgencyManagedPropertyArgs ? extra.ownerContextLabel : null;
          return AgencyManagedPropertyDetailScreen(propertyId: id, ownerContextLabel: ownerLabel);
        },
      ),
      GoRoute(
        path: '/agency/managed-owner/:oid',
        builder: (context, state) {
          final oid = state.pathParameters['oid'] ?? '';
          return AgencyOwnerManagedAssetsScreen(ownerId: oid);
        },
      ),
      GoRoute(
        path: AppRoutes.agencyLegalServices,
        builder: (context, state) => const AgencyLegalServicesScreen(),
      ),
      GoRoute(
        path: AppRoutes.agencyBusinessLicenses,
        builder: (context, state) => const AgencyBusinessLicensesScreen(),
      ),
      GoRoute(
        path: AppRoutes.addProperty,
        builder: (context, state) => const AddPropertyScreen(),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const PropertySearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.pricePrediction,
        builder: (context, state) {
          final extra = state.extra;
          final initial = extra is PricePredictionInitialArgs ? extra : null;
          return PricePredictionScreen(initial: initial);
        },
      ),
      GoRoute(
        path: AppRoutes.landlordRating,
        builder: (context, state) => const LandlordRatingScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.myRatings,
        builder: (context, state) => const MyRatingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.tenantRating,
        builder: (context, state) {
          final extra = state.extra;
          final args = extra is TenantRatingArgs
              ? extra
              : const TenantRatingArgs(
                  tenantId: 'u-tenant-1',
                  tenantName: '—',
                  contractId: 'c-or-1',
                );
          return TenantRatingScreen(args: args);
        },
      ),
      GoRoute(
        path: '${AppRoutes.landlordReviews}/:ownerId',
        builder: (context, state) {
          final id = state.pathParameters['ownerId'] ?? '';
          return LandlordReviewsFullScreen(ownerId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.digitalContract,
        builder: (context, state) {
          final extra = state.extra;
          final args = extra is DigitalContractWizardArgs
              ? extra
              : const DigitalContractWizardArgs(isRenewal: false);
          return DigitalContractWizardScreen(args: args);
        },
      ),
      GoRoute(
        path: '${AppRoutes.property}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return PropertyDetailScreen(propertyId: id);
        },
        routes: [
          GoRoute(
            path: 'rent',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return RentalRequestScreen(propertyId: id);
            },
          ),
        ],
      ),
    ],
  );
}

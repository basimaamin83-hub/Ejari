import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/models/property_model.dart';
import 'package:ejari/models/property_review_model.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/utils/image_urls.dart';
import 'package:ejari/utils/launch_contact.dart';
import 'package:ejari/widgets/landlord_reviews_section.dart';
import 'package:ejari/widgets/public_profile_nav.dart';
import 'package:ejari/data/rent_price_prediction_mock.dart';
import 'package:ejari/l10n/app_localizations.dart';
import 'package:ejari/screens/price_prediction_screen.dart';

class PropertyDetailScreen extends StatefulWidget {
  const PropertyDetailScreen({super.key, required this.propertyId});

  final String propertyId;

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  late final PageController _pageController;
  Timer? _slideTimer;
  int _page = 0;
  late int _imageCount;
  late List<String> _seeds;

  @override
  void initState() {
    super.initState();
    final property = propertyById(widget.propertyId);
    _seeds = property == null || property.imageSeeds.isEmpty
        ? [widget.propertyId]
        : property.imageSeeds;
    _imageCount = _seeds.length;
    _pageController = PageController();
    if (_imageCount > 1) {
      _slideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
        if (!mounted || !_pageController.hasClients) return;
        final i = (_pageController.page ?? 0).round();
        final next = (i + 1) % _imageCount;
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 480),
          curve: Curves.easeOutCubic,
        );
      });
    }
  }

  @override
  void dispose() {
    _slideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _showAgencyShareSheet(PropertyModel property) {
    final views = agencyPropertyMockViewCount(property.id);
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.facebook, color: Color(0xFF1877F2)),
                title: const Text('فيسبوك'),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تمت المشاركة (وهمي) — ${property.title} — $views مشاهدة')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat, color: Color(0xFF25D366)),
                title: const Text('واتساب'),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تمت المشاركة (وهمي) عبر واتساب')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.tag, color: Color(0xFF1DA1F2)),
                title: const Text('تويتر / X'),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تمت المشاركة (وهمي) عبر تويتر')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final PropertyModel? property = propertyById(widget.propertyId);

    if (property == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.commonNotFound)),
        body: Center(child: Text(l10n.propertyNotFoundBody)),
      );
    }

    final reviews = mockReviewsForProperty(property.id);
    final agencyId = ejariSession.user?.agencyId;
    final isAgencyManaging =
        agencyId != null && property.agencyId != null && property.agencyId == agencyId;
    final mockViews = agencyPropertyMockViewCount(property.id);

    return Scaffold(
        backgroundColor: EjariColors.background,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: EjariColors.primary,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                onPressed: () => context.pop(),
              ),
              actions: [
                if (isAgencyManaging)
                  IconButton(
                    icon: const Icon(Icons.share_outlined, color: Colors.white),
                    tooltip: 'مشاركة',
                    onPressed: () => _showAgencyShareSheet(property),
                  ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: _seeds.length,
                      onPageChanged: (i) => setState(() => _page = i),
                      itemBuilder: (context, i) {
                        return Image.network(
                          ejariPlaceholderImage(_seeds[i], h: 600),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: EjariColors.primary.withValues(alpha: 0.35),
                            child: const Icon(Icons.photo, size: 64, color: Colors.white),
                          ),
                        );
                      },
                    ),
                    PositionedDirectional(
                      top: 12,
                      start: 0,
                      end: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_page + 1} / ${_seeds.length}',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      bottom: 12,
                      start: 0,
                      end: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _seeds.length,
                          (i) => Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _page == i ? Colors.white : Colors.white38,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: property.availableNow
                                ? EjariColors.primary
                                : EjariColors.textSecondary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            property.availableNow ? l10n.propertyAvailableNow : l10n.propertyNotAvailable,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 4,
                          child: Text(
                            property.title,
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            property.location,
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.location_on_outlined, color: EjariColors.textSecondary),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: EjariColors.card,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _metric(
                              context,
                              l10n.propertyPricePerMonth,
                              '${property.priceMonthly.toStringAsFixed(0)} ${l10n.commonJod}',
                              Icons.payments_outlined,
                            ),
                          ),
                          Expanded(
                            child: _metric(
                              context,
                              l10n.propertyArea,
                              '${property.areaSqm} م²',
                              Icons.square_foot_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _FairPriceInsightCard(property: property, l10n: l10n),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: EjariColors.card,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _infoChip(Icons.bed_outlined, l10n.propertyRoomsCount(property.rooms)),
                          _infoChip(Icons.bathtub_outlined, l10n.propertyBathsCount(property.bathrooms)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        l10n.propertyDescription,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      property.description,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.45),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 8,
                      runSpacing: 8,
                      children: property.tags
                          .map((t) => Chip(
                                label: Text(t),
                                backgroundColor: EjariColors.lavenderMuted,
                              ))
                          .toList(),
                    ),
                    if (isAgencyManaging) ...[
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: EjariColors.card,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: EjariColors.primary.withValues(alpha: 0.25)),
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          spacing: 10,
                          runSpacing: 8,
                          children: [
                            Chip(
                              avatar: const Icon(Icons.visibility_outlined, size: 18),
                              label: Text('$mockViews مشاهدة'),
                              backgroundColor: EjariColors.lavenderMuted,
                            ),
                            OutlinedButton.icon(
                              onPressed: () => _showAgencyShareSheet(property),
                              icon: const Icon(Icons.share_outlined),
                              label: const Text('مشاركة للتسويق'),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: EjariColors.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: EjariColors.secondary.withValues(alpha: 0.35)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            l10n.propertyOwnerSection,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: EjariColors.primary.withValues(alpha: 0.14),
                                child: const Icon(Icons.person_rounded, color: EjariColors.primary, size: 30),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () => pushPublicProfile(context, property.ownerId),
                                      borderRadius: BorderRadius.circular(8),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2),
                                        child: Text(
                                          property.ownerName,
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.w800,
                                                color: EjariColors.primary,
                                                decoration: TextDecoration.underline,
                                                decorationColor: EjariColors.primary,
                                              ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${property.ownerRating}',
                                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                fontWeight: FontWeight.w800,
                                              ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(Icons.star_rounded, color: EjariColors.starFilled),
                                        const SizedBox(width: 8),
                                        Text(
                                          l10n.propertyOwnerListingsCount(property.ownerListedPropertiesCount),
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => launchPhoneDialer(context, property.ownerPhone),
                            icon: const Icon(Icons.call_outlined),
                            label: Text(l10n.propertyCall),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => launchWhatsApp(context, property.ownerPhone),
                            icon: const Icon(Icons.chat_bubble_outline),
                            label: Text(l10n.propertyWhatsapp),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => context.push(AppRoutes.rentalRequestPath(property.id)),
                        icon: const Icon(Icons.send_outlined, color: EjariColors.onPrimaryFg),
                        label: Text(l10n.propertySubmitRentalRequest),
                      ),
                    ),
                    const SizedBox(height: 28),
                    LandlordReviewsSection(ownerId: property.ownerId),
                    const SizedBox(height: 28),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        l10n.propertyTenantReviews,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...reviews.map((r) => _ReviewTile(review: r)),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  static Widget _metric(BuildContext context, String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(width: 6),
            Icon(icon, size: 18, color: EjariColors.primary),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: EjariColors.primary,
                fontWeight: FontWeight.w900,
              ),
        ),
      ],
    );
  }

  static Widget _infoChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Icon(icon, color: EjariColors.primary),
      ],
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final PropertyReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: EjariColors.secondary.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                review.authorName,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 8),
              ...List.generate(
                5,
                (i) => Icon(
                  i < review.rating ? Icons.star_rounded : Icons.star_border_rounded,
                  size: 18,
                  color: i < review.rating ? EjariColors.starFilled : EjariColors.starEmpty,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            review.comment,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
          ),
          const SizedBox(height: 6),
          Text(
            review.timeLabel,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _FairPriceInsightCard extends StatelessWidget {
  const _FairPriceInsightCard({required this.property, required this.l10n});

  final PropertyModel property;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final pred = predictRentPriceForPropertyListing(
      governorate: property.governorate,
      district: property.district,
      houseAreaSqm: property.areaSqm.toDouble(),
      outdoorAreaSqm: 0,
      buildingAgeYears: 10,
      floor: predictionFloorFromPropertyText(property.title, property.tags),
      tenantRating: property.rating >= 1 && property.rating <= 5 ? property.rating : null,
      maintenanceCount: 0,
    );
    final verdict = compareListingToPrediction(
      listingPriceMonthly: property.priceMonthly,
      prediction: pred,
      l10n: l10n,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: EjariColors.lavenderMuted,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: EjariColors.primary.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                l10n.propertyIsPriceFair,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 8),
              Icon(Icons.auto_awesome_rounded, color: EjariColors.primary, size: 22),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            verdict,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: EjariColors.primary,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.propertyExpectedRange(pred.rangeLowJod.round(), pred.rangeHighJod.round()),
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => context.push(
              AppRoutes.pricePrediction,
              extra: PricePredictionInitialArgs(
                houseAreaSqm: property.areaSqm.toDouble(),
                outdoorAreaSqm: 0,
                buildingAgeYears: 10,
                floor: predictionFloorFromPropertyText(property.title, property.tags),
                tenantRating: property.rating >= 1 && property.rating <= 5 ? property.rating : null,
              ),
            ),
            icon: const Icon(Icons.psychology_outlined, size: 20),
            label: Text(l10n.propertySmartPredictionDetails),
          ),
        ],
      ),
    );
  }
}

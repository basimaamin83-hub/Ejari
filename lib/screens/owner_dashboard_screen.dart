import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/models/tenant_rating_args.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/l10n/app_localizations.dart';
import 'package:ejari/widgets/public_profile_nav.dart';
import 'package:ejari/widgets/owner_dashboard_drawer.dart';

class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _rentedSectionKey = GlobalKey();
  final GlobalKey _vacantSectionKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = key.currentContext;
      if (ctx != null && mounted) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          alignment: 0.1,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final stats = statsForOwnerDashboard();
    final ownerName = ejariSession.user?.fullName ?? mockOwnerUser.fullName;

    return Scaffold(
      key: _scaffoldKey,
      drawer: OwnerDashboardDrawer(
        ownerName: ownerName,
        onScrollToRented: () => _scrollTo(_rentedSectionKey),
        onScrollToVacant: () => _scrollTo(_vacantSectionKey),
      ),
      backgroundColor: EjariColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addProperty),
        backgroundColor: EjariColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _OwnerHeader(
              l10n: l10n,
              ownerName: ownerName,
              onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
              onProfile: () => context.push(AppRoutes.profile),
              onLogout: () {
                ejariSession.logout();
                context.go(AppRoutes.login);
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: l10n.ownerStatRented,
                        value: '${stats.rentedCount}',
                        icon: Icons.home_work_outlined,
                        color: EjariColors.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        label: l10n.ownerStatVacant,
                        value: '${stats.vacantCount}',
                        icon: Icons.door_front_door_outlined,
                        color: EjariColors.secondary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        label: l10n.ownerStatTotalRent,
                        value: stats.totalMonthlyRent.toStringAsFixed(0),
                        sublabel: l10n.commonJodPerMonth,
                        icon: Icons.account_balance_wallet_outlined,
                        color: EjariColors.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                KeyedSubtree(
                  key: _rentedSectionKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.ownerMyRented,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 12),
                      ...mockOwnerRentedListings.map((e) => _RentedTile(
                            listing: e,
                            onRate: () => context.push(
                              AppRoutes.tenantRating,
                              extra: TenantRatingArgs(
                                tenantId: e.tenantId,
                                tenantName: e.tenantName,
                                contractId: e.contractId,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                KeyedSubtree(
                  key: _vacantSectionKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.ownerMyVacant,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 12),
                      ...mockOwnerVacantListings.map((e) => _VacantTile(
                            listing: e,
                            onPublish: () {
                              context.push(AppRoutes.addProperty);
                            },
                          )),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _OwnerHeader extends StatelessWidget {
  const _OwnerHeader({
    required this.l10n,
    required this.ownerName,
    required this.onOpenDrawer,
    required this.onProfile,
    required this.onLogout,
  });

  final AppLocalizations l10n;
  final String ownerName;
  final VoidCallback onOpenDrawer;
  final VoidCallback onProfile;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 48, 12, 28),
      decoration: const BoxDecoration(
        gradient: EjariGradients.header,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onOpenDrawer,
                icon: const Icon(Icons.menu_rounded, color: Colors.white),
                tooltip: 'القائمة',
              ),
              IconButton(
                onPressed: onLogout,
                icon: const Icon(Icons.logout_rounded, color: Colors.white70),
                tooltip: l10n.commonLogout,
              ),
              IconButton(
                onPressed: onProfile,
                icon: const Icon(Icons.person_outline_rounded, color: Colors.white),
                tooltip: l10n.commonProfile,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    l10n.welcomeUser(ownerName),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.ownerRoleLabel,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.78),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.sublabel,
  });

  final String label;
  final String value;
  final String? sublabel;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: EjariColors.card,
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: color,
                    fontSize: sublabel != null ? 18 : 22,
                  ),
            ),
            if (sublabel != null)
              Text(
                sublabel!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}

class _RentedTile extends StatelessWidget {
  const _RentedTile({required this.listing, required this.onRate});

  final OwnerRentedListingMock listing;
  final VoidCallback onRate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              listing.propertyTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(listing.address, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text.rich(
              textAlign: TextAlign.right,
              TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(text: l10n.agencyTenantLabel),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: InkWell(
                      onTap: () => pushPublicProfile(context, listing.tenantId),
                      borderRadius: BorderRadius.circular(6),
                      child: Text(
                        listing.tenantName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: EjariColors.primary,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationColor: EjariColors.primary,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${listing.monthlyRent.toStringAsFixed(0)} ${l10n.searchJodPerMonthShort}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: EjariColors.primary),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onRate,
                child: Text(l10n.rateTenant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VacantTile extends StatelessWidget {
  const _VacantTile({required this.listing, required this.onPublish});

  final OwnerVacantListingMock listing;
  final VoidCallback onPublish;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              listing.propertyTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(listing.address, style: Theme.of(context).textTheme.bodySmall),
            Text(
              l10n.ownerProposedRent(listing.askingRent.toStringAsFixed(0)),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPublish,
                child: Text(l10n.publishProperty),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/models/contract_model.dart';
import 'package:ejari/models/digital_contract_wizard_args.dart';
import 'package:ejari/state/tenant_contract_notifier.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/l10n/app_localizations.dart';
import 'package:ejari/widgets/public_profile_nav.dart';
import 'package:ejari/widgets/tenant_dashboard_drawer.dart';

class TenantDashboardScreen extends StatefulWidget {
  const TenantDashboardScreen({super.key});

  @override
  State<TenantDashboardScreen> createState() => _TenantDashboardScreenState();
}

class _TenantDashboardScreenState extends State<TenantDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _contractSectionKey = GlobalKey();
  final GlobalKey _pastSectionKey = GlobalKey();
  final GlobalKey _notifSectionKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = key.currentContext;
      if (ctx != null && mounted) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          alignment: 0.12,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([ejariSession, tenantContractNotifier]),
      builder: (context, _) {
        final isTenant = ejariSession.user?.role == 'tenant';
        final uid = ejariSession.user?.id;
        final contract = (!ejariSession.isGuest && isTenant && uid != null)
            ? tenantContractNotifier.activeContract(uid)
            : null;

        final l10n = AppLocalizations.of(context)!;
        final name = ejariSession.isGuest ? l10n.commonGuest : ejariSession.user?.fullName ?? ejariSession.displayFirstName;
        return Scaffold(
          key: _scaffoldKey,
          drawer: TenantDashboardDrawer(
            displayName: name,
            hasActiveContract: contract != null,
            onScrollToContract: () => _scrollTo(_contractSectionKey),
            onScrollToPast: () => _scrollTo(_pastSectionKey),
            onScrollToNotifications: () => _scrollTo(_notifSectionKey),
          ),
          backgroundColor: EjariColors.background,
          floatingActionButton: (!ejariSession.isGuest && ejariSession.user?.role == 'tenant')
              ? FloatingActionButton(
                  onPressed: () => context.push(
                    AppRoutes.digitalContract,
                    extra: const DigitalContractWizardArgs(isRenewal: false),
                  ),
                  backgroundColor: EjariColors.primary,
                  tooltip: l10n.tenantFabNewContractTooltip,
                  child: const Icon(Icons.description_outlined, color: Colors.white),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _DashboardHeader(onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer()),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (contract != null) ...[
                      KeyedSubtree(
                        key: _contractSectionKey,
                        child: _CurrentContractCard(contract: contract),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (uid != null && isTenant) ...[
                      KeyedSubtree(
                        key: _pastSectionKey,
                        child: _PastContractsSection(tenantId: uid),
                      ),
                      const SizedBox(height: 16),
                    ],
                    _SearchHeroButton(onTap: () => context.push(AppRoutes.search)),
                    const SizedBox(height: 16),
                    _QuickActionsRow(contract: contract),
                    const SizedBox(height: 20),
                    const _RentPriceAiCard(),
                    const SizedBox(height: 16),
                    KeyedSubtree(
                      key: _notifSectionKey,
                      child: const _RecentNotificationsCard(),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({required this.onOpenDrawer});

  final VoidCallback onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final name = ejariSession.isGuest ? l10n.commonGuest : ejariSession.displayFirstName;
    final roleLabel = () {
      if (ejariSession.isGuest) return l10n.roleGuest;
      switch (ejariSession.user?.role) {
        case 'owner':
          return l10n.roleOwner;
        case 'office':
          return l10n.roleAgency;
        default:
          return l10n.roleTenant;
      }
    }();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 28),
      decoration: const BoxDecoration(
        gradient: EjariGradients.header,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onOpenDrawer,
                icon: const Icon(Icons.menu_rounded, color: Colors.white),
                tooltip: 'القائمة',
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      l10n.welcomeUser(name),
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      roleLabel,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.78),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.notificationsSnackbar)),
                  );
                },
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.notifications_none_rounded, color: Colors.white),
                    PositionedDirectional(
                      top: -2,
                      start: -2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: EjariColors.danger,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.person_outline_rounded, color: Colors.white),
                offset: const Offset(0, 44),
                onSelected: (value) {
                  if (value == 'logout') {
                    ejariSession.logout();
                    context.go(AppRoutes.login);
                  } else if (value == 'profile') {
                    context.push(AppRoutes.profile);
                  }
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(value: 'profile', child: Text(l10n.commonProfile)),
                  PopupMenuItem(value: 'logout', child: Text(l10n.commonLogout)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CurrentContractCard extends StatelessWidget {
  const _CurrentContractCard({required this.contract});

  final ContractModel contract;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final progress = contract.annualTotalDays == 0
        ? 0.0
        : contract.annualProgressDays / contract.annualTotalDays;

    return Material(
      color: EjariColors.card,
      elevation: 3,
      shadowColor: EjariColors.primary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.description_outlined, color: EjariColors.iconMuted),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: EjariColors.success,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.contractActive,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: EjariColors.onSuccess,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                l10n.contractMyCurrent,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 12),
            _contractLine(l10n.labelAddress, contract.addressLabel),
            const SizedBox(height: 8),
            Builder(
              builder: (context) {
                final prop = propertyById(contract.propertyId);
                final lid = contract.landlordId ?? prop?.ownerId;
                final lname = contract.landlordName ?? prop?.ownerName ?? '—';
                if (lid == null) {
                  return _contractLine(l10n.labelLandlord, lname);
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text.rich(
                    textAlign: TextAlign.right,
                    TextSpan(
                      style: const TextStyle(color: EjariColors.textPrimary, fontSize: 14, height: 1.35),
                      children: [
                        TextSpan(text: l10n.labelLandlord, style: const TextStyle(fontWeight: FontWeight.w500)),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: InkWell(
                            onTap: () => pushPublicProfile(context, lid),
                            borderRadius: BorderRadius.circular(6),
                            child: Text(
                              lname,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: EjariColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: EjariColors.primary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            _contractLine(l10n.labelMonthlyRentDinar, '${contract.monthlyRent.toStringAsFixed(0)} ${l10n.commonJod}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(l10n.endsOn, style: theme.textTheme.bodyMedium),
                Text(
                  '${contract.daysUntilExpiry} ${l10n.commonDays}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: EjariColors.danger,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.annualProgress(contract.annualProgressDays, contract.annualTotalDays),
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: EjariColors.lavenderMuted,
                color: EjariColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _contractLine(String label, String value) {
    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        style: const TextStyle(color: EjariColors.textPrimary, fontSize: 14, height: 1.35),
        children: [
          TextSpan(text: label, style: const TextStyle(fontWeight: FontWeight.w500)),
          TextSpan(text: value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _PastContractsSection extends StatelessWidget {
  const _PastContractsSection({required this.tenantId});

  final String tenantId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rows = mockPastContractRowsForTenant(tenantId);
    if (rows.isEmpty) return const SizedBox.shrink();

    return Material(
      color: EjariColors.card,
      elevation: 2,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              l10n.pastContracts,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            ...rows.map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      r.label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      textAlign: TextAlign.right,
                      TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(text: l10n.labelLandlord),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: InkWell(
                              onTap: () => pushPublicProfile(context, r.landlordId),
                              borderRadius: BorderRadius.circular(6),
                              child: Text(
                                r.landlordName,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RentPriceAiCard extends StatelessWidget {
  const _RentPriceAiCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: EjariColors.card,
      elevation: 2,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => context.push(AppRoutes.pricePrediction),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: EjariColors.primary, size: 34),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      l10n.aiPredictTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.aiPredictSubtitle,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_left, color: EjariColors.iconMuted),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchHeroButton extends StatelessWidget {
  const _SearchHeroButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: EjariGradients.header,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: Colors.white, size: 28),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        l10n.searchFindHome,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.searchDiscover,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow({this.contract});

  final ContractModel? contract;

  void _requireContractAndPush(BuildContext context, String route, {Object? extra}) {
    if (contract == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.needActiveContract)),
      );
      return;
    }
    context.push(route, extra: extra);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: _SmallActionCard(
            icon: Icons.star_rounded,
            iconColor: EjariColors.starFilled,
            title: l10n.quickRateLandlord,
            subtitle: l10n.quickRateLandlordSub,
            onTap: () => _requireContractAndPush(context, AppRoutes.landlordRating),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SmallActionCard(
            icon: Icons.event_repeat_rounded,
            iconColor: EjariColors.primary,
            title: l10n.quickRenewContract,
            subtitle: l10n.quickRenewContractSub,
            onTap: () => _requireContractAndPush(
                  context,
                  AppRoutes.digitalContract,
                  extra: const DigitalContractWizardArgs(isRenewal: true),
                ),
          ),
        ),
      ],
    );
  }
}

class _SmallActionCard extends StatelessWidget {
  const _SmallActionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: EjariColors.card,
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(icon, color: iconColor, size: 30),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentNotificationsCard extends StatelessWidget {
  const _RecentNotificationsCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            l10n.recentNotifications,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          _notifTile(
            context,
            bg: EjariColors.successMutedBg,
            dot: EjariColors.success,
            title: l10n.notifRentReceivedTitle,
            time: l10n.notifRentReceivedTime,
          ),
          const SizedBox(height: 10),
          _notifTile(
            context,
            bg: EjariColors.warningMutedBg,
            dot: EjariColors.warning,
            title: l10n.notifContractEndingTitle,
            time: l10n.notifContractEndingTime,
          ),
        ],
      ),
    );
  }

  static Widget _notifTile(
    BuildContext context, {
    required Color bg,
    required Color dot,
    required String title,
    required String time,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: EjariColors.textPrimary,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

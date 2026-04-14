import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/theme/app_theme.dart';

/// قائمة جانبية لمستأجر لوحة إيجاري.
class TenantDashboardDrawer extends StatelessWidget {
  const TenantDashboardDrawer({
    super.key,
    required this.displayName,
    required this.hasActiveContract,
    required this.onScrollToContract,
    required this.onScrollToPast,
    required this.onScrollToNotifications,
  });

  final String displayName;
  final bool hasActiveContract;
  final VoidCallback onScrollToContract;
  final VoidCallback onScrollToPast;
  final VoidCallback onScrollToNotifications;

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    final homeSelected = loc == AppRoutes.tenantDashboard;

    return Drawer(
      backgroundColor: EjariColors.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            decoration: const BoxDecoration(
              color: EjariColors.card,
              border: Border(bottom: BorderSide(color: EjariColors.accent, width: 2)),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: EjariColors.accent.withValues(alpha: 0.35),
                    child: const Icon(Icons.person_rounded, size: 34, color: EjariColors.textPrimary),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          displayName,
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: EjariColors.textPrimary,
                              ),
                        ),
                        Text(
                          'مستأجر',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _tile(
                  context,
                  icon: Icons.home_outlined,
                  title: 'الرئيسية',
                  selected: homeSelected,
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRoutes.tenantDashboard);
                  },
                ),
                _tile(
                  context,
                  icon: Icons.description_outlined,
                  title: 'عقدي الحالي',
                  selected: false,
                  onTap: () {
                    Navigator.pop(context);
                    if (hasActiveContract) {
                      onScrollToContract();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('لا يوجد عقد نشط حالياً')),
                      );
                    }
                  },
                ),
                _tile(
                  context,
                  icon: Icons.search_rounded,
                  title: 'البحث عن عقار',
                  selected: false,
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRoutes.search);
                  },
                ),
                _tile(
                  context,
                  icon: Icons.star_outline_rounded,
                  title: 'تقييماتي',
                  selected: loc == AppRoutes.myRatings,
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRoutes.myRatings);
                  },
                ),
                _tile(
                  context,
                  icon: Icons.history_rounded,
                  title: 'عقودي السابقة',
                  selected: false,
                  onTap: () {
                    Navigator.pop(context);
                    onScrollToPast();
                  },
                ),
                _tile(
                  context,
                  icon: Icons.notifications_none_rounded,
                  title: 'الإشعارات',
                  selected: false,
                  onTap: () {
                    Navigator.pop(context);
                    onScrollToNotifications();
                  },
                ),
                _tile(
                  context,
                  icon: Icons.person_outline_rounded,
                  title: 'الملف الشخصي',
                  selected: loc == AppRoutes.profile,
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRoutes.profile);
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(Icons.logout_rounded, color: EjariColors.danger),
            title: Text('تسجيل الخروج', style: TextStyle(color: EjariColors.textPrimary)),
            onTap: () {
              ejariSession.logout();
              Navigator.pop(context);
              context.go(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }

  static Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      selected: selected,
      selectedTileColor: EjariColors.accent.withValues(alpha: 0.22),
      iconColor: selected ? EjariColors.accent : EjariColors.textPrimary,
      textColor: EjariColors.textPrimary,
      leading: Icon(icon),
      title: Text(title, textAlign: TextAlign.right),
      onTap: onTap,
    );
  }
}

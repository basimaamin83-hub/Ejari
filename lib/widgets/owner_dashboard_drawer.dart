import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/l10n/app_localizations.dart';
import 'package:ejari/theme/app_theme.dart';

/// قائمة جانبية لمالك العقار في لوحة إيجاري.
class OwnerDashboardDrawer extends StatelessWidget {
  const OwnerDashboardDrawer({
    super.key,
    required this.ownerName,
    required this.onScrollToRented,
    required this.onScrollToVacant,
  });

  final String ownerName;
  final VoidCallback onScrollToRented;
  final VoidCallback onScrollToVacant;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final loc = GoRouterState.of(context).uri.path;
    final home = loc == AppRoutes.ownerDashboard;

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
                    child: const Icon(Icons.home_work_outlined, size: 30, color: EjariColors.textPrimary),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ownerName,
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: EjariColors.textPrimary,
                              ),
                        ),
                        Text(
                          l10n.roleOwner,
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
                _tile(context, Icons.dashboard_outlined, 'الرئيسية', home, () {
                  Navigator.pop(context);
                  context.go(AppRoutes.ownerDashboard);
                }),
                _tile(context, Icons.home_work_outlined, 'عقاراتي المؤجرة', false, () {
                  Navigator.pop(context);
                  onScrollToRented();
                }),
                _tile(context, Icons.door_front_door_outlined, 'عقاراتي الشاغرة', false, () {
                  Navigator.pop(context);
                  onScrollToVacant();
                }),
                _tile(context, Icons.add_home_outlined, 'إضافة عقار جديد', false, () {
                  Navigator.pop(context);
                  context.push(AppRoutes.addProperty);
                }),
                _tile(context, Icons.star_outline_rounded, 'تقييمات المستأجرين', false, () {
                  Navigator.pop(context);
                  onScrollToRented();
                }),
                _tile(context, Icons.percent_outlined, 'العمولات (إن وجدت)', false, () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('لا توجد عمولات مسجّلة لهذا الحساب حالياً (تجريبي).')),
                  );
                }),
                _tile(context, Icons.person_outline_rounded, 'الملف الشخصي', loc == AppRoutes.profile, () {
                  Navigator.pop(context);
                  context.push(AppRoutes.profile);
                }),
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
    BuildContext context,
    IconData icon,
    String title,
    bool selected,
    VoidCallback onTap,
  ) {
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

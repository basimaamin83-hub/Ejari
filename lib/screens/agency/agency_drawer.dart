import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/theme/app_theme.dart';

/// قائمة جانبية موحّدة لوحدة المكتب العقاري.
class AgencyDrawer extends StatelessWidget {
  const AgencyDrawer({super.key});

  static void _goHome(BuildContext context) {
    Navigator.of(context).pop();
    context.go(AppRoutes.agencyDashboard);
  }

  static void _push(BuildContext context, String path) {
    Navigator.of(context).pop();
    context.push(path);
  }

  @override
  Widget build(BuildContext context) {
    final profileName = ejariSession.user?.fullName ?? 'مكتب عقاري';

    return Drawer(
      backgroundColor: EjariColors.card,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: EjariColors.accent, width: 3)),
          ),
          child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: EjariGradients.appBar,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.business_center_rounded, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profileName,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Text(
                    'إيجاري — وحدة المكتب',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            _tile(context, Icons.dashboard_outlined, 'لوحة التحكم', () => _goHome(context)),
            _tile(context, Icons.handyman_outlined, 'إدارة الأملاك', () => _push(context, AppRoutes.agencyPropertyManagement)),
            _tile(context, Icons.maps_home_work_outlined, 'إدارة العقارات', () => _push(context, AppRoutes.agencyProperties)),
            _tile(context, Icons.description_outlined, 'العقود', () => _push(context, AppRoutes.agencyContracts)),
            _tile(context, Icons.account_balance_wallet_outlined, 'العمولات', () => _push(context, AppRoutes.agencyCommissions)),
            _tile(context, Icons.gavel_outlined, 'الخدمات القانونية', () => _push(context, AppRoutes.agencyLegalServices)),
            _tile(context, Icons.storefront_outlined, 'التراخيص التجارية', () => _push(context, AppRoutes.agencyBusinessLicenses)),
            _tile(context, Icons.star_outline_rounded, 'تقييم المكتب', () => _push(context, AppRoutes.agencyReviews)),
            const Divider(),
            _tile(context, Icons.settings_outlined, 'الإعدادات', () => _push(context, AppRoutes.agencySettings)),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              title: const Text('تسجيل الخروج', textAlign: TextAlign.right),
              onTap: () {
                ejariSession.logout();
                Navigator.of(context).pop();
                context.go(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    ),
    );
  }

  static Widget _tile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      iconColor: EjariColors.textPrimary,
      textColor: EjariColors.textPrimary,
      leading: Icon(icon),
      title: Text(title, textAlign: TextAlign.right),
      onTap: onTap,
    );
  }
}

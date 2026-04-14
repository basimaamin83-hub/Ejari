import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/models/agency_models.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/public_profile_nav.dart';
import 'package:ejari/screens/agency/agency_drawer.dart';
import 'package:ejari/screens/agency/agency_add_property_screen.dart';
import 'package:ejari/widgets/agency_app_bar.dart';

/// لوحة تحكم المكتب العقاري — الصفحة الرئيسية بعد تسجيل الدخول كمكتب.
class AgencyDashboardScreen extends StatelessWidget {
  const AgencyDashboardScreen({super.key});

  static void _openAddPropertyForOwner(BuildContext context, List<AgencyOwnerRecord> owners) {
    if (owners.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يوجد مالك مرتبط. يُرجى إضافة مالك من شاشة الملاك أو إدارة الأملاك.')),
      );
      return;
    }
    if (owners.length == 1) {
      context.push(
        AppRoutes.agencyAddProperty,
        extra: AgencyAddPropertyArgs(initialOwnerId: owners.single.ownerId),
      );
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            children: [
              Text(
                'اختر المالك',
                textAlign: TextAlign.right,
                style: Theme.of(ctx).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              Text(
                'يُسجَّل العقار الجديد ضمن أملاك المالك الذي تختاره.',
                textAlign: TextAlign.right,
                style: Theme.of(ctx).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
              ),
              const SizedBox(height: 12),
              ...owners.map(
                (o) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(o.fullName, textAlign: TextAlign.right),
                    subtitle: Text(o.phone, textAlign: TextAlign.right),
                    onTap: () {
                      Navigator.pop(ctx);
                      context.push(
                        AppRoutes.agencyAddProperty,
                        extra: AgencyAddPropertyArgs(initialOwnerId: o.ownerId),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: agencyGradientAppBar(title: const Text('مكتب عقاري')),
          body: const Center(child: Text('لا يوجد مكتب مرتبط بحسابك.')),
        ),
      );
    }

    final owners = agencyOwnersFor(aid);
    final commissions = agencyCommissionsFor(aid);
    final profile = agencyProfileFor(aid);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AgencyDrawer(),
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: Text(profile.name),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: 'القائمة',
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.push(AppRoutes.agencySettings),
            ),
            IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                ejariSession.logout();
                context.go(AppRoutes.login);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _openAddPropertyForOwner(context, owners),
          icon: const Icon(Icons.add_home_work_outlined),
          label: const Text('إضافة عقار لمالك'),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
          children: [
            Text(
              'مرحباً، ${ejariSession.displayFirstName}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: EjariColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: EjariColors.accent.withValues(alpha: 0.35)),
              ),
              child: Text(
                'أنت تدير عقارات المالكين التالية أسماؤهم. لا توجد عقود تأجير معروضة هنا.',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: EjariColors.textSecondary,
                      height: 1.45,
                    ),
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, 'المالكون المتعاملون', onMore: () => context.push(AppRoutes.agencyOwners)),
            const SizedBox(height: 10),
            ...owners.take(2).map((o) => _ownerTile(context, o)),
            if (owners.length > 2)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: () => context.push(AppRoutes.agencyOwners),
                  child: const Text('عرض الكل'),
                ),
              ),
            const SizedBox(height: 22),
            _sectionTitle(context, 'سجل العمولات', onMore: () => context.push(AppRoutes.agencyCommissions)),
            const SizedBox(height: 10),
            ...commissions.take(2).map((c) => _commissionTile(context, c)),
            if (commissions.length > 2)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: () => context.push(AppRoutes.agencyCommissions),
                  child: const Text('عرض السجل الكامل'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static Widget _sectionTitle(BuildContext context, String title, {VoidCallback? onMore}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (onMore != null)
          TextButton(onPressed: onMore, child: const Text('المزيد'))
        else
          const SizedBox.shrink(),
        Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
      ],
    );
  }

  static Widget _ownerTile(BuildContext context, AgencyOwnerRecord o) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: InkWell(
          onTap: () => pushPublicProfile(context, o.ownerId),
          borderRadius: BorderRadius.circular(8),
          child: Text(
            o.fullName,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: EjariColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: EjariColors.primary,
                ),
          ),
        ),
        subtitle: Text(o.phone, textAlign: TextAlign.right),
      ),
    );
  }

  static Widget _commissionTile(BuildContext context, AgencyCommissionRecord c) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: ListTile(
        title: Text(
          c.paid ? 'عمولة مدفوعة' : 'عمولة مستحقة',
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        subtitle: Text(
          'المالك: ${c.landlordName}\n'
          '${_fmt(c.contractDate)} — ${c.commissionPercent}٪ — ${c.amountDue.toStringAsFixed(2)} د.أ',
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.35),
        ),
        isThreeLine: true,
      ),
    );
  }

  static String _fmt(DateTime d) => '${d.year}/${d.month}/${d.day}';
}

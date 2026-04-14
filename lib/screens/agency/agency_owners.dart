import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/agency_app_bar.dart';
import 'package:ejari/widgets/public_profile_nav.dart';

class AgencyOwnersScreen extends StatelessWidget {
  const AgencyOwnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }
    final list = agencyOwnersFor(aid);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: const Text('المالكون'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddOwnerDialog(context),
          icon: const Icon(Icons.person_add_outlined),
          label: const Text('إضافة مالك'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
          itemCount: list.length,
          itemBuilder: (context, i) {
            final o = list[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
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
                subtitle: Text('${o.phone}\nعدد العقارات المسندة: ${o.managedPropertiesCount}', textAlign: TextAlign.right),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(o.rating.toStringAsFixed(1)),
                    const Icon(Icons.star_rounded, color: EjariColors.starFilled, size: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static void _showAddOwnerDialog(BuildContext context) {
    final idCtrl = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة مالك جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('أدخل رقم الهوية لجلب البيانات (وهمي).'),
            const SizedBox(height: 12),
            TextField(
              controller: idCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(labelText: 'رقم الهوية'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم جلب بيانات المالك وهمياً للهوية ${idCtrl.text}')),
              );
            },
            child: const Text('جلب البيانات'),
          ),
        ],
      ),
    );
  }
}

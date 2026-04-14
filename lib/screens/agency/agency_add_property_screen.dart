import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/models/agency_models.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/agency_app_bar.dart';

/// وسائط التوجيه: اختيار مالك مسبق لإضافة عقار ضمن أملاكه.
@immutable
class AgencyAddPropertyArgs {
  const AgencyAddPropertyArgs({this.initialOwnerId});
  final String? initialOwnerId;
}

/// إضافة عقار جديد للمكتب مع اختيار المالك الموكل.
class AgencyAddPropertyScreen extends StatefulWidget {
  const AgencyAddPropertyScreen({super.key, this.initialOwnerId});

  /// يُمرَّر من الموجّه عند فتح الشاشة لمالك محدد (مثلاً من لوحة المكتب).
  final String? initialOwnerId;

  @override
  State<AgencyAddPropertyScreen> createState() => _AgencyAddPropertyScreenState();
}

class _AgencyAddPropertyScreenState extends State<AgencyAddPropertyScreen> {
  String? _ownerId;

  @override
  void initState() {
    super.initState();
    _ownerId = widget.initialOwnerId;
  }
  final _title = TextEditingController();
  final _price = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }
    final owners = agencyOwnersFor(aid);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: const Text('إضافة عقار للمكتب'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'اختر المالك الموكل',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            DropdownMenu<String>(
              initialSelection: _ownerId,
              label: const Text('المالك الموكل'),
              dropdownMenuEntries: owners
                  .map(
                    (AgencyOwnerRecord o) => DropdownMenuEntry<String>(
                      value: o.ownerId,
                      label: o.fullName,
                    ),
                  )
                  .toList(),
              onSelected: (v) => setState(() => _ownerId = v),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _title,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                labelText: 'عنوان العقار',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _price,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                labelText: 'الإيجار الشهري (د.أ)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'نفس نموذج إضافة عقار المالك سيُربط هنا لاحقاً (صور، موقع، تفاصيل).',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                if (_ownerId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('اختر المالك الموكل')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حفظ الطلب وهمياً — سيتم مراجعته')),
                );
                context.pop();
              },
              child: const Text('حفظ العقار'),
            ),
          ],
        ),
      ),
    );
  }
}

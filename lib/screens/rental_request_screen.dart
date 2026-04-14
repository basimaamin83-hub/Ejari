import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/models/user_model.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/public_profile_nav.dart';
import 'package:ejari/widgets/tenant_reputation_card.dart';

class RentalRequestScreen extends StatefulWidget {
  const RentalRequestScreen({super.key, required this.propertyId});

  final String propertyId;

  @override
  State<RentalRequestScreen> createState() => _RentalRequestScreenState();
}

class _RentalRequestScreenState extends State<RentalRequestScreen> {
  final TextEditingController _message = TextEditingController();

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final property = propertyById(widget.propertyId);
    if (property == null) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('خطأ')),
          body: const Center(child: Text('العقار غير موجود')),
        ),
      );
    }

    final tenant = mockTenantUser;
    final tenantId = ejariSession.user?.id ?? mockTenantUser.id;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: AppBar(
          title: const Text('طلب إيجار'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('ملخص الطلب', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            _summaryCard(
              context,
              title: 'العقار',
              lines: [
                property.title,
                property.location,
                '${property.priceMonthly.toStringAsFixed(0)} د.أ / شهر',
              ],
            ),
            const SizedBox(height: 12),
            _tenantSummaryCard(context, tenantId: tenantId, tenant: tenant),
            const SizedBox(height: 16),
            TenantReputationCard(tenantId: tenantId),
            const SizedBox(height: 20),
            Text(
              'رسالة للمالك (اختياري)',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _message,
              minLines: 3,
              maxLines: 5,
              textAlign: TextAlign.right,
              style: EjariColors.inputTextStyle,
              decoration: InputDecoration(
                hintText: 'أدخل أي تفاصيل إضافية...',
                hintStyle: EjariColors.inputHintStyle,
                filled: true,
                fillColor: EjariColors.card,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('تم الإرسال'),
                      content: const Text('تم استلام طلبك بنجاح. سيتواصل معك المالك أو المنصة قريباً.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            context.pop();
                          },
                          child: const Text('حسناً'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('إرسال الطلب'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _tenantSummaryCard(
    BuildContext context, {
    required String tenantId,
    required UserModel tenant,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'المستأجر',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: EjariColors.textSecondary),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => pushPublicProfile(context, tenantId),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                tenant.fullName,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: EjariColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: EjariColors.primary,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tenant.phone ?? '',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            tenant.email ?? '',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  static Widget _summaryCard(
    BuildContext context, {
    required String title,
    required List<String> lines,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: EjariColors.textSecondary),
          ),
          const SizedBox(height: 8),
          ...lines.map(
            (l) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                l,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

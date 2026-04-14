import 'package:flutter/material.dart';
import 'package:ejari/data/public_profile_repository.dart';
import 'package:ejari/models/public_profile_model.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/public_profile_review_entry.dart';
import 'package:ejari/screens/public_profile_all_reviews_screen.dart';

class PublicProfileScreen extends StatelessWidget {
  const PublicProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: AppBar(
          title: const Text('الملف العام'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FutureBuilder<PublicProfileData?>(
          future: loadPublicProfile(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data;
            if (data == null) {
              return const Center(child: Text('المستخدم غير موجود.'));
            }
            final u = data.user;
            final summary = data.ratingSummary;
            final isAgency = u.role == 'office' || u.userType == 'agency';
            final last10 = summary.entries.length <= 10 ? summary.entries : summary.entries.sublist(0, 10);

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                Text(
                  u.fullName,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(
                  _roleLabel(u.role, u.userType),
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EjariColors.textSecondary),
                ),
                const SizedBox(height: 12),
                Text('الهاتف: ${u.phone ?? '—'}', textAlign: TextAlign.right),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      summary.averageRating > 0 ? summary.averageRating.toStringAsFixed(1) : '—',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: EjariColors.primary,
                          ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.star_rounded, color: EjariColors.starFilled, size: 28),
                    const SizedBox(width: 8),
                    Text('(${data.reviewCount} تقييم)', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: 20),
                if (data.owner != null) ...[
                  _sectionTitle(context, 'بيانات المالك'),
                  _infoLine(context, 'عدد العقارات المملوكة', '${data.owner!.ownedPropertyCount}'),
                  _infoLine(
                    context,
                    'متوسط استجابته للصيانة (من التقييمات)',
                    data.owner!.avgMaintenanceFromReviews > 0
                        ? data.owner!.avgMaintenanceFromReviews.toStringAsFixed(1)
                        : '—',
                  ),
                  const SizedBox(height: 8),
                  Text('عناوين العقارات (بدون تفاصيل حساسة)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  ...data.owner!.properties.map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text('${p.title} — ${p.rooms} غرف'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (data.tenant != null) ...[
                  _sectionTitle(context, 'بيانات المستأجر'),
                  _infoLine(context, 'عدد العقود السابقة', '${data.tenant!.pastContractsCount}'),
                  _infoLine(context, 'نسبة الالتزام بالدفع (تقدير)', '${data.tenant!.paymentCompliancePercent}%'),
                  _infoLine(context, 'الشكاوى المقدمة ضده', '${data.tenant!.complaintsCount}'),
                  const SizedBox(height: 16),
                ],
                if (data.agency != null) ...[
                  _sectionTitle(context, 'بيانات المكتب العقاري'),
                  _infoLine(context, 'رقم الترخيص التجاري', data.agency!.licenseNumber),
                  _infoLine(context, 'عدد العقارات المدارة', '${data.agency!.managedPropertiesCount}'),
                  _infoLine(context, 'عدد العقود عبر المكتب', '${data.agency!.completedContractsCount}'),
                  _infoLine(
                    context,
                    'متوسط نسبة العمولة (من السجل)',
                    '${data.agency!.averageCommissionPercent.toStringAsFixed(1)}٪',
                  ),
                  const SizedBox(height: 16),
                ],
                _sectionTitle(context, 'آخر التقييمات'),
                const SizedBox(height: 8),
                if (last10.isEmpty)
                  Text(
                    'لا توجد تقييمات بعد.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EjariColors.textSecondary),
                  )
                else
                  ...last10.map(
                    (e) => PublicProfileReviewEntry(
                      entry: e,
                      agencyCriteriaLabels: isAgency,
                    ),
                  ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: summary.entries.isEmpty
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (ctx) => PublicProfileAllReviewsScreen(userId: userId),
                              ),
                            );
                          },
                    child: const Text('عرض كل التقييمات'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static String _roleLabel(String role, String? userType) {
    if (userType == 'agency' || role == 'office') return 'مكتب عقاري';
    if (role == 'owner') return 'مالك';
    if (role == 'tenant') return 'مستأجر';
    return role;
  }

  static Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }

  static Widget _infoLine(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 140,
            child: Text(
              label,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

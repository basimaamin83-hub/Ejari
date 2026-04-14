import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/models/contract_model.dart';
import 'package:ejari/models/rating_models.dart';
import 'package:ejari/state/ratings_notifier.dart';
import 'package:ejari/state/tenant_contract_notifier.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/rating_prior_review_tiles.dart';

class LandlordRatingScreen extends StatefulWidget {
  const LandlordRatingScreen({super.key});

  @override
  State<LandlordRatingScreen> createState() => _LandlordRatingScreenState();
}

class _LandlordRatingScreenState extends State<LandlordRatingScreen> {
  int _cooperation = 0;
  int _maintenance = 0;
  int _responsiveness = 0;
  int _transparency = 0;
  bool _hideTenantName = false;
  bool _showAllPriorReviews = false;

  final TextEditingController _comment = TextEditingController();

  ContractModel? get _contract {
    final u = ejariSession.user;
    if (u == null || ejariSession.isGuest) return null;
    return tenantContractNotifier.activeContract(u.id);
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  String _periodLabel(ContractModel c) {
    final sy = c.startYear;
    final ey = c.endYear;
    if (sy != null && ey != null) {
      return '$sy – $ey';
    }
    return 'السنة الحالية';
  }

  void _submit() {
    final contract = _contract;
    final u = ejariSession.user;
    if (contract == null || u == null) return;

    if (_cooperation == 0 ||
        _maintenance == 0 ||
        _responsiveness == 0 ||
        _transparency == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار جميع المعايير (نجمة واحدة على الأقل لكل بند)')),
      );
      return;
    }

    if (ratingsNotifier.tenantHasRatedLandlord(
      contractId: contract.id,
      tenantId: u.id,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تقييم هذا المالك على هذا العقد مسبقاً.')),
      );
      return;
    }

    final landlordId = contract.landlordId ?? propertyById(contract.propertyId)?.ownerId;
    if (landlordId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر تحديد المالك من العقد.')),
      );
      return;
    }

    final review = LandlordReview(
      id: 'lr-${DateTime.now().millisecondsSinceEpoch}',
      contractId: contract.id,
      landlordId: landlordId,
      tenantId: u.id,
      tenantDisplayName: u.fullName,
      hideTenantName: _hideTenantName,
      reviewedAt: DateTime.now(),
      criteria: LandlordCriteria(
        cooperation: _cooperation,
        maintenance: _maintenance,
        responsiveness: _responsiveness,
        transparency: _transparency,
      ),
      comment: _comment.text.trim().isEmpty ? null : _comment.text.trim(),
    );
    ratingsNotifier.submitLandlordReview(review);

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تم'),
        content: const Text('تم إرسال تقييمك بنجاح وسيظهر في سجل المالك.'),
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
  }

  @override
  Widget build(BuildContext context) {
    final contract = _contract;
    if (contract == null) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('تقييم المالك')),
          body: const Center(child: Text('لا يوجد عقد نشط لعرضه.')),
        ),
      );
    }

    final landlordId = contract.landlordId ?? propertyById(contract.propertyId)?.ownerId;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListenableBuilder(
        listenable: Listenable.merge([ejariSession, ratingsNotifier]),
        builder: (context, _) {
          final u = ejariSession.user;
          final alreadyRated = u != null &&
              ratingsNotifier.tenantHasRatedLandlord(
                contractId: contract.id,
                tenantId: u.id,
              );

          final priorReviews = (landlordId != null && u != null)
              ? ratingsNotifier.landlordReviewsFromOtherTenants(landlordId, u.id)
              : <LandlordReview>[];
          final shownPrior = _showAllPriorReviews
              ? priorReviews
              : priorReviews.take(5).toList();
          final hasMorePrior = priorReviews.length > 5;

          return Scaffold(
            backgroundColor: EjariColors.background,
            appBar: AppBar(
              title: const Text('تقييم المالك'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => context.pop(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: EjariColors.card,
                        borderRadius: BorderRadius.circular(16),
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
                            'معلومات العقد',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: EjariColors.textSecondary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            contract.addressLabel,
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'الفترة: ${_periodLabel(contract)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'الإيجار الحالي: ${contract.monthlyRent.toStringAsFixed(0)} د.أ / شهر',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (alreadyRated)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: EjariColors.successMutedBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'سبق أن أرسلت تقييماً لهذا العقد.',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    )
                  else ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'المعايير',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 12)),
                    SliverToBoxAdapter(
                      child: _criterionTile('التعاون والتواصل', _cooperation, (v) => setState(() => _cooperation = v)),
                    ),
                    SliverToBoxAdapter(
                      child: _criterionTile('صيانة العقار', _maintenance, (v) => setState(() => _maintenance = v)),
                    ),
                    SliverToBoxAdapter(
                      child: _criterionTile('الاستجابة للطلبات', _responsiveness, (v) => setState(() => _responsiveness = v)),
                    ),
                    SliverToBoxAdapter(
                      child: _criterionTile('الشفافية', _transparency, (v) => setState(() => _transparency = v)),
                    ),
                    SliverToBoxAdapter(
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('إخفاء اسمي وعرض «مستخدم محظوظ»'),
                        value: _hideTenantName,
                        onChanged: (v) => setState(() => _hideTenantName = v ?? false),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            'أضف تعليقاً (اختياري)',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextField(
                          controller: _comment,
                          minLines: 3,
                          maxLines: 5,
                          textAlign: TextAlign.right,
                          style: EjariColors.inputTextStyle,
                          decoration: InputDecoration(
                            hintText: 'اكتب ملاحظاتك هنا...',
                            hintStyle: EjariColors.inputHintStyle,
                            filled: true,
                            fillColor: EjariColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'سيتم عرض هذا التقييم للمالك ولمنصة إيجاري فقط، وفق سياسة الخصوصية المعتمدة.',
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: EjariColors.textSecondary,
                                height: 1.35,
                              ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submit,
                            child: const Text('إرسال التقييم'),
                          ),
                        ),
                      ),
                    ),
                  ],
                  SliverToBoxAdapter(child: Divider(height: alreadyRated ? 24 : 32, color: EjariColors.borderSubtle)),
                  SliverToBoxAdapter(
                    child: Text(
                      'تقييمات سابقة لهذا المالك من مستأجرين سابقين',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 12),
                      child: Text(
                        'ترتيب الأرقام: تعاون، صيانة، استجابة، شفافية',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
                      ),
                    ),
                  ),
                  if (landlordId == null || u == null)
                    SliverToBoxAdapter(
                      child: Text(
                        'تعذر عرض التقييمات السابقة.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EjariColors.textSecondary),
                      ),
                    )
                  else if (priorReviews.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'لا توجد تقييمات سابقة من مستأجرين آخرين.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EjariColors.textSecondary),
                        ),
                      ),
                    )
                  else
                    SliverList.builder(
                      itemCount: shownPrior.length + (hasMorePrior ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < shownPrior.length) {
                          return PriorLandlordReviewTile(review: shownPrior[index]);
                        }
                        return Center(
                          child: TextButton(
                            onPressed: () => setState(() => _showAllPriorReviews = !_showAllPriorReviews),
                            child: Text(_showAllPriorReviews ? 'عرض أقل' : 'عرض الكل'),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _criterionTile(String label, int value, ValueChanged<int> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: EjariColors.secondary.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(5, (i) {
              final star = i + 1;
              return InkWell(
                onTap: () => onChanged(star),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  child: Icon(
                    star <= value ? Icons.star_rounded : Icons.star_border_rounded,
                    color: star <= value ? EjariColors.starFilled : EjariColors.starEmpty,
                    size: 32,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

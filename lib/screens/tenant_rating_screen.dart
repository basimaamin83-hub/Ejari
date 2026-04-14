import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/models/rating_models.dart';
import 'package:ejari/models/tenant_rating_args.dart';
import 'package:ejari/state/ratings_notifier.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/rating_prior_review_tiles.dart';

class TenantRatingScreen extends StatefulWidget {
  const TenantRatingScreen({super.key, required this.args});

  final TenantRatingArgs args;

  @override
  State<TenantRatingScreen> createState() => _TenantRatingScreenState();
}

class _TenantRatingScreenState extends State<TenantRatingScreen> {
  int _payment = 0;
  int _care = 0;
  int _cooperation = 0;
  int _contract = 0;
  final TextEditingController _comment = TextEditingController();
  bool _showAllPriorReviews = false;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final owner = ejariSession.user;
    if (owner == null || owner.role != 'owner') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب تسجيل الدخول كمالك.')),
      );
      return;
    }
    if (_payment == 0 || _care == 0 || _cooperation == 0 || _contract == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار جميع المعايير.')),
      );
      return;
    }
    if (ratingsNotifier.landlordHasRatedTenant(
      contractId: widget.args.contractId,
      landlordId: owner.id,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تقييم هذا المستأجر على هذا العقد مسبقاً.')),
      );
      return;
    }
    final review = TenantReview(
      id: 'tr-${DateTime.now().millisecondsSinceEpoch}',
      contractId: widget.args.contractId,
      landlordId: owner.id,
      tenantId: widget.args.tenantId,
      landlordDisplayName: owner.fullName,
      reviewedAt: DateTime.now(),
      criteria: TenantCriteria(
        paymentTimeliness: _payment,
        propertyCare: _care,
        cooperation: _cooperation,
        contractCompliance: _contract,
      ),
      comment: _comment.text.trim().isEmpty ? null : _comment.text.trim(),
    );
    ratingsNotifier.submitTenantReview(review);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تم'),
        content: const Text('تم إرسال تقييمك بنجاح وسيظهر في سجل المستأجر.'),
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListenableBuilder(
        listenable: Listenable.merge([ejariSession, ratingsNotifier]),
        builder: (context, _) {
          final o = ejariSession.user;
          final rated = o != null &&
              ratingsNotifier.landlordHasRatedTenant(
                contractId: widget.args.contractId,
                landlordId: o.id,
              );

          final priorReviews = o != null
              ? ratingsNotifier.tenantReviewsFromOtherLandlords(
                  widget.args.tenantId,
                  o.id,
                )
              : <TenantReview>[];
          final shownPrior = _showAllPriorReviews
              ? priorReviews
              : priorReviews.take(5).toList();
          final hasMorePrior = priorReviews.length > 5;

          return Scaffold(
            backgroundColor: EjariColors.background,
            appBar: AppBar(
              title: const Text('تقييم المستأجر'),
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
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: EjariColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.args.tenantName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'العقد: ${widget.args.contractId}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'يمكن التقييم مرة واحدة لكل عقد، أثناء العقد أو بعد انتهائه.',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
                    ),
                  ),
                ),
                if (rated)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: EjariColors.successMutedBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'تم إرسال تقييمك لهذا العقد مسبقاً.',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  )
                else ...[
                  SliverToBoxAdapter(
                    child: Text(
                      'المعايير',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  SliverToBoxAdapter(
                    child: _criterionTile('الالتزام بالدفع', _payment, (v) => setState(() => _payment = v)),
                  ),
                  SliverToBoxAdapter(
                    child: _criterionTile('المحافظة على العقار', _care, (v) => setState(() => _care = v)),
                  ),
                  SliverToBoxAdapter(
                    child: _criterionTile('التعاون', _cooperation, (v) => setState(() => _cooperation = v)),
                  ),
                  SliverToBoxAdapter(
                    child: _criterionTile('الالتزام بالعقد', _contract, (v) => setState(() => _contract = v)),
                  ),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'تعليق (اختياري)',
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
                          hintText: 'ملاحظاتك...',
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
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _submit(context),
                          child: const Text('إرسال التقييم'),
                        ),
                      ),
                    ),
                  ),
                ],
                SliverToBoxAdapter(child: Divider(height: rated ? 24 : 32, color: EjariColors.borderSubtle)),
                SliverToBoxAdapter(
                  child: Text(
                    'تقييمات سابقة لهذا المستأجر من مالكين آخرين',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 12),
                    child: Text(
                      'ترتيب الأرقام: دفع، عقار، تعاون، عقد',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
                    ),
                  ),
                ),
                if (priorReviews.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'لا توجد تقييمات سابقة من مالكين آخرين.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EjariColors.textSecondary),
                      ),
                    ),
                  )
                else
                  SliverList.builder(
                    itemCount: shownPrior.length + (hasMorePrior ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < shownPrior.length) {
                        return PriorTenantReviewTile(review: shownPrior[index]);
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

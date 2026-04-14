import 'package:flutter/material.dart';

/// إبلاغ وهمي للمشرف عن تقييم مسيء.
Future<void> showReportReviewDialog(
  BuildContext context, {
  required String reviewId,
}) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => _ReportReviewDialog(reviewId: reviewId),
  );
}

class _ReportReviewDialog extends StatefulWidget {
  const _ReportReviewDialog({required this.reviewId});

  final String reviewId;

  @override
  State<_ReportReviewDialog> createState() => _ReportReviewDialogState();
}

class _ReportReviewDialogState extends State<_ReportReviewDialog> {
  final TextEditingController _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('إبلاغ عن تقييم مسيء'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'سيتم إرسال البلاغ لفريق إيجاري للمراجعة (تجريبي).',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _reason,
            minLines: 2,
            maxLines: 4,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              hintText: 'سبب البلاغ (اختياري)',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
        FilledButton(
          onPressed: () {
            final note = _reason.text.trim();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  note.isEmpty
                      ? 'تم استلام البلاغ رقم #${widget.reviewId} وسيتم مراجعته.'
                      : 'تم استلام البلاغ #${widget.reviewId}: $note',
                ),
              ),
            );
          },
          child: const Text('إرسال'),
        ),
      ],
    );
  }
}

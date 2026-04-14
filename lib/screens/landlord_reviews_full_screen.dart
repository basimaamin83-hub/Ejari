import 'package:flutter/material.dart';
import 'package:ejari/models/rating_models.dart';
import 'package:ejari/state/ratings_notifier.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/landlord_review_tile.dart';

class LandlordReviewsFullScreen extends StatefulWidget {
  const LandlordReviewsFullScreen({super.key, required this.ownerId});

  final String ownerId;

  @override
  State<LandlordReviewsFullScreen> createState() => _LandlordReviewsFullScreenState();
}

class _LandlordReviewsFullScreenState extends State<LandlordReviewsFullScreen> {
  LandlordReviewSort _sort = LandlordReviewSort.newest;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListenableBuilder(
        listenable: ratingsNotifier,
        builder: (context, _) {
          final list = ratingsNotifier.landlordReviewsFiltered(widget.ownerId, _sort);
          return Scaffold(
            backgroundColor: EjariColors.background,
            appBar: AppBar(
              title: const Text('كل تقييمات المالك'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: DropdownButton<LandlordReviewSort>(
                    value: _sort,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(
                        value: LandlordReviewSort.newest,
                        child: Text('الأحدث'),
                      ),
                      DropdownMenuItem(
                        value: LandlordReviewSort.highestRating,
                        child: Text('الأعلى تقييماً'),
                      ),
                      DropdownMenuItem(
                        value: LandlordReviewSort.lowestRating,
                        child: Text('الأقل تقييماً'),
                      ),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _sort = v);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                if (list.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('لا توجد تقييمات.'),
                    ),
                  )
                else
                  ...list.map((r) => LandlordReviewTile(review: r)),
              ],
            ),
          );
        },
      ),
    );
  }
}

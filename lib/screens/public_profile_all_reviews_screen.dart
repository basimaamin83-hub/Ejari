import 'package:flutter/material.dart';
import 'package:ejari/data/public_profile_repository.dart';
import 'package:ejari/models/public_profile_model.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/public_profile_review_entry.dart';

class PublicProfileAllReviewsScreen extends StatelessWidget {
  const PublicProfileAllReviewsScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: AppBar(
          title: const Text('كل التقييمات'),
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
            final isAgency = data.user.role == 'office' || data.user.userType == 'agency';
            final entries = data.ratingSummary.entries;
            if (entries.isEmpty) {
              return const Center(child: Text('لا توجد تقييمات.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: entries.length,
              itemBuilder: (context, i) {
                return PublicProfileReviewEntry(
                  entry: entries[i],
                  agencyCriteriaLabels: isAgency,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

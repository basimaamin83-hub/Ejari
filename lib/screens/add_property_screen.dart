import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/l10n/app_localizations.dart';
import 'package:ejari/theme/app_theme.dart';

/// شاشة مبدئية لإضافة عقار — تُطوَّر لاحقاً.
class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: EjariColors.background,
      appBar: AppBar(
        title: Text(l10n.addPropertyTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              l10n.addPropertyPlaceholder,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 24),
            TextField(
              textAlign: TextAlign.right,
              style: EjariColors.inputTextStyle,
              decoration: InputDecoration(
                labelText: l10n.addPropertyFieldLabel,
                filled: true,
                fillColor: EjariColors.card,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.pop(),
                child: Text(l10n.addPropertyClose),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

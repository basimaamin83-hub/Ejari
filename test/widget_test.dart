import 'package:flutter_test/flutter_test.dart';
import 'package:ejari/main.dart';
import 'package:ejari/state/locale_notifier.dart';

void main() {
  testWidgets('app builds', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await ejariLocaleNotifier.load();
    await tester.pumpWidget(const EjariApp());
    await tester.pump();
    expect(find.byType(EjariApp), findsOneWidget);
  });
}

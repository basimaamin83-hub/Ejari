import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:ejari/utils/format_date_ar.dart';

/// إنشاء PDF «شهادة إيجاري» مع رمز QR للتحقق (وهمي).
Future<Uint8List> buildEjariCertificatePdf({
  required String certificateId,
  required String verificationUrl,
  required String propertySummary,
  required String lessorName,
  required String tenantName,
  required DateTime leaseStart,
  required DateTime leaseEnd,
  required double monthlyRent,
  required bool isRenewal,
}) async {
  final arabic = await PdfGoogleFonts.notoSansArabicRegular();
  final arabicBold = await PdfGoogleFonts.notoSansArabicBold();

  final doc = pw.Document(
    theme: pw.ThemeData.withFont(base: arabic, bold: arabicBold),
  );

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      textDirection: pw.TextDirection.rtl,
      margin: const pw.EdgeInsets.all(40),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            pw.Text(
              'شهادة عقد إيجار إلكتروني موثّق',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 6),
            pw.Text(
              isRenewal ? 'تجديد عقد' : 'عقد جديد',
              style: const pw.TextStyle(fontSize: 12),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 20),
            pw.Text('رقم الشهادة: $certificateId', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            pw.Text('المؤجر: $lessorName'),
            pw.SizedBox(height: 4),
            pw.Text('المستأجر: $tenantName'),
            pw.SizedBox(height: 8),
            pw.Text('وصف العقار: $propertySummary'),
            pw.SizedBox(height: 8),
            pw.Text('مدة العقد: من ${formatDateAr(leaseStart)} إلى ${formatDateAr(leaseEnd)}'),
            pw.SizedBox(height: 4),
            pw.Text('القيمة الإيجارية الشهرية: ${monthlyRent.toStringAsFixed(0)} دينار أردني'),
            pw.SizedBox(height: 20),
            pw.Text(
              'يُمكن التحقق من صحة هذه الشهادة عبر مسح الرمز أدناه أو زيارة الرابط الإلكتروني.',
              style: const pw.TextStyle(fontSize: 10),
            ),
            pw.SizedBox(height: 12),
            pw.Center(
              child: pw.BarcodeWidget(
                barcode: pw.Barcode.qrCode(),
                data: verificationUrl,
                width: 130,
                height: 130,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Center(
              child: pw.Text(verificationUrl, style: const pw.TextStyle(fontSize: 8)),
            ),
            pw.Spacer(),
            pw.Divider(),
            pw.SizedBox(height: 8),
            pw.Text(
              'أُصدرت هذه الشهادة وفق منظومة «إيجاري» للعقود الإلكترونية. للسجل الإلكتروني والتوقيع الإلكتروني '
              'المنطبقين على هذا العقد — طالما توفرت الشروط المنصوص عليها في القانون — الحجة نفسها المقررة للمستندات الورقية '
              'والتوقيع الخطي، استناداً إلى أحكام قانون المعاملات الإلكترونية الأردني رقم (15) لسنة 2015 ومقتضياته.',
              style: const pw.TextStyle(fontSize: 9),
              textAlign: pw.TextAlign.justify,
            ),
          ],
        );
      },
    ),
  );

  return doc.save();
}

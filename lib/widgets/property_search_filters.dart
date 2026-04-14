import 'package:flutter/material.dart';
import 'package:ejari/data/jordan_locations.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/theme/app_theme.dart';

/// نتيجة تطبيق نموذج التصفية من الـ bottom sheet.
class PropertySearchFiltersResult {
  const PropertySearchFiltersResult({
    required this.governorate,
    this.district,
    required this.minRooms,
    required this.maxPrice,
  });

  final String governorate;
  /// null أو فارغ = كل مناطق المحافظة.
  final String? district;
  final int? minRooms;
  final double? maxPrice;
}

/// شاشة تصفية البحث: محافظة (قائمة منسدلة)، منطقة (قائمة تعتمد على المحافظة)، غرف، سعر.
class PropertySearchFiltersSheet extends StatefulWidget {
  const PropertySearchFiltersSheet({
    super.key,
    required this.initialGovernorate,
    this.initialDistrict,
    required this.initialMinRooms,
    required this.initialMaxPrice,
  });

  final String initialGovernorate;
  final String? initialDistrict;
  final int? initialMinRooms;
  final double? initialMaxPrice;

  @override
  State<PropertySearchFiltersSheet> createState() => _PropertySearchFiltersSheetState();
}

class _PropertySearchFiltersSheetState extends State<PropertySearchFiltersSheet> {
  late String _governorate;
  String? _district;
  late int _tempRooms;
  late double _tempMax;

  @override
  void initState() {
    super.initState();
    _governorate = widget.initialGovernorate;
    _district = widget.initialDistrict;
    _tempRooms = widget.initialMinRooms ?? 0;
    _tempMax = widget.initialMaxPrice ?? 600;
  }

  List<String> get _districtOptions {
    if (_governorate == 'الكل') return const [];
    return governorateDistricts[_governorate] ?? const [];
  }

  void _onGovernorateChanged(String? value) {
    if (value == null) return;
    setState(() {
      _governorate = value;
      _district = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.paddingOf(context).bottom + 20,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: EjariColors.borderSubtle,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'تصفية النتائج',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'المحافظة',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              key: ValueKey('gov_$_governorate'),
              initialValue: _governorate,
              isExpanded: true,
              style: EjariColors.inputTextStyle,
              dropdownColor: EjariColors.card,
              iconEnabledColor: EjariColors.textSecondary,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: governorates
                  .map(
                    (g) => DropdownMenuItem(
                      value: g,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(g),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: _onGovernorateChanged,
            ),
            const SizedBox(height: 16),
            Text(
              'المنطقة / المدينة',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            if (_governorate == 'الكل')
              InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                child: Text(
                  'اختر محافظة أولاً لتحديد المنطقة',
                  style: EjariColors.inputHintStyle,
                ),
              )
            else
              DropdownButtonFormField<String?>(
                key: ValueKey('dist_${_governorate}_${_district ?? 'all'}'),
                initialValue: _district,
                isExpanded: true,
                style: EjariColors.inputTextStyle,
                dropdownColor: EjariColors.card,
                iconEnabledColor: EjariColors.textSecondary,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('كل المناطق'),
                    ),
                  ),
                  ..._districtOptions.map(
                    (d) => DropdownMenuItem<String?>(
                      value: d,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(d),
                      ),
                    ),
                  ),
                ],
                onChanged: (v) => setState(() => _district = v),
              ),
            const SizedBox(height: 20),
            Text(
              _tempRooms == 0 ? 'عدد الغرف: أي عدد' : 'عدد الغرف (حد أدنى): $_tempRooms',
              textAlign: TextAlign.right,
            ),
            Slider(
              value: _tempRooms.toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              label: _tempRooms == 0 ? 'الكل' : '$_tempRooms',
              onChanged: (v) => setState(() => _tempRooms = v.round()),
            ),
            Text(
              _tempMax >= 600
                  ? 'السعر: بدون حد أعلى'
                  : 'الحد الأعلى للسعر الشهري: ${_tempMax.round()} د.أ',
              textAlign: TextAlign.right,
            ),
            Slider(
              value: _tempMax.clamp(100, 600),
              min: 100,
              max: 600,
              divisions: 50,
              label: _tempMax >= 600 ? '600+' : '${_tempMax.round()}',
              onChanged: (v) => setState(() => _tempMax = v),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        const PropertySearchFiltersResult(
                          governorate: 'الكل',
                          district: null,
                          minRooms: null,
                          maxPrice: null,
                        ),
                      );
                    },
                    child: const Text('مسح'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        PropertySearchFiltersResult(
                          governorate: _governorate,
                          district: _district,
                          minRooms: _tempRooms == 0 ? null : _tempRooms,
                          maxPrice: _tempMax >= 600 ? null : _tempMax,
                        ),
                      );
                    },
                    child: const Text('تطبيق'),
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}

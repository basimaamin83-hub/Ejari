import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:ejari/data/rent_price_prediction_mock.dart';
import 'package:ejari/theme/app_theme.dart';

/// معاملات اختيارية عند فتح الشاشة من تفاصيل عقار.
class PricePredictionInitialArgs {
  const PricePredictionInitialArgs({
    this.houseAreaSqm,
    this.outdoorAreaSqm,
    this.buildingAgeYears,
    this.floor,
    this.tenantRating,
  });

  final double? houseAreaSqm;
  final double? outdoorAreaSqm;
  final int? buildingAgeYears;
  final PredictionFloor? floor;
  final double? tenantRating;
}

class _MaintEntry {
  _MaintEntry() : id = _nextId++, controller = TextEditingController();
  static int _nextId = 0;
  final int id;
  final TextEditingController controller;
  DateTime date = DateTime.now();

  void dispose() => controller.dispose();
}

class PricePredictionScreen extends StatefulWidget {
  const PricePredictionScreen({super.key, this.initial});

  final PricePredictionInitialArgs? initial;

  @override
  State<PricePredictionScreen> createState() => _PricePredictionScreenState();
}

class _PricePredictionScreenState extends State<PricePredictionScreen> {
  final _houseAreaCtrl = TextEditingController();
  final _outdoorAreaCtrl = TextEditingController(text: '0');

  int _buildingAge = 10;
  PredictionFloor _floor = PredictionFloor.ground;
  double? _tenantRating;

  final List<_MaintEntry> _maintenance = [];
  final List<TextEditingController> _referencePrices = [];

  double? _fairResultJod;
  bool _loading = false;

  static final _numFormat = NumberFormat('#,##0.##', 'ar');

  @override
  void initState() {
    super.initState();
    final i = widget.initial;
    if (i?.houseAreaSqm != null) {
      _houseAreaCtrl.text = _trimNum(i!.houseAreaSqm!);
    }
    if (i?.outdoorAreaSqm != null) {
      _outdoorAreaCtrl.text = _trimNum(i!.outdoorAreaSqm!);
    }
    if (i?.buildingAgeYears != null) {
      _buildingAge = i!.buildingAgeYears!.clamp(0, 80);
    }
    if (i?.floor != null) {
      _floor = i!.floor!;
    }
    if (i?.tenantRating != null) {
      final r = i!.tenantRating!;
      if (r >= 1 && r <= 5) {
        _tenantRating = r;
      }
    }
  }

  String _trimNum(double v) {
    if (v == v.roundToDouble()) {
      return v.round().toString();
    }
    return v.toString();
  }

  @override
  void dispose() {
    _houseAreaCtrl.dispose();
    _outdoorAreaCtrl.dispose();
    for (final m in _maintenance) {
      m.dispose();
    }
    for (final c in _referencePrices) {
      c.dispose();
    }
    super.dispose();
  }

  double? _parseDouble(String s) {
    final t = s.trim().replaceAll(',', '.');
    if (t.isEmpty) return null;
    return double.tryParse(t);
  }

  Future<void> _predict() async {
    final house = _parseDouble(_houseAreaCtrl.text);
    if (house == null || house <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل مساحة البيت بقيمة أكبر من صفر.')),
      );
      return;
    }

    final outdoor = _parseDouble(_outdoorAreaCtrl.text) ?? 0;
    if (outdoor < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('مساحة الأرض حول المنزل لا يمكن أن تكون سالبة.')),
      );
      return;
    }

    final refs = <double>[];
    for (final c in _referencePrices) {
      final v = _parseDouble(c.text);
      if (v != null && v > 0) {
        refs.add(v);
      }
    }

    setState(() {
      _loading = true;
      _fairResultJod = null;
    });
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    final fair = computeFairMonthlyPrice(
      houseAreaSqm: house,
      outdoorAreaSqm: outdoor,
      buildingAgeYears: _buildingAge,
      floor: _floor,
      tenantRating: _tenantRating,
      maintenanceEntriesCount: _maintenance.length,
      referenceMonthlyPrices: refs,
    );

    setState(() {
      _fairResultJod = fair;
      _loading = false;
    });
  }

  void _addMaintenance() {
    setState(() {
      _maintenance.add(_MaintEntry());
    });
  }

  void _removeMaintenance(int id) {
    setState(() {
      final i = _maintenance.indexWhere((e) => e.id == id);
      if (i >= 0) {
        _maintenance[i].dispose();
        _maintenance.removeAt(i);
      }
    });
  }

  void _addReferencePrice() {
    setState(() {
      _referencePrices.add(TextEditingController());
    });
  }

  void _removeReferencePrice(int index) {
    setState(() {
      if (index >= 0 && index < _referencePrices.length) {
        _referencePrices[index].dispose();
        _referencePrices.removeAt(index);
      }
    });
  }

  Future<void> _pickDate(_MaintEntry e) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: e.date,
      firstDate: DateTime(1990),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      setState(() => e.date = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.yMd('ar');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: AppBar(
          title: const Text('توقع سعر الإيجار بالذكاء الاصطناعي'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Row(
              children: [
                Icon(Icons.psychology_alt_rounded, color: EjariColors.primary, size: 32),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'توقع ذكي — أدخل المعايير أدناه لحساب سعر إيجار عادل تقريبي (نموذج وهمي).',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _sectionTitle(context, '1. مساحة البيت (م²)'),
            _numField(
              controller: _houseAreaCtrl,
              hint: 'مثال: 120',
              onChanged: (_) => setState(() => _fairResultJod = null),
            ),

            const SizedBox(height: 16),
            _sectionTitle(context, '2. مساحة الأرض حول المنزل (حديقة، فناء، سطح — م²)'),
            _numField(
              controller: _outdoorAreaCtrl,
              hint: 'يمكن أن تكون 0',
              onChanged: (_) => setState(() => _fairResultJod = null),
            ),

            const SizedBox(height: 16),
            _sectionTitle(context, '3. عمر البناء (سنوات)'),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    min: 0,
                    max: 60,
                    divisions: 60,
                    label: '$_buildingAge',
                    value: _buildingAge.toDouble(),
                    onChanged: (v) {
                      setState(() {
                        _buildingAge = v.round();
                        _fairResultJod = null;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: Text(
                    '$_buildingAge',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            _sectionTitle(context, '4. الطابق'),
            _PredictionDropdown<PredictionFloor>(
              value: _floor,
              items: PredictionFloor.values
                  .map(
                    (f) => DropdownMenuItem(
                      value: f,
                      child: Text(f.arabicLabel, textAlign: TextAlign.right),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  _floor = v;
                  _fairResultJod = null;
                });
              },
            ),

            const SizedBox(height: 16),
            _sectionTitle(context, '5. تقييم المستأجرين السابقين (اختياري، من 1 إلى 5)'),
            _PredictionDropdown<double?>(
              value: _tenantRating,
              items: [
                const DropdownMenuItem<double?>(
                  value: null,
                  child: Text('بدون — لا يؤثر', textAlign: TextAlign.right),
                ),
                ...List.generate(5, (i) {
                  final s = (i + 1).toDouble();
                  return DropdownMenuItem<double?>(
                    value: s,
                    child: Text('$s من 5', textAlign: TextAlign.right),
                  );
                }),
              ],
              onChanged: (v) {
                setState(() {
                  _tenantRating = v;
                  _fairResultJod = null;
                });
              },
            ),

            const SizedBox(height: 16),
            _sectionTitle(context, '6. عمليات الصيانة (أول 3 تضيف 5 دينار لكل منها)'),
            ..._maintenance.map((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Material(
                  color: EjariColors.card,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: e.controller,
                          decoration: const InputDecoration(
                            hintText: 'وصف بسيط، مثال: تبديل مكيف',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: (_) => setState(() => _fairResultJod = null),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: () => _pickDate(e),
                              icon: const Icon(Icons.calendar_today_rounded, size: 18),
                              label: Text(dateFmt.format(e.date)),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => _removeMaintenance(e.id),
                              icon: const Icon(Icons.delete_outline_rounded),
                              color: Colors.red.shade700,
                              tooltip: 'حذف',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            OutlinedButton.icon(
              onPressed: _addMaintenance,
              icon: const Icon(Icons.add_rounded),
              label: const Text('إضافة صيانة'),
            ),

            const SizedBox(height: 20),
            _sectionTitle(context, '7. أسعار شقق مرجعية في نفس المنطقة (دينار/شهر)'),
            ...List.generate(_referencePrices.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _referencePrices[index],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                        ],
                        decoration: InputDecoration(
                          hintText: 'سعر ${index + 1}',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: EjariColors.card,
                        ),
                        onChanged: (_) => setState(() => _fairResultJod = null),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _removeReferencePrice(index),
                      icon: const Icon(Icons.close_rounded),
                      color: EjariColors.textSecondary,
                    ),
                  ],
                ),
              );
            }),
            OutlinedButton.icon(
              onPressed: _addReferencePrice,
              icon: const Icon(Icons.add_chart_rounded),
              label: const Text('إضافة سعر مرجعي'),
            ),

            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _loading ? null : _predict,
                icon: _loading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.auto_awesome_rounded),
                label: Text(_loading ? 'جاري الحساب...' : 'توقع السعر'),
              ),
            ),

            if (_fairResultJod != null) ...[
              const SizedBox(height: 28),
              _FairResultCard(valueJod: _fairResultJod!, formatted: _numFormat.format(_fairResultJod!)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _numField({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
      ],
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: EjariColors.card,
      ),
      onChanged: onChanged,
    );
  }
}

class _FairResultCard extends StatelessWidget {
  const _FairResultCard({required this.valueJod, required this.formatted});

  final double valueJod;
  final String formatted;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: EjariColors.card,
      elevation: 2,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: EjariColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'توقع ذكي',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: EjariColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.psychology_alt_rounded, color: EjariColors.primary, size: 22),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'السعر العادل المتوقع: $formatted دينار/شهر',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: EjariColors.primary,
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'الحساب وهمي ويُفترض إدخالاً دقيقاً؛ يُستخدم كدليل تقريبي فقط.',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary, height: 1.35),
            ),
          ],
        ),
      ),
    );
  }
}

class _PredictionDropdown<T> extends StatelessWidget {
  const _PredictionDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: EjariColors.borderSubtle),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          items: items,
          onChanged: onChanged,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

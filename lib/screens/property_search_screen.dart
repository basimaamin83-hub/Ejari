import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/models/property_model.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/utils/image_urls.dart';
import 'package:ejari/widgets/property_search_filters.dart';

class PropertySearchScreen extends StatefulWidget {
  const PropertySearchScreen({super.key});

  @override
  State<PropertySearchScreen> createState() => _PropertySearchScreenState();
}

class _PropertySearchScreenState extends State<PropertySearchScreen> {
  final TextEditingController _query = TextEditingController();

  String _governorateFilter = 'الكل';
  String? _districtFilter;
  int? _minRooms;
  double? _maxPrice;

  List<PropertyModel> get _results {
    var list = filterProperties(
      governorateFilter: _governorateFilter,
      districtFilter: _districtFilter,
      minRooms: _minRooms,
      maxPrice: _maxPrice,
    );
    final q = _query.text.trim();
    if (q.isNotEmpty) {
      list = list
          .where((p) =>
              p.title.contains(q) ||
              p.location.contains(q) ||
              p.governorate.contains(q) ||
              p.district.contains(q))
          .toList();
    }
    return list;
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  Future<void> _openFilters() async {
    final saved = await showModalBottomSheet<PropertySearchFiltersResult?>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => PropertySearchFiltersSheet(
        initialGovernorate: _governorateFilter,
        initialDistrict: _districtFilter,
        initialMinRooms: _minRooms,
        initialMaxPrice: _maxPrice,
      ),
    );

    if (!mounted) return;
    if (saved != null) {
      setState(() {
        _governorateFilter = saved.governorate;
        _districtFilter = saved.governorate == 'الكل' ? null : saved.district;
        _minRooms = saved.minRooms;
        _maxPrice = saved.maxPrice;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(12, 44, 12, 72),
                    decoration: const BoxDecoration(
                      gradient: EjariGradients.header,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () => context.pop(),
                              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
                              label: const Text('رجوع', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            'ابحث عن مسكنك',
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            'اكتشف أفضل الشقق المتاحة للإيجار في الأردن',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    start: 16,
                    end: 16,
                    bottom: -28,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: _openFilters,
                              icon: const Icon(Icons.tune_rounded, color: EjariColors.primary),
                              tooltip: 'تصفية',
                            ),
                            IconButton(
                              onPressed: () => context.push(AppRoutes.pricePrediction),
                              icon: const Icon(Icons.auto_awesome_rounded, color: EjariColors.primary),
                              tooltip: 'توقع السعر حسب المنطقة',
                            ),
                            Expanded(
                              child: TextField(
                                controller: _query,
                                onChanged: (_) => setState(() {}),
                                textAlign: TextAlign.right,
                                style: EjariColors.inputTextStyle,
                                decoration: InputDecoration(
                                  hintText: 'ابحث بالمنطقة أو المدينة...',
                                  hintStyle: EjariColors.inputHintStyle,
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.search, color: EjariColors.textSecondary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 44)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: governorates.map((g) {
                    final active = _governorateFilter == g;
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8),
                      child: ActionChip(
                        label: Text(g),
                        onPressed: () => setState(() {
                          _governorateFilter = g;
                          _districtFilter = null;
                        }),
                        backgroundColor: active ? EjariColors.primary : EjariColors.card,
                        side: BorderSide(
                          color: active ? EjariColors.primary : EjariColors.borderSubtle,
                        ),
                        labelStyle: TextStyle(
                          color: active ? Colors.white : EjariColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (_districtFilter != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: InputChip(
                      label: Text('المنطقة: $_districtFilter'),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () => setState(() => _districtFilter = null),
                    ),
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  children: [
                    Icon(Icons.chevron_right, color: EjariColors.iconMuted, size: 20),
                    Expanded(
                      child: Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: EjariColors.borderSubtle,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Icon(Icons.chevron_left, color: EjariColors.iconMuted, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'تم العثور على ${results.length} عقار',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverList.separated(
                itemCount: results.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final p = results[index];
                  return _PropertyCard(
                    property: p,
                    onTap: () => context.push(AppRoutes.propertyPath(p.id)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({required this.property, required this.onTap});

  final PropertyModel property;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final seed = property.primaryImageSeed ?? property.id;

    return Material(
      color: EjariColors.card,
      elevation: 2,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Image.network(
                      ejariPlaceholderImage(seed),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: EjariColors.borderSubtle,
                        child: Icon(Icons.home_work_outlined, size: 48, color: EjariColors.secondary.withValues(alpha: 0.65)),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 10,
                    end: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: EjariColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'متاحة الآن',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 10,
                    start: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${property.rating}',
                            style: const TextStyle(fontWeight: FontWeight.w800, color: EjariColors.primary),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.star_rounded, color: EjariColors.starFilled, size: 18),
                          Text(
                            ' (${property.reviewCount})',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    property.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: EjariColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        property.location,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.location_on_outlined, size: 18, color: EjariColors.textSecondary),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _feat(Icons.bed_outlined, '${property.rooms} غرف'),
                      const SizedBox(width: 12),
                      _feat(Icons.bathtub_outlined, '${property.bathrooms} حمام'),
                      const SizedBox(width: 12),
                      _feat(Icons.square_foot_rounded, '${property.areaSqm} م²'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 8,
                    runSpacing: 8,
                    children: property.tags
                        .map((t) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: EjariColors.surfaceMuted,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(t, style: Theme.of(context).textTheme.bodySmall),
                            ))
                        .toList(),
                  ),
                  const Divider(height: 22),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${property.ownerRating}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.star_rounded, color: EjariColors.starFilled, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                'تقييم المالك',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                property.ownerName,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.person_outline_rounded, size: 18, color: EjariColors.textSecondary),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            property.priceMonthly.toStringAsFixed(0),
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: EjariColors.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          Text(
                            'د.أ/شهر',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _feat(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        const SizedBox(width: 4),
        Icon(icon, size: 18, color: EjariColors.textSecondary),
      ],
    );
  }
}

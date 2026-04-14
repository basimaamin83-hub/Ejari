import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/models/agency_models.dart';
import 'package:ejari/models/property_model.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/utils/image_urls.dart';
import 'package:ejari/widgets/public_profile_nav.dart';
import 'package:ejari/widgets/agency_app_bar.dart';

/// وسيط للتنقل إلى تفاصيل صيانة/مدفوعات مع سياق المالك.
class AgencyManagedPropertyArgs {
  const AgencyManagedPropertyArgs({required this.propertyId, this.ownerContextLabel});

  final String propertyId;
  final String? ownerContextLabel;
}

/// قائمة المالكين المرتبطين بالمكتب، ثم عقارات كل مالك مع الصيانة والمدفوعات.
class AgencyPropertyManagementScreen extends StatelessWidget {
  const AgencyPropertyManagementScreen({super.key});

  static String _fmt(DateTime d) => '${d.year}/${d.month}/${d.day}';

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }
    final owners = agencyOwnersFor(aid);
    final reminders = agencyRentRemindersFor(aid);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: const Text('إدارة الأملاك'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('سيتم إضافة مالك جديد (وهمي) — الربط مع سند قيد التطوير')),
            );
          },
          icon: const Icon(Icons.person_add_alt_1_outlined),
          label: const Text('إضافة مالك جديد'),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
          children: [
            if (reminders.isNotEmpty) ...[
              Text(
                'إشعارات التطبيق — تذكير دفع إيجار (وهمي، قبل 5 أيام من الاستحقاق)',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              ...reminders.map(
                (r) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 2,
                  shadowColor: EjariColors.textPrimary.withValues(alpha: 0.06),
                  color: EjariColors.card,
                  child: ListTile(
                    leading: const Icon(Icons.notifications_active_rounded, color: EjariColors.primary),
                    title: Text(
                      'تذكير للمستأجر ${r.tenantName}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      '${r.propertyTitle}\nاستحقاق الإيجار: ${_fmt(r.dueDate)} — سيتم إشعار المستأجر تلقائياً (تجريبي)',
                      textAlign: TextAlign.right,
                    ),
                    isThreeLine: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              'الملاك المتعاملون مع المكتب',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'اختر مالكاً لعرض عقاراته المُدارة والصيانة والمدفوعات.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 12),
            ...owners.map((o) {
              final count = agencyPropertiesForOwner(aid, o.ownerId).length;
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                elevation: 2,
                shadowColor: EjariColors.textPrimary.withValues(alpha: 0.06),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: EjariColors.accent.withValues(alpha: 0.35),
                    child: const Icon(Icons.person_outline, color: EjariColors.textPrimary),
                  ),
                  title: InkWell(
                    onTap: () => pushPublicProfile(context, o.ownerId),
                    child: Text(
                      o.fullName,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: EjariColors.link,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.underline,
                            decorationColor: EjariColors.link,
                          ),
                    ),
                  ),
                  subtitle: Text(
                    '${o.phone}\n$count عقار تحت إدارة المكتب',
                    textAlign: TextAlign.right,
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => context.push(AppRoutes.agencyManagedOwnerPath(o.ownerId)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// عقارات مالك محدد ضمن سياق المكتب.
class AgencyOwnerManagedAssetsScreen extends StatelessWidget {
  const AgencyOwnerManagedAssetsScreen({super.key, required this.ownerId});

  final String ownerId;

  static String _fmt(DateTime d) => '${d.year}/${d.month}/${d.day}';

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }
    final match = agencyOwnersFor(aid).where((o) => o.ownerId == ownerId);
    if (match.isEmpty) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: agencyGradientAppBar(title: const Text('مالك')),
          body: const Center(child: Text('المالك غير مرتبط بهذا المكتب.')),
        ),
      );
    }
    final owner = match.first;
    final props = agencyPropertiesForOwner(aid, ownerId);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(owner.fullName, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(
                'عقارات تحت إدارة المكتب',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.85)),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            Card(
              elevation: 2,
              shadowColor: EjariColors.textPrimary.withValues(alpha: 0.06),
              child: ListTile(
                title: Text(owner.fullName, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(owner.phone, textAlign: TextAlign.right),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new_rounded, color: EjariColors.link),
                  onPressed: () => pushPublicProfile(context, owner.ownerId),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'العقارات (${props.length})',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            ...props.map((p) => _ownerPropertyCard(context, p, owner.fullName)),
          ],
        ),
      ),
    );
  }

  Widget _ownerPropertyCard(BuildContext context, PropertyModel p, String ownerLabel) {
    final seed = p.primaryImageSeed ?? p.id;
    final mnt = p.maintenanceRequests.length;
    final paysList = agencyRentPaymentsForProperty(p.id);
    final pays = paysList.length;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shadowColor: EjariColors.textPrimary.withValues(alpha: 0.06),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    ejariPlaceholderImage(seed, w: 120, h: 90),
                    width: 96,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 96,
                      height: 72,
                      color: EjariColors.borderSubtle,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(p.title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                      Text(p.location, style: Theme.of(context).textTheme.bodySmall),
                      Text(
                        '${p.priceMonthly.toStringAsFixed(0)} د.أ / شهر',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: EjariColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 8,
                        children: [
                          Chip(
                            label: Text('صيانة: $mnt', style: const TextStyle(fontSize: 11)),
                            visualDensity: VisualDensity.compact,
                            backgroundColor: EjariColors.surfaceMuted,
                          ),
                          Chip(
                            label: Text('دفعات: $pays', style: const TextStyle(fontSize: 11)),
                            visualDensity: VisualDensity.compact,
                            backgroundColor: EjariColors.surfaceMuted,
                          ),
                          Chip(
                            label: Text(p.availableNow ? 'شاغر' : 'مؤجر', style: const TextStyle(fontSize: 11)),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (p.maintenanceRequests.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'آخر صيانة: ${p.maintenanceRequests.first.description}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (paysList.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'آخر استحقاق: ${_fmt(paysList.first.dueDate)}',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
              ),
            ],
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: () {
                context.push(
                  AppRoutes.agencyManagedPropertyPath(p.id),
                  extra: AgencyManagedPropertyArgs(propertyId: p.id, ownerContextLabel: ownerLabel),
                );
              },
              icon: const Icon(Icons.handyman_outlined, size: 20),
              label: const Text('الصيانة والمدفوعات والإخلاء'),
            ),
          ],
        ),
      ),
    );
  }
}

class AgencyManagedPropertyDetailScreen extends StatefulWidget {
  const AgencyManagedPropertyDetailScreen({super.key, required this.propertyId, this.ownerContextLabel});

  final String propertyId;
  final String? ownerContextLabel;

  @override
  State<AgencyManagedPropertyDetailScreen> createState() => _AgencyManagedPropertyDetailScreenState();
}

class _EvictionNoticeMock {
  _EvictionNoticeMock({
    required this.reason,
    required this.vacateDate,
    required this.issuedAt,
  });

  final String reason;
  final DateTime vacateDate;
  final DateTime issuedAt;
}

class _AgencyManagedPropertyDetailScreenState extends State<AgencyManagedPropertyDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  late List<AgencyMaintenanceRequestModel> _maintenance;
  final List<_EvictionNoticeMock> _evictions = [];
  int _mntIdCounter = 1000;

  static String _fmt(DateTime d) => '${d.year}/${d.month}/${d.day}';

  @override
  void initState() {
    super.initState();
    _maintenance = List.from(agencyMaintenanceForProperty(widget.propertyId));
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() => _tabIndex = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _mntStatusLabel(String status) {
    return switch (status) {
      'open' => 'مفتوحة',
      'in_progress' => 'قيد التنفيذ',
      'completed' => 'منجزة',
      _ => status,
    };
  }

  String _payStatusLabel(AgencyRentPaymentDisplayStatus s) {
    return switch (s) {
      AgencyRentPaymentDisplayStatus.paid => 'مدفوع',
      AgencyRentPaymentDisplayStatus.overdue => 'متأخر',
      AgencyRentPaymentDisplayStatus.pending => 'مستحق',
    };
  }

  Color _payStatusColor(AgencyRentPaymentDisplayStatus s) {
    return switch (s) {
      AgencyRentPaymentDisplayStatus.paid => EjariColors.success,
      AgencyRentPaymentDisplayStatus.overdue => EjariColors.danger,
      AgencyRentPaymentDisplayStatus.pending => EjariColors.warning,
    };
  }

  Future<void> _openAddMaintenance() async {
    final descCtrl = TextEditingController();
    DateTime reported = DateTime.now();
    String? fakeImage;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.paddingOf(ctx).bottom + MediaQuery.viewInsetsOf(ctx).bottom + 20,
          ),
          child: StatefulBuilder(
            builder: (context, setModal) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'طلب صيانة جديد (وهمي)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descCtrl,
                      decoration: const InputDecoration(
                        labelText: 'وصف المشكلة',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      title: Text('تاريخ البلاغ: ${_fmt(reported)}', textAlign: TextAlign.right),
                      trailing: const Icon(Icons.calendar_today_outlined),
                      onTap: () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: reported,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2027),
                        );
                        if (d != null) setModal(() => reported = d);
                      },
                    ),
                    OutlinedButton.icon(
                      onPressed: () => setModal(() => fakeImage = 'مرفق_${DateTime.now().millisecondsSinceEpoch}.jpg'),
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                      label: Text(fakeImage == null ? 'رفع صورة (وهمي)' : 'تم اختيار: $fakeImage'),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        if (descCtrl.text.trim().isEmpty) return;
                        _mntIdCounter++;
                        setState(() {
                          _maintenance.insert(
                            0,
                            AgencyMaintenanceRequestModel(
                              id: 'mnt-new-$_mntIdCounter',
                              propertyId: widget.propertyId,
                              tenantName: 'المستأجر',
                              description: descCtrl.text.trim(),
                              reportedAt: reported,
                              status: 'open',
                              imageFileName: fakeImage,
                            ),
                          );
                        });
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم تسجيل طلب الصيانة (وهمي)')),
                        );
                      },
                      child: const Text('إرسال الطلب'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
    descCtrl.dispose();
  }

  Future<void> _openEvictionDialog() async {
    final reasonCtrl = TextEditingController();
    DateTime vacate = DateTime.now().add(const Duration(days: 30));

    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('إصدار إشعار إخلاء'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: reasonCtrl,
                    decoration: const InputDecoration(
                      labelText: 'سبب الإخلاء',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  StatefulBuilder(
                    builder: (context, setSt) {
                      return ListTile(
                        title: Text('تاريخ الإخلاء: ${_fmt(vacate)}', textAlign: TextAlign.right),
                        trailing: const Icon(Icons.event_outlined),
                        onTap: () async {
                          final d = await showDatePicker(
                            context: context,
                            initialDate: vacate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                          if (d != null) setSt(() => vacate = d);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
              FilledButton(
                onPressed: () {
                  if (reasonCtrl.text.trim().isEmpty) return;
                  setState(() {
                    _evictions.insert(
                      0,
                      _EvictionNoticeMock(
                        reason: reasonCtrl.text.trim(),
                        vacateDate: vacate,
                        issuedAt: DateTime.now(),
                      ),
                    );
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إرسال إشعار إخلاء وهمي للمستأجر')),
                  );
                },
                child: const Text('إرسال'),
              ),
            ],
          ),
        );
      },
    );
    reasonCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }
    final property = agencyPropertyById(widget.propertyId);
    if (property == null || property.agencyId != aid) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: agencyGradientAppBar(title: const Text('عقار')),
          body: const Center(child: Text('العقار غير موجود أو لا يتبع مكتبك.')),
        ),
      );
    }

    final payments = agencyRentPaymentsForProperty(widget.propertyId);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(property.title, maxLines: 1, overflow: TextOverflow.ellipsis),
              if (widget.ownerContextLabel != null)
                Text(
                  'المالك: ${widget.ownerContextLabel}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.88),
                        fontWeight: FontWeight.w500,
                      ),
                ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: EjariColors.accent,
            labelColor: EjariColors.onPrimaryFg,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(text: 'طلبات الصيانة'),
              Tab(text: 'سجل المدفوعات'),
              Tab(text: 'إشعارات الإخلاء'),
            ],
          ),
        ),
        floatingActionButton: _tabIndex == 0
            ? FloatingActionButton.extended(
                onPressed: _openAddMaintenance,
                icon: const Icon(Icons.build_circle_outlined),
                label: const Text('طلب صيانة'),
              )
            : null,
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _maintenance.length,
              itemBuilder: (context, i) {
                final m = _maintenance[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButton<String>(
                              value: m.status,
                              items: const [
                                DropdownMenuItem(value: 'open', child: Text('مفتوحة')),
                                DropdownMenuItem(value: 'in_progress', child: Text('قيد التنفيذ')),
                                DropdownMenuItem(value: 'completed', child: Text('منجزة')),
                              ],
                              onChanged: (v) {
                                if (v == null) return;
                                setState(() => _maintenance[i] = m.copyWith(status: v));
                              },
                            ),
                            Text(
                              m.tenantName,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(m.description, textAlign: TextAlign.right),
                        if (m.imageFileName != null)
                          Text('مرفق: ${m.imageFileName}', style: Theme.of(context).textTheme.bodySmall),
                        Text(
                          'تاريخ: ${_fmt(m.reportedAt)} — ${_mntStatusLabel(m.status)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListView(
              padding: const EdgeInsets.all(16),
              children: payments.isEmpty
                  ? [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('لا توجد سجلات دفع وهمية لهذا العقار بعد.'),
                        ),
                      ),
                    ]
                  : payments.map((p) {
                      final st = agencyRentPaymentDisplayStatus(p);
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          title: Text(
                            '${p.amount.toStringAsFixed(0)} د.أ — ${_payStatusLabel(st)}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: _payStatusColor(st),
                            ),
                          ),
                          subtitle: Text(
                            'المستأجر: ${p.tenantName}\n'
                            'الاستحقاق: ${_fmt(p.dueDate)}\n'
                            '${p.paidDate != null ? "تاريخ الدفع: ${_fmt(p.paidDate!)}" : "لم يُدفع بعد"}',
                            textAlign: TextAlign.right,
                          ),
                          isThreeLine: true,
                        ),
                      );
                    }).toList(),
            ),
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                FilledButton.icon(
                  onPressed: _openEvictionDialog,
                  icon: const Icon(Icons.gavel_outlined),
                  label: const Text('إصدار إشعار إخلاء'),
                ),
                const SizedBox(height: 16),
                if (_evictions.isEmpty)
                  const Text(
                    'لم يُصدر بعد أي إشعار إخلاء مسجّل في هذه الجلسة.',
                    textAlign: TextAlign.right,
                  )
                else
                  ..._evictions.map(
                    (e) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(e.reason, textAlign: TextAlign.right),
                        subtitle: Text(
                          'الإخلاء: ${_fmt(e.vacateDate)} — صُدر: ${_fmt(e.issuedAt)}',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

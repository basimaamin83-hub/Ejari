/// وسائط شاشة العقد الرقمي الموثّق (إنشاء جديد أو تجديد).
class DigitalContractWizardArgs {
  const DigitalContractWizardArgs({required this.isRenewal});

  /// `true` عند الضغط على «تجديد العقد» — تُعبأ الخطوات من العقد الحالي.
  final bool isRenewal;
}

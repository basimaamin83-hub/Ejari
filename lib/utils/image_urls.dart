/// صور ثابتة من Unsplash (غرف نوم، صالات، مطابخ — أسلوب شقق داخلية).
const Map<String, String> _ejariImageBySeed = {
  'ejari-living-1':
      'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&w=800&q=80',
  'ejari-bed-1':
      'https://images.unsplash.com/photo-1631049035637-02d3d9578fa2?auto=format&fit=crop&w=800&q=80',
  'ejari-kitchen-1':
      'https://images.unsplash.com/photo-1556911220-bff31c812dba?auto=format&fit=crop&w=800&q=80',
  'ejari-living-2':
      'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80',
  'ejari-studio-1':
      'https://images.unsplash.com/photo-1560185007-5f0bb1866cab?auto=format&fit=crop&w=800&q=80',
  'ejari-house-1':
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80',
  'ejari-apt-5':
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
  'ejari-apt-6':
      'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?auto=format&fit=crop&w=800&q=80',
  'ejari-aqaba-1':
      'https://images.unsplash.com/photo-1616594039964-70298072f5cc?auto=format&fit=crop&w=800&q=80',
  'ejari-jerash-1':
      'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=80',
  'ejari-abdoun-1':
      'https://images.unsplash.com/photo-1600210492493-0946911123ea?auto=format&fit=crop&w=800&q=80',
  'ejari-khalda-1':
      'https://images.unsplash.com/photo-1600121848594-d8644e57abab?auto=format&fit=crop&w=800&q=80',
  'ejari-tabbabor-1':
      'https://images.unsplash.com/photo-1600573472592-401b489a3cdc?auto=format&fit=crop&w=800&q=80',
  'ejari-naour-1':
      'https://images.unsplash.com/photo-1600585154526-990dced4db0d?auto=format&fit=crop&w=800&q=80',
};

const List<String> _fallbackApartmentInteriors = [
  'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&w=800&q=80',
  'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&w=800&q=80',
  'https://images.unsplash.com/photo-1556912172-45b7abe8b7e1?auto=format&fit=crop&w=800&q=80',
  'https://images.unsplash.com/photo-1600607687644-c7171b42498f?auto=format&fit=crop&w=800&q=80',
  'https://images.unsplash.com/photo-1600566752355-3579f9b9b0b9?auto=format&fit=crop&w=800&q=80',
  'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?auto=format&fit=crop&w=800&q=80',
];

/// صورة بطاقة العقار أو الشريحة — [seed] يطابق مفتاحاً في الخريطة أو يُحسب منه بديل.
String ejariPlaceholderImage(String seed, {int w = 800, int h = 520}) {
  final direct = _ejariImageBySeed[seed];
  if (direct != null) return direct;
  final i = seed.hashCode.abs() % _fallbackApartmentInteriors.length;
  return _fallbackApartmentInteriors[i];
}

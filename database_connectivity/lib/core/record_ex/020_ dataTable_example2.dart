import 'dart:math' as math;

void main() {
  // 1 & 2. تمثيل الجدول كقائمة من الـ Records في الذاكرة
  final List<({int id, String name, double price})> dtProducts = [
    (id: 1, name: 'Laptop ThinkPad', price: 850.00),
    (id: 2, name: 'iPhone 15', price: 999.99),
    (id: 3, name: 'Monitor 4K', price: 350.50),
    (id: 4, name: 'Mouse Wireless', price: 25.00),
    (id: 5, name: 'Keyboard Mechanical', price: 80.00),
  ];

  // 3. إجراء العمليات الحسابية بأدوات Dart الذكية

  // Count: حجم القائمة ببساطة
  int count = dtProducts.length;

  // Sum: نستخدم fold لجمع الأسعار التراكمية بدءاً من الصفر 0.0
  double sum = dtProducts.fold(
    0.0,
    (previousValue, element) => previousValue + element.price,
  );

  // Avg: المجموع مقسوماً على العدد
  double avg = count > 0 ? sum / count : 0.0;

  // Min & Max: نستخدم دالة reduce مع مكتبة الأرقام للمقارنة المتتالية
  double min = dtProducts.map((e) => e.price).reduce(math.min);
  double max = dtProducts.map((e) => e.price).reduce(math.max);

  // 4. طباعة النتائج (تنسيق الأرقام لخانتين عشريتين باستخدام toStringAsFixed)
  print('=== Products Statistics (Modern Dart) ===');
  print('Total Products (Count) : $count');
  print('Total Value (Sum)      : \$${sum.toStringAsFixed(2)}');
  print('Average Price (Avg)    : \$${avg.toStringAsFixed(2)}');
  print('Cheapest Price (Min)   : \$${min.toStringAsFixed(2)}');
  print('Most Expensive (Max)   : \$${max.toStringAsFixed(2)}');
}

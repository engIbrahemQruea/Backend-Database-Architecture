void main() {
  // 1 & 2. بناء هيكل الجدول وتحديد الأنظمة في الذاكرة باستخدام الـ Records
  // الجدول هنا عبارة عن قائمة من الـ Records المحددة الأنواع مسبقاً (Type-Safe Rows)
  List<({int id, String name, String department, DateTime hireDate})>
  dtEmployees = [];

  // 3. إضافة البيانات (Rows) يدوياً في الذاكرة
  dtEmployees.add((
    id: 101,
    name: 'Ibrahem Qureai',
    department: 'IT & Mobile Development',
    hireDate: DateTime.parse('2025-06-01'),
  ));

  dtEmployees.add((
    id: 102,
    name: 'Fadi Maher',
    department: 'Quality Assurance',
    hireDate: DateTime.parse('2026-02-15'),
  ));

  // 4. طباعة واستعراض البيانات (ListData) بأسلوب Dart الحديث والنظيف
  print('--- Employees Offline Data Table (Dart) ---');

  for (var employee in dtEmployees) {
    // نصل للحقول مباشرة عبر أسمائها بفضل الـ Records بدون الحاجة لنصوص صلبة (No Typo Strings)
    String formattedDate =
        "${employee.hireDate.year}-${employee.hireDate.month.toString().padLeft(2, '0')}-${employee.hireDate.day.toString().padLeft(2, '0')}";

    print(
      'ID: ${employee.id} | Name: ${employee.name} | Dept: ${employee.department} | Hired: $formattedDate',
    );
  }
}

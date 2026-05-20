import 'dart:math' as math;

void main() {
  // 1 & 2. بناء الهيكل وملء البيانات يدوياً في الذاكرة (Offline Data) باستخدام Records
  final List<
    ({int id, String name, String country, double salary, DateTime date})
  >
  employeesDataTable = [
    (
      id: 1,
      name: "Ibrahim Qurea",
      country: "Yemen",
      salary: 7000.0,
      date: DateTime.now(),
    ),
    (
      id: 2,
      name: "Ali Maher",
      country: "KSA",
      salary: 525.5,
      date: DateTime.now(),
    ),
    (
      id: 3,
      name: "Lina Kamal",
      country: "Jordan",
      salary: 730.5,
      date: DateTime.now(),
    ),
    (
      id: 4,
      name: "Fadi JAmeel",
      country: "Egypt",
      salary: 800.0,
      date: DateTime.now(),
    ),
    (
      id: 5,
      name: "Omar Mahmoud",
      country: "Lebanon",
      salary: 7000.0,
      date: DateTime.now(),
    ),
    (
      id: 6,
      name: "Mohammed Abu-Hadhoud",
      country: "Jordan",
      salary: 5000.0,
      date: DateTime.now(),
    ),
  ];

  // دالة مخصصة قمنا ببنائها لمحاكاة طباعة البيانات والعمليات الإحصائية بناءً على شرط معين (فيلتر)
  // لتجنب تكرار الكود المكتوب في C# (Keep it DRY!)
  void printAndComputeStats({
    required String title,
    required bool Function(
      ({int id, String name, String country, double salary, DateTime date}),
    )
    filterCondition,
  }) {
    // 1. تطبيق الفلترة على القائمة
    final filteredRows = employeesDataTable.where(filterCondition).toList();

    // 2. طباعة قائمة الموظفين المفلترة
    print("\n$title:\n");
    for (var row in filteredRows) {
      print(
        " ID: ${row.id}\t Name : ${row.name} \t Country: ${row.country} \t Salary: ${row.salary} Date: ${row.date} \t ",
      );
    }

    // 3. الحسابات الإحصائية المفلترة (محاكاة لدالة Compute)
    int count = filteredRows.length;

    // حساب المجموع عبر fold
    double totalSalaries = filteredRows.fold(
      0.0,
      (prev, element) => prev + element.salary,
    );

    // حساب المتوسط
    double averageSalaries = count > 0 ? totalSalaries / count : 0.0;

    // حساب الأدنى والأعلى عبر reduce (مع التحقق أن القائمة ليست فارغة)
    double minSalary = count > 0
        ? filteredRows.map((e) => e.salary).reduce(math.min)
        : 0.0;
    double maxSalary = count > 0
        ? filteredRows.map((e) => e.salary).reduce(math.max)
        : 0.0;

    // 4. طباعة النتائج الإحصائية
    print("\nCount of Employees = $count");
    print("Total Employee Salaries = ${totalSalaries.toStringAsFixed(1)}");
    print("Average Employee Salaries = ${averageSalaries.toStringAsFixed(2)}");
    print("Minimum Salary = $minSalary");
    print("Maximum Salary = $maxSalary");
    print("-" * 50); // سطر فاصـل للترتيب البصري
  }

  // ==================== بدء تنفيذ العمليات المماثلة لكود المدرب ====================

  // 1. العرض والحساب بدون أي فلتر (كود المدرب الجزء الأول)
  printAndComputeStats(
    title: "Employees List (No Filter)",
    filterCondition: (employee) => true, // إرجاع true دائماً يعني جلب الكل
  );

  // 2. الفلترة بواسطة دولة الأردن (Filter By Country Jordan)
  printAndComputeStats(
    title: 'Filter "Jordan" Employees',
    filterCondition: (employee) => employee.country == 'Jordan',
  );

  // 3. الفلترة بواسطة الأردن أو مصر (Filter By Country "Jordan or Egypt")
  printAndComputeStats(
    title: '"Filter Jordan or Egypt" Employees',
    filterCondition: (employee) =>
        employee.country == 'Jordan' || employee.country == 'Egypt',
  );

  // 4. الفلترة بواسطة المعرف الرقمي 1 (Filter By ID "1")
  printAndComputeStats(
    title: "Filter Employee With ID = 1",
    filterCondition: (employee) => employee.id == 1,
  );
}

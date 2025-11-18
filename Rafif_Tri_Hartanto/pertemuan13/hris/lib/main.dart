import 'package:flutter/material.dart';

void main() {
  runApp(PayrollApp());
}

class PayrollApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HRIS Payroll',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PayrollTablePage(),
    );
  }
}

/// DATABASE MODELS (berdasarkan rancangan)
class UserModel {
  final String id;
  final String email;
  final bool isAdmin;

  UserModel({required this.id, required this.email, required this.isAdmin});
}

class SalaryModel {
  final String id;
  final String userId;
  final int type; // 1 = Gaji Pokok, 2 = Tunjangan, 3 = Potongan
  final double rate;
  final String effectiveDate;

  SalaryModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.rate,
    required this.effectiveDate,
  });
}

/// MOCK DATA (contoh data mengikuti struktur database)
final users = <UserModel>[
  UserModel(id: 'U001', email: 'andi@example.com', isAdmin: false),
  UserModel(id: 'U002', email: 'budi@example.com', isAdmin: false),
  // UserModel(id: 'ADM01', email: 'admin@example.com', isAdmin: true),
];

final salaries = <SalaryModel>[
  SalaryModel(id: 'S001', userId: 'U001', type: 1, rate: 5000000, effectiveDate: '2025-01-01'),
  SalaryModel(id: 'S002', userId: 'U001', type: 2, rate: 500000, effectiveDate: '2025-01-01'),
  SalaryModel(id: 'S003', userId: 'U002', type: 1, rate: 4000000, effectiveDate: '2025-01-01'),
  SalaryModel(id: 'S004', userId: 'U002', type: 2, rate: 300000, effectiveDate: '2025-01-01'),
  SalaryModel(id: 'S005', userId: 'U002', type: 3, rate: 150000, effectiveDate: '2025-01-01'),
];

/// PAGE: Tabel Payroll berdasarkan user & salary schema
class PayrollTablePage extends StatelessWidget {
  Map<String, double> computePayroll(String userId) {
    double base = 0;
    double allowance = 0;
    double deduction = 0;

    final items = salaries.where((s) => s.userId == userId);
    for (var s in items) {
      if (s.type == 1) base += s.rate;
      if (s.type == 2) allowance += s.rate;
      if (s.type == 3) deduction += s.rate;
    }

    final gross = base + allowance - deduction;
    final tax = gross * 0.05; // contoh pajak
    final net = gross - tax;

    return {
      'base': base,
      'allowance': allowance,
      'deduction': deduction,
      'gross': gross,
      'tax': tax,
      'net': net,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tabel Payroll")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('User ID')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Gaji Pokok')),
            DataColumn(label: Text('Tunjangan')),
            DataColumn(label: Text('Potongan')),
            DataColumn(label: Text('Gross')),
            DataColumn(label: Text('Pajak')),
            DataColumn(label: Text('Net')),
          ],
          rows: users.map((u) {
            final p = computePayroll(u.id);
            return DataRow(cells: [
              DataCell(Text(u.id)),
              DataCell(Text(u.email)),
              DataCell(Text('Rp ${p['base']!.toStringAsFixed(0)}')),
              DataCell(Text('Rp ${p['allowance']!.toStringAsFixed(0)}')),
              DataCell(Text('Rp ${p['deduction']!.toStringAsFixed(0)}')),
              DataCell(Text('Rp ${p['gross']!.toStringAsFixed(0)}')),
              DataCell(Text('Rp ${p['tax']!.toStringAsFixed(0)}')),
              DataCell(Text('Rp ${p['net']!.toStringAsFixed(0)}')),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
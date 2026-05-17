import 'package:database_connectivity/business_logic_layer/business_logic_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BusinessLogicModel> _contacts = [];

  @override
  void initState() {
    _loadAllContacts();
    super.initState();
  }

  List<DataRow> _createRows() {
    return _contacts.map((contact) {
      return DataRow(
        cells: [
          DataCell(Text('${contact.contactID}')),
          DataCell(Text('${contact.firstName}')),
          DataCell(Text('${contact.lastName}')),
          DataCell(Text('${contact.email}')),
          DataCell(Text('${contact.phone}')),
          DataCell(Text('${contact.address}')),
          DataCell(Text('${contact.dateOfBirth}')),
          DataCell(Text('${contact.countryId}')),
          DataCell(Text('${contact.imagePath}')),
        ],
      );
    }).toList();
  }

  Future<void> _loadAllContacts() async {
    _contacts = await BusinessLogicModel.getAllContacts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Contacts App UI'),
      ),
      body: Container(
        width: 350,
        height: 800,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataTextStyle: TextStyle(),
            showBottomBorder: true,
            columnSpacing: 30,
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(
                label: Text('First Name'),
                // columnWidth: TableColumnWidth.auto,
              ),
              DataColumn(label: Text('Last Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Address')),
              DataColumn(label: Text('Date of Birth')),
              DataColumn(label: Text('Country')),
              DataColumn(label: Text('ImagePath')),
              // DataColumn(label: Text('Actions')),
            ],
            rows: _createRows(),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Contact',
        mouseCursor: SystemMouseCursors.move,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

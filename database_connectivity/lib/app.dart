import 'package:database_connectivity/data_access/database_service.dart';
import 'package:database_connectivity/models/contact_model.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Database Connectivity'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              await ContactDatabaseService().printAllContacts();
            },
            child: Text('GetAllContact'),
          ),

          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              await ContactDatabaseService().printAllContactsWithFirstName(
                'Jane',
              );
            },
            child: Text('GetContactByFirstName'),
          ),
          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              await ContactDatabaseService()
                  .printAllContactsWithFirstNameAndCountry('jane', 1);
            },
            child: Text('GetContactByCountryName'),
          ),
          TextButton(
            onPressed: () async {
              await ContactDatabaseService().searchContactsStartWith(
                searchLetter: 'j',
              );
            },
            child: Text('Search Start'),
          ),
          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              await ContactDatabaseService().searchContactsEndWith(
                searchLetter: 'e',
              );
            },
            child: Text('Search Contacts End With'),
          ),
          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              final firstName = await ContactDatabaseService().getFirstName(
                contactId: 2,
              );
              print('First Name: $firstName');
            },
            child: Text('Get First Name'),
          ),

          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              final contact = await ContactDatabaseService().findContactById(
                contactId: 2,
              );
              if (contact != null) {
                print(
                  'Contact Found: ${contact.firstName} ${contact.lastName}',
                );
              } else {
                print('No contact found with the given ID.');
              }
            },
            child: Text('Find Contact By ID'),
          ),
          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              final result = await ContactDatabaseService().addNewContact(
                ContactModel(
                  firstName: 'Ahmed',
                  lastName: 'Ali',
                  email: 'ahmed.ali@example.com',
                  phone: '1234567890',
                  address: '123 Main St',
                  dateOfBirth: '1990-01-01T00:00:00.000',
                  countryId: 1,
                  imagePath: 'path/to/image.jpg',
                ),
              );
              print('Contact added: $result');
            },
            child: Text('Add New Contact'),
          ),
          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              final result = await ContactDatabaseService()
                  .addNewContactAndGetID(
                    ContactModel(
                      firstName: 'ali',
                      lastName: 'Smith',
                      email: 'ali.smith@example.com',
                      phone: '9876543210',
                      address: '456 Elm St',
                      dateOfBirth: '1992-02-02T00:00:00.000',
                      countryId: 4,
                      imagePath: 'path/to/image.jpg',
                    ),
                  );
              print('Contact added with ID: $result');
            },
            child: Text('Add New Contact With Get ID'),
          ),
          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              final result = await ContactDatabaseService().updateContact(
                ContactModel(
                  firstName: 'Ibrahim',
                  lastName: 'Smith',
                  email: 'heba.smith@example.com',
                  phone: '9876543210',
                  address: '456 Elm St',
                  dateOfBirth: '1992-02-02T00:00:00.000',
                  countryId: 2,
                  imagePath: 'path/to/image.jpg',
                ),
                9,
              );
              print('Contact updated: $result');
            },
            child: Text('Update Contact'),
          ),
          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              final result = await ContactDatabaseService().deleteContact(8);
              print('Contact deleted: $result');
            },
            child: Text('Delete Contact'),
          ),
          TextButton(
            onPressed: () async {
              print(' Button Clicked');
              final result = await ContactDatabaseService()
                  .deleteContactsWithInStatement([3, 4, 5]);
              print('All contacts deleted: $result');
            },
            child: Text('Delete  Contacts With IN Statement'),
          ),
        ],
      ),
    );
  }
}

import 'package:database_connectivity/presentation_layer/functions_tests.dart';
import 'package:flutter/material.dart';

class PresentationLayer extends StatelessWidget {
  const PresentationLayer({super.key});

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
        title: Text('3-Tier Architecutre'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              FunctionsTests.testFindByID(contactID: 9);
            },
            child: Text('test Find Contact'),
          ),
          TextButton(
            onPressed: () {
              FunctionsTests.testAddNewContact();
            },
            child: Text('test Add New Contact'),
          ),
          TextButton(
            onPressed: () {
              FunctionsTests.testUpdateContact(contactID: 90);
            },
            child: Text('test Update Contact'),
          ),
          TextButton(
            onPressed: () {
              FunctionsTests.testDeleteContact(contactID: 9);
            },
            child: Text('test Delete Contact'),
          ),
          TextButton(
            onPressed: () {
              FunctionsTests.testGetAllContacts();
            },
            child: Text('test Get All Contacts'),
          ),
          TextButton(
            onPressed: () {
              FunctionsTests.testIsContactExists(contactID: 8);
            },
            child: Text('test Check Contact Exists'),
          ),
          Text('========================'),
          TextButton(
            onPressed: () {
              FunctionsTests.testFindCountryByID(countryID: 2);
            },
            child: Text('test Find Country By ID'),
          ),
          TextButton(
            onPressed: () {
              FunctionsTests.testAddNewCountry();
            },
            child: Text('test Add New Country'),
          ),
          TextButton(
            onPressed: () {
              FunctionsTests.testUpdateCountry(countryID: 7);
            },
            child: Text('test Update Country'),
          ),
          TextButton(
            onPressed: () {
              FunctionsTests.testDeleteCountry(countryID: 7);
            },
            child: Text('test Delete Country'),
          ),
          TextButton(
            onPressed: () {
              FunctionsTests.testGetAllCountries();
            },
            child: Text('test Get All Countries'),
          ),
          TextButton(
            onPressed: () {
              FunctionsTests.testIsCountryExists(countryID: 2);
            },
            child: Text('test Check Country Exists'),
          ),
        ],
      ),
    );
  }
}

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
            onPressed: () async {
              //  await ContactDatabaseService().printAllContacts();
            },
            child: Text('GetAllContact'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/match.dart';

class NewMatchScreen extends StatefulWidget {
  const NewMatchScreen({Key? key}) : super(key: key);

  @override
  _NewMatchPage createState() => _NewMatchPage();
}

class _NewMatchPage extends State<NewMatchScreen> {
  final _formKey = GlobalKey<FormState>();

  final p1Controller = TextEditingController();
  final p2Controller = TextEditingController();
  final surfaceController = TextEditingController();
  final venueController = TextEditingController();

  @override
  void dispose() {
    p1Controller.dispose();
    p2Controller.dispose();
    surfaceController.dispose();
    venueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('New Match'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Player 1"),
                  controller: p1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the first player';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Player 2"),
                  controller: p2Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the second player';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Court surface"),
                  controller: surfaceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the court surface (Clay, Hard, Grass)';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Venue"),
                  controller: venueController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the place where the match is happening';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(Match(
                        p1Controller.text,
                        p2Controller.text,
                        surfaceController.text,
                        venueController.text));
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

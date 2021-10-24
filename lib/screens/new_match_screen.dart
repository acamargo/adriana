import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

import '../models/match.dart';

class NewMatchScreen extends StatefulWidget {
  final Map match;

  NewMatchScreen(this.match);

  @override
  _NewMatchPage createState() => _NewMatchPage();
}

class _NewMatchPage extends State<NewMatchScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController p1Controller;
  late TextEditingController p2Controller;
  late TextEditingController surfaceController;
  late TextEditingController venueController;

  @override
  void initState() {
    super.initState();
    p1Controller = TextEditingController(text: widget.match['p1']);
    p2Controller = TextEditingController(text: widget.match['p2']);
    surfaceController = TextEditingController(text: widget.match['surface']);
    venueController = TextEditingController(text: widget.match['venue']);
  }

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
    Wakelock.disable();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final isNew = widget.match['p1'] == null;

    print(widget.match);
    return new Scaffold(
      appBar: new AppBar(
        title: Text(isNew ? 'New Match' : 'Edit Match'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: TextFormField(
                  //initialValue: 'oi', //widget.match['p1'].toString(),
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swipe_to_refresh/models/person.dart';

/// This is the default list of data that will be displayed on the screen.
/// This list will be updated when user click on floating button.
List<Person> people = [
  Person(name: 'Person 1', age: 30),
  Person(name: 'Person 2', age: 25),
  Person(name: 'Person 3', age: 20),
  Person(name: 'Person 4', age: 15),
  Person(name: 'Person 5', age: 10),
];

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Swipe to refresh'),
        ),
        floatingActionButton: _buildFloatingButton(context, people),
        body: _buildBodyContainer());
  }

  /// This method builds a floating button that, after click on it, will
  /// add new person to our people list.
  FloatingActionButton _buildFloatingButton(
      BuildContext context, List<Person> people) {
    return FloatingActionButton(
        onPressed: () {
          String name = 'Person ${people.length + 1}';
          people.add(Person(name: name, age: Random().nextInt(100)));

          SnackBar snackBar = SnackBar(content: Text('$name added'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Icon(Icons.add));
  }

  /// This method builds a container (by RefreshIndicator) that contains
  /// the ListView of people that will be displayed on the screen.
  /// This ListView will be refreshed when user swipe down the screen.
  RefreshIndicator _buildBodyContainer() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: _buildListViewContainer(),
    );
  }

  /// This method will be called when user swipe down the screen.
  /// It will update the people list and display it on the screen.
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      people = people.toList();
    });
  }

  /// This method builds the ListView of people that will be displayed
  /// on the screen.
  /// The people list will be displayed on the screen as a list of cards.
  Padding _buildListViewContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(people[index].name),
              subtitle: Text(people[index].age.toString()),
            ),
          );
        },
      ),
    );
  }
}

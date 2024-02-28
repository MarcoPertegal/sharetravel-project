import 'package:flutter/material.dart';

class TripsFilterNotFoundPage extends StatelessWidget {
  const TripsFilterNotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trips Not Found'),
      ),
      body: Center(
        child: Text('No trips found matching the given criteria.'),
      ),
    );
  }
}

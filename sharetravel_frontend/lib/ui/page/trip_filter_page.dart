import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/repository/filter/filter_trips_repository_impl.dart';

class TripFilterPage extends StatefulWidget {
  const TripFilterPage({super.key});

  @override
  State<TripFilterPage> createState() => _TripFilterPageState();
}

class _TripFilterPageState extends State<TripFilterPage> {
  final FilterTripsRepositoryImpl _filterTripsRepository =
      FilterTripsRepositoryImpl(); // Create an instance of your repository

  // Define your filter parameters, you may get these from user input or any other source
  String departurePlace = 'Seville';
  String arrivalPlace = 'Sanlúcar de Barrameda';
  String departureDate = '2024-02-22';

  void _executeFilterQuery() async {
    try {
      // Call the tripsFilter method from the repository
      var response = await _filterTripsRepository.tripsFilter(
          departurePlace, arrivalPlace, departureDate);

      // Handle the response, you can use the 'response' data as needed
      print('Filtered Trips: ${response.toJson()}');

      // Perform any other actions based on the response
    } catch (e) {
      // Handle exceptions, e.g., show an error message
      print('Error executing filter query: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/ilustration_filter.png',
            width: double.infinity,
            height: 500,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(top: 200),
            width: double.infinity,
            height: 100,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _executeFilterQuery();
                  },
                  child: Text('Ejecutar Consulta'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

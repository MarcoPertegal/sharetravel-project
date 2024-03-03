import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/model/response/filter_trips_list_response/trip.dart';
import 'package:sharetravel_frontend/ui/widget/trip_card_widget.dart';

class TripListPage extends StatefulWidget {
  final String departurePlace;
  final String arrivalPlace;
  final String departureDate;
  final List<Trip> trips;
  const TripListPage(
      {super.key,
      required this.departurePlace,
      required this.arrivalPlace,
      required this.departureDate,
      required this.trips});

  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 100),
              itemCount: widget.trips.length,
              itemBuilder: (BuildContext context, int index) {
                return TripCardWidget(trip: widget.trips[index]);
              },
            ),
          ),
          Positioned(
            top: 10,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.only(right: 30),
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 229, 255, 229),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Text(
                          widget.departurePlace,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 101, 101, 101),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const Icon(Icons.arrow_right_alt),
                      Expanded(
                        child: Text(
                          widget.arrivalPlace,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 100, 100, 100),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.departureDate,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

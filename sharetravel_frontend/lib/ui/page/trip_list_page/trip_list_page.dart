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
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.only(right: 30),
              height: 70,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 218, 255, 232),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.departurePlace,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color.fromARGB(255, 101, 101, 101),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_right_alt),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.arrivalPlace,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color.fromARGB(255, 100, 100, 100),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 57),
                    child: Text(
                      widget.departureDate,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 97, 97, 97),
                        fontSize: 12,
                      ),
                    ),
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

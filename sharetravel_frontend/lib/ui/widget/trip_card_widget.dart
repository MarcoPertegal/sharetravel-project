import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/model/response/filter_trips_list_response/trip.dart';

class TripCardWidget extends StatelessWidget {
  final Trip trip;
  const TripCardWidget({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(trip.departureTime!.split("T")[1].substring(0, 5)),
                      Text("${trip.estimatedDuration!}min"),
                      Text(trip.arrivalTime!.split("T")[1].substring(0, 5))
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/green_arrow.png',
                        width: 50,
                        height: 50,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(trip.departurePlace!),
                      Text(trip.arrivalPlace!)
                    ],
                  ),
                  Column(children: [Text("${trip.price}€")])
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(trip.driver!.avatar!),
                    ),
                  ),
                  Text(trip.driver!.fullName!)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

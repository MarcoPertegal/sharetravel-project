import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/model/response/driver_trips_response/trip.dart';
import 'package:sharetravel_frontend/ui/page/your_trips_page/trip_edit_page.dart';

class DriverTripsCardWidget extends StatefulWidget {
  final Trip trip;
  const DriverTripsCardWidget({super.key, required this.trip});

  @override
  State<DriverTripsCardWidget> createState() => _DriverTripsCardWidgetState();
}

class _DriverTripsCardWidgetState extends State<DriverTripsCardWidget> {
  final TextStyle commonTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(10),
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
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.trip.departureTime!
                            .split("T")[1]
                            .substring(0, 5),
                        style: commonTextStyle,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        (widget.trip.estimatedDuration! < 60)
                            ? "${widget.trip.estimatedDuration!}min"
                            : "${(widget.trip.estimatedDuration! ~/ 60)}h ${(widget.trip.estimatedDuration! % 60)}",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.trip.arrivalTime!.split("T")[1].substring(0, 5),
                        style: commonTextStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/green_arrow.png',
                        width: 50,
                        height: 80,
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.trip.departurePlace!,
                            style: commonTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(widget.trip.arrivalPlace!,
                            style: commonTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1)
                      ],
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.trip.price}€", style: commonTextStyle)
                      ])
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 175, 84),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          NetworkImage(widget.trip.driver!.avatar!),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Padding(
                      padding: EdgeInsets.only(top: 25.0), child: Text("You")),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit_square,
                        color: Color.fromARGB(255, 0, 175, 84),
                      ),
                      onPressed: () {
                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TripEditPage(
                                tripId: widget.trip.id!,
                                departurePlace: widget.trip.departurePlace!,
                                arrivalPlace: widget.trip.arrivalPlace!,
                                departureTime: widget.trip.departureTime!,
                                estimatedDuration:
                                    widget.trip.estimatedDuration!,
                                price: widget.trip.price!,
                                tripDescription: widget.trip.tripDescription!,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

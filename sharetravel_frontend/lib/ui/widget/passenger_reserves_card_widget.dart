import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/model/response/passenger_reserves_response/reserve.dart';

class PassengerReservesCardWidget extends StatefulWidget {
  final Reserve reserve;
  const PassengerReservesCardWidget({super.key, required this.reserve});

  @override
  State<PassengerReservesCardWidget> createState() =>
      _PassengerReservesCardWidgetState();
}

class _PassengerReservesCardWidgetState
    extends State<PassengerReservesCardWidget> {
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
                        widget.reserve.trip!.departureTime!
                            .split("T")[1]
                            .substring(0, 5),
                        style: commonTextStyle,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        (widget.reserve.trip!.estimatedDuration! < 60)
                            ? "${widget.reserve.trip!.estimatedDuration!}min"
                            : "${(widget.reserve.trip!.estimatedDuration! ~/ 60)}h ${(widget.reserve.trip!.estimatedDuration! % 60)}",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.reserve.trip!.arrivalTime!
                            .split("T")[1]
                            .substring(0, 5),
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
                        Text(widget.reserve.trip!.departurePlace!,
                            style: commonTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                        SizedBox(
                          height: 30,
                        ),
                        Text(widget.reserve.trip!.arrivalPlace!,
                            style: commonTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1)
                      ],
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.reserve.trip!.price}€",
                            style: commonTextStyle)
                      ])
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 0, 175, 84),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          NetworkImage(widget.reserve.trip!.driver!.avatar!),
                    ),
                  ),
                  SizedBox(width: 15),
                  Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(widget.reserve.trip!.driver!.fullName!))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

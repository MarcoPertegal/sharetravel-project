import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/model/response/trip_details_response/reserve.dart';

class PassengerListWidget extends StatefulWidget {
  final Reserve reserve;
  const PassengerListWidget({super.key, required this.reserve});

  @override
  State<PassengerListWidget> createState() => _PassengerListWidgetState();
}

class _PassengerListWidgetState extends State<PassengerListWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.reserve.passenger!.fullName!),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(widget.reserve.passenger!.avatar!),
        ),
      ],
    );
  }
}

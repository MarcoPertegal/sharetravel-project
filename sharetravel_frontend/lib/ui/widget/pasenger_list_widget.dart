import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/model/trip_details_response/reserve.dart';

class PassengerListWidget extends StatefulWidget {
  final Reserve reserve;
  const PassengerListWidget({super.key, required this.reserve});

  @override
  State<PassengerListWidget> createState() => _PassengerListWidgetState();
}

class _PassengerListWidgetState extends State<PassengerListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.reserve.passenger!.fullName!),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.reserve.passenger!.avatar!),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/model/response/driver_ratings_response/rating.dart';

class DriverRatingsCardWidget extends StatefulWidget {
  final Rating rating;
  const DriverRatingsCardWidget({super.key, required this.rating});

  @override
  State<DriverRatingsCardWidget> createState() =>
      _DriverRatingsCardWidgetState();
}

class _DriverRatingsCardWidgetState extends State<DriverRatingsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.rating.passenger!.fullName!,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 84, 84)),
              ),
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(widget.rating.passenger!.avatar!),
              ),
            ],
          ),
        ),
        SizedBox(
          child: Row(children: [
            Text(
              widget.rating.ratingValue!.toString(),
              textAlign: TextAlign.left,
            ),
            const Icon(
              Icons.star,
              color: Color.fromARGB(255, 252, 163, 17),
            ),
          ]),
        ),
        const SizedBox(height: 10),
        SizedBox(
          child: Text(
            widget.rating.feedback!,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}

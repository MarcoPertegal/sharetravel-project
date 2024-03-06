import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/bloc/trip_details_bloc/trip_details_bloc.dart';
import 'package:sharetravel_frontend/model/response/filter_trips_list_response/trip.dart';
import 'package:sharetravel_frontend/repository/trip/trip_details_repository.dart';
import 'package:sharetravel_frontend/repository/trip/trip_details_repository_impl.dart';
import 'package:sharetravel_frontend/ui/page/trip_list_page/trip_details_page.dart';

class TripCardWidget extends StatefulWidget {
  final Trip trip;
  const TripCardWidget({Key? key, required this.trip}) : super(key: key);

  @override
  _TripCardWidgetState createState() => _TripCardWidgetState();
}

class _TripCardWidgetState extends State<TripCardWidget> {
  late TripDetailsRepository tripDetailsRepository;
  late TripDetailsBloc _tripDetailsBloc;

  final TextStyle commonTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    tripDetailsRepository = TripDetailsRepositoryImpl();
    _tripDetailsBloc = TripDetailsBloc(tripDetailsRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () async {
          _tripDetailsBloc.add(DoTripDetailsEvent(widget.trip.id!));

          final tripDetailsState = await _tripDetailsBloc.stream.firstWhere(
            (state) => state is DoTripDetailsSuccess,
          );

          if (tripDetailsState is DoTripDetailsSuccess) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TripDetailsPage(
                tripDetails: tripDetailsState.tripDetailsResponse,
              ),
            ));
          }
        },
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
                          widget.trip.arrivalTime!
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
                          Text(widget.trip.departurePlace!,
                              style: commonTextStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                          SizedBox(
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
                          color: Color.fromARGB(255, 0, 175, 84),
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
                    SizedBox(width: 15),
                    Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Text(widget.trip.driver!.fullName!))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

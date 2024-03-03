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
                  children: [
                    Column(
                      children: [
                        Text(widget.trip.departureTime!
                            .split("T")[1]
                            .substring(0, 5)),
                        Text("${widget.trip.estimatedDuration!}min"),
                        Text(widget.trip.arrivalTime!
                            .split("T")[1]
                            .substring(0, 5))
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
                        Text(widget.trip.departurePlace!),
                        Text(widget.trip.arrivalPlace!)
                      ],
                    ),
                    Column(children: [Text("${widget.trip.price}€")])
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
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
                    Text(widget.trip.driver!.fullName!)
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

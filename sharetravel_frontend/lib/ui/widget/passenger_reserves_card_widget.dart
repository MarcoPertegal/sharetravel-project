import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/bloc/delete_reserve/delete_reserve_bloc.dart';
import 'package:sharetravel_frontend/model/response/passenger_reserves_response/reserve.dart';
import 'package:sharetravel_frontend/repository/delete_reserve/delete_reserve_repository.dart';
import 'package:sharetravel_frontend/repository/delete_reserve/delete_reserve_repository_impl.dart';
import 'package:sharetravel_frontend/ui/page/your_reserves_page/create_rating_page.dart';
import 'package:sharetravel_frontend/ui/page/home_page.dart';

class PassengerReservesCardWidget extends StatefulWidget {
  final Reserve reserve;
  const PassengerReservesCardWidget({super.key, required this.reserve});

  @override
  State<PassengerReservesCardWidget> createState() =>
      _PassengerReservesCardWidgetState();
}

class _PassengerReservesCardWidgetState
    extends State<PassengerReservesCardWidget> {
  late DeleteReserveRepository deleteReserveRepository;
  late DeleteReserveBloc _deleteReserveBloc;

  @override
  void initState() {
    deleteReserveRepository = DeleteReserveRepositoryImpl();
    _deleteReserveBloc = DeleteReserveBloc(deleteReserveRepository);
    super.initState();
  }

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
                        const SizedBox(
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
                  const SizedBox(width: 15),
                  Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(widget.reserve.trip!.driver!.fullName!)),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.star_half_rounded,
                        color: Color.fromARGB(255, 0, 175, 84),
                      ),
                      onPressed: () {
                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateRatingPage(
                                driverId: widget.reserve.trip!.driver!.id!,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Color.fromARGB(255, 0, 175, 84),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: const Text(
                                  "Sure you want to cancel the reserve?"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Yes"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _deleteReserveBloc.add(DoDeleteReserveEvent(
                                        widget.reserve.id!));
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const HomePage()),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

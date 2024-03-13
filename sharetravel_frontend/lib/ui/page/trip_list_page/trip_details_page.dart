import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sharetravel_frontend/bloc/create_reserve/create_reserve_bloc.dart';
import 'package:sharetravel_frontend/model/response/trip_details_response/trip_details_response.dart';
import 'package:sharetravel_frontend/repository/create_reserve/create_reserve_repository.dart';
import 'package:sharetravel_frontend/repository/create_reserve/create_reserve_repository_impl.dart';
import 'package:sharetravel_frontend/ui/page/confirmation_page.dart';
import 'package:sharetravel_frontend/ui/page/trip_list_page/map_page.dart';
import 'package:sharetravel_frontend/ui/widget/pasenger_list_widget.dart';

class TripDetailsPage extends StatefulWidget {
  final TripDetailsResponse tripDetails;

  const TripDetailsPage({
    Key? key,
    required this.tripDetails,
  }) : super(key: key);

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  late CreateReserveRepository createReserveRepository;
  late CreateReserveBloc _createReserveBloc;

  @override
  void initState() {
    createReserveRepository = CreateReserveRepositoryImpl();
    _createReserveBloc = CreateReserveBloc(createReserveRepository);
    super.initState();
  }

  final TextStyle commonTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    DateTime departureDateTime =
        DateTime.parse(widget.tripDetails.departureTime!);
    String formattedDepartureDate =
        DateFormat('EEEE, dd MMMM').format(departureDateTime);

    return BlocProvider.value(
      value: _createReserveBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      formattedDepartureDate,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 22.0, right: 22.0),
                child: SizedBox(
                  height: 130,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                              widget.tripDetails.departureTime!
                                  .split("T")[1]
                                  .substring(0, 5),
                              style: commonTextStyle),
                          const SizedBox(height: 5),
                          Text(
                            (widget.tripDetails.estimatedDuration! < 60)
                                ? "${widget.tripDetails.estimatedDuration!}min"
                                : "${(widget.tripDetails.estimatedDuration! ~/ 60)}h ${(widget.tripDetails.estimatedDuration! % 60)}",
                          ),
                          const SizedBox(height: 3),
                          Text(
                              widget.tripDetails.arrivalTime!
                                  .split("T")[1]
                                  .substring(0, 5),
                              style: commonTextStyle)
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
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapPage(
                                      cityName:
                                          widget.tripDetails.departurePlace!,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 180,
                                    child: Text(
                                      widget.tripDetails.departurePlace!,
                                      style: commonTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapPage(
                                      cityName:
                                          widget.tripDetails.arrivalPlace!,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 180,
                                    child: Text(
                                      widget.tripDetails.arrivalPlace!,
                                      style: commonTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 90,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color.fromARGB(255, 229, 255, 229),
                      width: 7.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price", style: commonTextStyle),
                      Text("${widget.tripDetails.price!}€",
                          style: commonTextStyle),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(255, 229, 255, 229),
                        width: 7.0,
                      ),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.tripDetails.driver!.fullName!,
                              style: commonTextStyle),
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                                widget.tripDetails.driver!.avatar!),
                          ),
                        ],
                      ))),
              SizedBox(
                  child: Padding(
                padding:
                    const EdgeInsets.only(right: 22.0, left: 22.0, bottom: 22),
                child: Center(
                  child: Text(widget.tripDetails.tripDescription!),
                ),
              )),
              Container(
                height: widget.tripDetails.reserves!.length == 1
                    ? 140.0
                    : widget.tripDetails.reserves!.length * 60.0 + 70.0,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color.fromARGB(255, 229, 255, 229),
                      width: 7.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 22.0, left: 20.0, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Passengers', style: commonTextStyle),
                      const SizedBox(height: 10),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.tripDetails.reserves!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PassengerListWidget(
                            reserve: widget.tripDetails.reserves![index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 22.0, left: 20.0, top: 15),
                    child: BlocBuilder<CreateReserveBloc, CreateReserveState>(
                        builder: (context, state) {
                      if (state is DoCreateReserveSuccess) {
                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConfirmationPage(
                                  confirmationMessage:
                                      'Trip booked succesfully'),
                            ),
                          );
                        });
                      } else if (state is DoCreateReserveLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is DoCreateReserveError) {
                        final errorMessage =
                            state.errorMessage.replaceFirst('Exception: ', '');
                        Future.delayed(Duration.zero, () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content:
                                    Text(errorMessage, style: commonTextStyle),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 175, 84),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          _createReserveBloc.add(
                              DoCreateReserveEvent(widget.tripDetails.id!));
                        },
                        child: const Text(
                          'Reserve',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      );
                    }),
                  )),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

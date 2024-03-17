import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sharetravel_frontend/bloc/edit_trip_bloc/edit_trip_bloc.dart';
import 'package:sharetravel_frontend/repository/edit_trip/edit_trip_repository.dart';
import 'package:sharetravel_frontend/repository/edit_trip/edit_trip_repository_impl.dart';
import 'package:sharetravel_frontend/ui/page/confirmation_page.dart';
import 'package:sharetravel_frontend/ui/page/error_page.dart';

class TripEditPage extends StatefulWidget {
  final String tripId,
      departurePlace,
      arrivalPlace,
      departureTime,
      tripDescription;
  final int estimatedDuration;
  final double price;
  const TripEditPage(
      {super.key,
      required this.tripId,
      required this.departurePlace,
      required this.arrivalPlace,
      required this.departureTime,
      required this.estimatedDuration,
      required this.price,
      required this.tripDescription});

  @override
  State<TripEditPage> createState() => _TripEditPageState();
}

class _TripEditPageState extends State<TripEditPage> {
  final _formEditTrip = GlobalKey<FormState>();
  final departurePlaceTextController = TextEditingController();
  final arrivalPlaceTextController = TextEditingController();
  final departureTimeTextController = TextEditingController();
  final estimatedDurationTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final tripDescriptionTextController = TextEditingController();

  late EditTripRepository editTripRepository;
  late EditTripBloc _editTripBloc;

  @override
  void initState() {
    editTripRepository = EditTripRepositoryImpl();
    _editTripBloc = EditTripBloc(editTripRepository);
    departurePlaceTextController.text = widget.departurePlace;
    arrivalPlaceTextController.text = widget.arrivalPlace;
    departureTimeTextController.text = widget.departureTime;
    estimatedDurationTextController.text = widget.estimatedDuration.toString();
    priceTextController.text = widget.price.toString();
    tripDescriptionTextController.text = widget.tripDescription;
    super.initState();
  }

  @override
  void dispose() {
    departurePlaceTextController.dispose();
    arrivalPlaceTextController.dispose();
    departureTimeTextController.dispose();
    estimatedDurationTextController.dispose();
    priceTextController.dispose();
    tripDescriptionTextController.dispose();
    _editTripBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _editTripBloc,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<EditTripBloc, EditTripState>(
              builder: (context, state) {
                if (state is DoEditTripSuccess) {
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmationPage(
                            confirmationMessage: 'Trip Edited successfully'),
                      ),
                    );
                  });
                } else if (state is DoEditTripError) {
                  final errorMessage =
                      state.errorMessage.replaceFirst('Exception: ', '');
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ErrorPage(errorMessage: errorMessage)),
                    );
                  });
                } else if (state is DoEditTripLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(child: _buildEditTripForm());
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildEditTripForm() {
    return Form(
      key: _formEditTrip,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: departurePlaceTextController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 175, 84), width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                labelText: 'Departure place',
                filled: true,
                fillColor: const Color.fromARGB(255, 218, 255, 232)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: arrivalPlaceTextController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 175, 84), width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                labelText: 'Arrival place',
                filled: true,
                fillColor: const Color.fromARGB(255, 218, 255, 232)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: departureTimeTextController,
            readOnly: true,
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: const Color.fromARGB(255, 0, 175, 84),
                      colorScheme: const ColorScheme.light(
                        primary: Color.fromARGB(255, 0, 175, 84),
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Color.fromARGB(255, 1, 1, 1),
                      ),
                      buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
              );

              if (selectedDate != null) {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedTime != null) {
                  DateTime combinedDateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );

                  String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss')
                      .format(combinedDateTime);

                  departureTimeTextController.text = formattedDateTime;
                }
              }
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 175, 84), width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              labelText: 'Departure Date and Time',
              filled: true,
              fillColor: const Color.fromARGB(255, 218, 255, 232),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: estimatedDurationTextController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 175, 84),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              labelText: 'Estimated duration (in minutes)',
              filled: true,
              fillColor: const Color.fromARGB(255, 218, 255, 232),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              int? duration = int.tryParse(value);
              if (duration == null || duration <= 0 || duration > 500) {
                return 'Please enter a valid duration between 1 and 500 minutes';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: priceTextController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+$')),
            ],
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 175, 84),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              labelText: 'Price',
              filled: true,
              fillColor: const Color.fromARGB(255, 218, 255, 232),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              int? price = int.tryParse(value);
              if (price == null || price < 3 || price > 50) {
                return 'Please enter a valid price between 3€ and 50€';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: tripDescriptionTextController,
            maxLines: 3,
            onChanged: (value) {
              // Aqui se puede meter validación
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 175, 84), width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              labelText: 'Trip description',
              filled: true,
              fillColor: const Color.fromARGB(255, 218, 255, 232),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: double.infinity,
            height: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 175, 84),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text(
                'Edit',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () {
                if (_formEditTrip.currentState!.validate()) {
                  _editTripBloc.add(DoEditTripEvent(
                    widget.tripId,
                    departurePlaceTextController.text,
                    arrivalPlaceTextController.text,
                    departureTimeTextController.text,
                    int.parse(estimatedDurationTextController.text),
                    double.parse(priceTextController.text),
                    tripDescriptionTextController.text,
                  ));
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

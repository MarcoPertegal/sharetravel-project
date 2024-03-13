import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharetravel_frontend/bloc/filter_trips_bloc/filter_trips_bloc.dart';
import 'package:sharetravel_frontend/repository/filter/filter_trips_repository.dart';
import 'package:sharetravel_frontend/repository/filter/filter_trips_repository_impl.dart';
import 'package:sharetravel_frontend/ui/page/error_page.dart';
import 'package:sharetravel_frontend/ui/page/trip_list_page/trip_list_page.dart';

class TripFilterPage extends StatefulWidget {
  const TripFilterPage({super.key});

  @override
  State<TripFilterPage> createState() => _TripFilterPageState();
}

class _TripFilterPageState extends State<TripFilterPage> {
  final _formFilter = GlobalKey<FormState>();
  final departurePlaceTextController = TextEditingController();
  final arrivalPlaceTextController = TextEditingController();
  final departureDateTextController = TextEditingController();

  late FilterTripsRepository filterTripsRepository;
  late FilterTripsBloc _filterTripsBloc;

  @override
  void initState() {
    filterTripsRepository = FilterTripsRepositoryImpl();
    _filterTripsBloc = FilterTripsBloc(filterTripsRepository);
    departurePlaceTextController.text = 'Seville';
    arrivalPlaceTextController.text = 'Sanlúcar de Barrameda';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _filterTripsBloc,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              'assets/ilustration_filter.png',
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 250,
                  right: 20,
                  left: 20,
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 218, 255, 232),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(4, 5),
                    ),
                  ],
                ),
                child: BlocBuilder<FilterTripsBloc, FilterTripsState>(
                  builder: (context, state) {
                    if (state is DoFilterTripsSuccess) {
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TripListPage(
                              trips: state.filterTripsResponse.trip ?? [],
                              departurePlace: departurePlaceTextController.text,
                              arrivalPlace: arrivalPlaceTextController.text,
                              departureDate: departureDateTextController.text,
                            ), //aqui es adonde se redirije
                          ),
                        );
                      });
                    } else if (state is DoFilterTripsNotFound) {
                      final errorMessage =
                          state.errorMessage.replaceFirst('Exception: ', '');
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ErrorPage(
                                  errorMessage: errorMessage +
                                      "solo hay viajes para el 1 de mayo")),
                        );
                      });
                    } else if (state is DoFilterTripsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Center(child: _buildFilterTripsForm());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildFilterTripsForm() {
    return Form(
      key: _formFilter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: departurePlaceTextController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 175, 84), width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelText: 'From',
                  filled: true,
                  fillColor: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
            child: TextFormField(
              controller: arrivalPlaceTextController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 175, 84), width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelText: 'To',
                  filled: true,
                  fillColor: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
            child: TextFormField(
              controller: departureDateTextController,
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
                  departureDateTextController.text =
                      "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                }
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 175, 84), width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelText: 'Departure Date',
                  filled: true,
                  fillColor: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: const Color.fromARGB(255, 0, 175, 84),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
              ),
              child: const Text(
                'Search',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () {
                if (_formFilter.currentState!.validate()) {
                  _filterTripsBloc.add(DoFilterTripsEvent(
                      departurePlaceTextController.text,
                      arrivalPlaceTextController.text,
                      departureDateTextController.text));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

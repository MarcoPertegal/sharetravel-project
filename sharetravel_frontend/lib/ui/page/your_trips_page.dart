import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharetravel_frontend/bloc/driver_trips_bloc/driver_trips_bloc.dart';
import 'package:sharetravel_frontend/model/response/driver_trips_response/trip.dart';
import 'package:sharetravel_frontend/repository/driver_reserves/driver_reserves_repository.dart';
import 'package:sharetravel_frontend/repository/driver_reserves/driver_reserves_repository_impl.dart';
import 'package:sharetravel_frontend/ui/page/error_page.dart';
import 'package:sharetravel_frontend/ui/widget/driver_trips_card_widget.dart';

class YourTripsPage extends StatefulWidget {
  const YourTripsPage({super.key});

  @override
  State<YourTripsPage> createState() => _YourTripsPageState();
}

class _YourTripsPageState extends State<YourTripsPage> {
  late final DriverTripsBloc _driverTripsBloc;
  late DriverTripsRepository driverTripsRepository;
  late List<Trip> _trips;

  @override
  void initState() {
    driverTripsRepository = DriverTripsRepositoryImpl();
    _driverTripsBloc = DriverTripsBloc(driverTripsRepository);
    _driverTripsBloc.add(DoDriverTripsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _driverTripsBloc,
      child: Scaffold(
        body: BlocBuilder<DriverTripsBloc, DriverTripsState>(
          builder: (context, state) {
            if (state is DoDriverTripsLoading) {
              return const CircularProgressIndicator();
            } else if (state is DoDriverTripsSuccess) {
              _trips = state.driverTripsResponse.trips ?? [];
              return ListView.builder(
                itemCount: _trips.length,
                itemBuilder: (BuildContext context, int index) {
                  return DriverTripsCardWidget(trip: _trips[index]);
                },
              );
            } else if (state is DoDriverTripsError) {
              final errorMessage =
                  state.errorMessage.replaceFirst('Exception: ', '');
              return ErrorPage(errorMessage: errorMessage);
            } else {
              return const Text('Unexpected State');
            }
          },
        ),
      ),
    );
  }
}

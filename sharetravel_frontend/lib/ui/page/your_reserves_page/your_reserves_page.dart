import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharetravel_frontend/bloc/passenger_reserves_bloc/passenger_reserves_bloc.dart';
import 'package:sharetravel_frontend/model/response/passenger_reserves_response/reserve.dart';
import 'package:sharetravel_frontend/repository/passenger_reserves/passenger_reserves_repository.dart';
import 'package:sharetravel_frontend/repository/passenger_reserves/passenger_reserves_repository_impl.dart';
import 'package:sharetravel_frontend/ui/page/error_page.dart';
import 'package:sharetravel_frontend/ui/widget/passenger_reserves_card_widget.dart';

class YourReservesPage extends StatefulWidget {
  const YourReservesPage({super.key});

  @override
  State<YourReservesPage> createState() => _YourReservesPageState();
}

class _YourReservesPageState extends State<YourReservesPage> {
  late final PassengerReservesBloc _passengerReservesBloc;
  late PassengerReservesRepository passengerReservesRepository;
  late List<Reserve> _reserves;

  @override
  void initState() {
    passengerReservesRepository = PassengerReservesRepositoryImpl();
    _passengerReservesBloc = PassengerReservesBloc(passengerReservesRepository);
    _passengerReservesBloc.add(DoPassengerReservesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _passengerReservesBloc,
      child: Scaffold(
        body: BlocBuilder<PassengerReservesBloc, PassengerReservesState>(
          builder: (context, state) {
            if (state is DoPassengerReservesLoading) {
              return const CircularProgressIndicator();
            } else if (state is DoPassengerReservesSuccess) {
              _reserves = state.passengerReservesResponse.reserves ?? [];
              return ListView.builder(
                itemCount: _reserves.length,
                itemBuilder: (BuildContext context, int index) {
                  return PassengerReservesCardWidget(reserve: _reserves[index]);
                },
              );
            } else if (state is DoPassengerReservesError) {
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

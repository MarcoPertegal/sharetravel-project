import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharetravel_frontend/bloc/driver_ratings_bloc/driver_ratings_bloc.dart';
import 'package:sharetravel_frontend/model/response/driver_ratings_response/rating.dart';
import 'package:sharetravel_frontend/repository/driver_ratings/driver_ratings_repository.dart';
import 'package:sharetravel_frontend/repository/driver_ratings/driver_ratings_repository_impl.dart';
import 'package:sharetravel_frontend/ui/widget/driver_ratings_card_widget.dart';

class DriverRatingsListWidget extends StatefulWidget {
  const DriverRatingsListWidget({super.key});

  @override
  State<DriverRatingsListWidget> createState() =>
      _DriverRatingsListWidgetState();
}

class _DriverRatingsListWidgetState extends State<DriverRatingsListWidget> {
  late DriverRatingsRepository driverRatingsRepository;
  late DriverRatingsBloc _driverRatingsBloc;
  late List<Rating> _ratings;

  @override
  void initState() {
    driverRatingsRepository = DriverRatingsRepositoryImpl();
    _driverRatingsBloc = DriverRatingsBloc(driverRatingsRepository);
    _driverRatingsBloc.add(DoDriverRatingsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _driverRatingsBloc,
      child: BlocBuilder<DriverRatingsBloc, DriverRatingsState>(
        builder: (context, state) {
          if (state is DoDriverRatingsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DoDriverRatingsSuccess) {
            _ratings = state.driverRatingsResponse.ratings ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Ratings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _ratings.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DriverRatingsCardWidget(rating: _ratings[index]);
                  },
                ),
              ],
            );
          } else if (state is DoDriverRatingsError) {
            return Container();
          } else {
            return const Center(
              child: Text('Unexpected State'),
            );
          }
        },
      ),
    );
  }
}

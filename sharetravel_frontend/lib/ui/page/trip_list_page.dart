import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/ui/widget/trip_card_widget.dart';

class TripListPage extends StatefulWidget {
  const TripListPage({super.key});

  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  @override
  Widget build(BuildContext context) {
    return const TripCardWidget();
  }
}

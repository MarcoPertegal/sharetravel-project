import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sharetravel_frontend/model/response/trip_details_response/trip_details_response.dart';
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

    return Scaffold(
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
                        Text("${widget.tripDetails.estimatedDuration!}min"),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.tripDetails.departurePlace!,
                            style: commonTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            widget.tripDetails.arrivalPlace!,
                            style: commonTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
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
                          backgroundImage:
                              NetworkImage(widget.tripDetails.driver!.avatar!),
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
                      physics: NeverScrollableScrollPhysics(),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 175, 84),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    'Reserve',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

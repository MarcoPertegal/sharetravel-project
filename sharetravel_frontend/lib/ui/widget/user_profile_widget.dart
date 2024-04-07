import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/model/response/user_details_response.dart';
import 'package:sharetravel_frontend/ui/page/login_page.dart';
import 'package:sharetravel_frontend/ui/widget/driver_ratings_list_widget.dart';

class UserProfileWidget extends StatefulWidget {
  final UserDetailsResponse userDetails;
  const UserProfileWidget({Key? key, required this.userDetails})
      : super(key: key);

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  final TextStyle commonTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 42.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userDetails.fullName!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(widget.userDetails.email!),
                          IconButton(
                            icon: Icon(Icons.logout),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                          ),
                        ]),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.userDetails.avatar!),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
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
                padding: const EdgeInsets.only(top: 18.0, right: 24, left: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone",
                          style: commonTextStyle,
                        ),
                        Text(widget.userDetails.phoneNumber!)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Average Rating",
                          style: commonTextStyle,
                        ),
                        if (double.tryParse(
                                widget.userDetails.averageRating!)! <
                            0)
                          const Text("passengers have no ratings")
                        else if (double.tryParse(
                                widget.userDetails.averageRating!) ==
                            0)
                          const Text("you don't have ratings")
                        else
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 252, 163, 17),
                              ),
                              Text(widget.userDetails.averageRating!)
                            ],
                          )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 229, 255, 229),
                    width: 7.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 18.0, right: 24, left: 24, bottom: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Description",
                            style: commonTextStyle,
                          ),
                          Text(
                            widget.userDetails.personalDescription!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 229, 255, 229),
                    width: 7.0,
                  ),
                ),
              ),
              child: const Padding(
                  padding: EdgeInsets.only(top: 18.0, right: 24, left: 24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [SizedBox(child: DriverRatingsListWidget())])),
            ),
          ],
        ),
      ),
    );
  }
}

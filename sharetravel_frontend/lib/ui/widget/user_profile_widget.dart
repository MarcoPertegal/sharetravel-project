import 'package:flutter/material.dart';
import 'package:sharetravel_frontend/model/response/user_details_response.dart';

class UserProfileWidget extends StatefulWidget {
  final UserDetailsResponse userDetails;
  const UserProfileWidget({Key? key, required this.userDetails})
      : super(key: key);

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userDetails.fullName!,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(widget.userDetails.email!)
                      ]),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 54,
                  backgroundImage: NetworkImage(widget.userDetails.avatar!),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
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
                  Column(
                    children: [
                      Text("Phone"),
                      Text(widget.userDetails.phoneNumber!)
                    ],
                  ),
                  Column(
                    children: [
                      Text("Rating"),
                      Text(widget.userDetails.averageRating!)
                    ],
                  )
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Personal Description"),
                  Text(widget.userDetails.personalDescription!)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

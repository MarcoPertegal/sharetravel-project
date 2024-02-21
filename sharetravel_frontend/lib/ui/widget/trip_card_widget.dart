import 'package:flutter/material.dart';

class TripCardWidget extends StatelessWidget {
  const TripCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [Text("12"), Text("11h"), Text("13")],
                ),
                Column(
                  children: [Text("flecha verde")],
                ),
                Column(
                  children: [Text("Sanlúcar de Barrameda"), Text("Sevilla")],
                ),
                Column(children: [Text("7.88 E")])
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage('imageUrl'),
                ),
                Text("aaaa")
              ],
            )
          ],
        ),
      ),
    );
  }
}

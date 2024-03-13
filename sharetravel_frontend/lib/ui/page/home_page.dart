import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/ui/page/error_page.dart';
import 'package:sharetravel_frontend/ui/page/your_trips_page.dart';
import 'package:sharetravel_frontend/ui/page/profile_page.dart';
import 'package:sharetravel_frontend/ui/page/trip_list_page/trip_filter_page.dart';
import 'package:sharetravel_frontend/ui/page/trip_publish_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late String? userRol;

  @override
  void initState() {
    _fetchUserRol();
    super.initState();
  }

  void _fetchUserRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserRol = prefs.getString('userRol');
    if (storedUserRol != null) {
      setState(() {
        userRol = storedUserRol;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const TripFilterPage(),
      if (userRol == "[DRIVER]")
        const TripPublishPage()
      else
        const ErrorPage(errorMessage: "As passeger you cant publish trips"),
      const YourTripsPage(),
      const ProfilePage()
    ];

    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: 'Publish',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash),
            label: 'Your Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 175, 84),
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

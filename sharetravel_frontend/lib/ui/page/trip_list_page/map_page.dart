import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  final String cityName;

  const MapPage({Key? key, required this.cityName}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  //LatLng cityCoordinates = LatLng(40.4168, -3.7038);
  LatLng? cityCoordinates;
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Map: ${widget.cityName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(39.24, -3.00),
                zoom: 5.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              /*
              PROBAR HA HACER UNA PETICION QUE ME DEVUELVA LOS DATOS NECESARIOS PARA PINTAR UN MARKER y UNA 
              ANIMACION DE CAMARA
              markers: cityCoordinates != null
                  ? {
                      Marker(
                        markerId: MarkerId('CityMarker'),
                        position: cityCoordinates!,
                        infoWindow: InfoWindow(title: widget.cityName),
                      ),
                    }
                  : {},*/

              markers: cityCoordinates != null
                  ? {
                      Marker(
                        markerId: MarkerId('CityMarker'),
                        position: cityCoordinates!,
                        infoWindow: InfoWindow(title: widget.cityName),
                      ),
                    }
                  : {},
            ),
          ),
        ],
      ),
    );
  }

  Future<LatLng?> _showCityOnMap(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations != null && locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      } else {
        print('City not found');
        return null;
      }
    } catch (e) {
      print('Error during geocoding: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _updateCityCoordinates();
  }

  void _updateCityCoordinates() async {
    LatLng? coordinates = await _showCityOnMap(widget.cityName);
    print("CORDENADAS: ${coordinates?.toString()}");
    if (coordinates != null) {
      setState(() {
        cityCoordinates = coordinates;
      });
    }
  }
}

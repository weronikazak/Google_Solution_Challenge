import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(ShelterReportMap());

class ShelterReportMap extends StatefulWidget {
  @override
  _ShelterReportMapState createState() => _ShelterReportMapState();
}

class _ShelterReportMapState extends State<ShelterReportMap> {
  GoogleMapController mapController;
  Location location = Location();

  LatLng _center = const LatLng(52.76510085541201, -1.2320534015136977);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    location.onLocationChanged.listen((event) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(event.latitude, event.longitude), zoom: 20)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 20.0,
          ),
        ),
        Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 50),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      ),
                      Icon(
                        Icons.cancel,
                        color: Colors.red,
                      )
                    ],
                  ),
                  width: double.infinity,
                  height: 40,
                )
              ],
            )),
      ],
    ));
  }

  Future<LatLng> getUserLocation() async {
    LocationData currentLocation;
    final location = Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation.latitude;
      final lng = currentLocation.longitude;
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }
}

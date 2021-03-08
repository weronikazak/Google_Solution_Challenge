import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gsc_project/constants.dart';
// import 'package:gsc_project/constants.dart';
import 'package:location/location.dart';

void main() => runApp(UserReportMap());

class UserReportMap extends StatefulWidget {
  @override
  _UserReportMapState createState() => _UserReportMapState();
}

class _UserReportMapState extends State<UserReportMap> {
  GoogleMapController mapController;
  Location location = Location();

  LatLng _center = const LatLng(52.76510085541201, -1.2320534015136977);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    location.onLocationChanged().listen((event) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(event.latitude, event.longitude), zoom: 20)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
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
                RawMaterialButton(
                  child: Icon(
                    Icons
                        .live_help, // to change, I had no idea what icon should I choose
                    color: Colors.white,
                    size: 50,
                  ),
                  padding: EdgeInsets.all(30),
                  onPressed: () {},
                  fillColor: kPrimaryColor,
                  shape: CircleBorder(),
                ),
                SizedBox(
                  height: 20,
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

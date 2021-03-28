import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gsc_project/Screens/User/user_report_questionaire.dart';
import 'package:gsc_project/constants.dart';
import 'package:location/location.dart';

void main() => runApp(UserReportMap());

class UserReportMap extends StatefulWidget {
  @override
  _UserReportMapState createState() => _UserReportMapState();
}

class _UserReportMapState extends State<UserReportMap> {
  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> _markers = Set<Marker>();

  Location location = Location();
  BitmapDescriptor sourceIcon;

  // coords of lboro
  LatLng currentLocation = const LatLng(52.76510085541201, -1.2320534015136977);

  void showPinsOnMap() {
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);

    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        icon: sourceIcon));
  }

  @override
  void initState() {
    super.initState();
    location = new Location();
    location.onLocationChanged.listen((LocationData loc) {
      currentLocation = new LatLng(loc.latitude, loc.longitude);
      // updatePinOnMap();
    });

    setMarkerIcons();
    setInitialLocation();
  }

  void setInitialLocation() async {
    var loc = await location.getLocation();
    currentLocation = new LatLng(loc.latitude, loc.longitude);
    updatePinOnMap();
  }

  void setMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icons/marker_yellow.png');
  }

  void updatePinOnMap() async {
    CameraPosition camPos = CameraPosition(
      target: currentLocation,
      zoom: 20.0,
    );
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(camPos));

    if (mounted) {
      setState(() {
        var pinPosition =
            LatLng(currentLocation.latitude, currentLocation.longitude);

        _markers.removeWhere((m) => m.markerId.value == "sourcePin");
        _markers.add(Marker(
            markerId: MarkerId("sourcePin"),
            position: pinPosition,
            icon: sourceIcon));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Long tap to set marker."),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
                showPinsOnMap();
              },
              markers: _markers,
              onLongPress: (loc) {
                currentLocation = loc;
                updatePinOnMap();
              },
              initialCameraPosition: CameraPosition(
                target: currentLocation,
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
                      elevation: 0,
                      child:
                          Image.asset("assets/icons/homeless.png", height: 50),
                      // child: Text("REPORT"),
                      // child: Icon(
                      //   Icons
                      //       .live_help, // to change, I had no idea what icon should I choose
                      //   color: Colors.white,

                      //   size: 50,
                      // ),
                      padding: EdgeInsets.all(30),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserReportQuestionare(currentLocation)));
                      },
                      fillColor: kSecondaryColor,
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
}

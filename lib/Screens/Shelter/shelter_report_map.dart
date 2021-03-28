import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../constants.dart';

class ShelterReportMap extends StatefulWidget {
  String raportId;
  String shelterId;

  ShelterReportMap({Key key, @required this.raportId, @required this.shelterId})
      : super(key: key);
  CollectionReference raports =
      FirebaseFirestore.instance.collection('raports');

  @override
  _ShelterReportMapState createState() => _ShelterReportMapState();
}

class _ShelterReportMapState extends State<ShelterReportMap> {
  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> _markers = Set<Marker>();

  Location location = Location();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  // coords of lboro
  LatLng currentLocation = const LatLng(52.76510085541201, -1.2320534015136977);
  LatLng destinationLocation = new LatLng(0.0, 0.0);

  void showPinsOnMap() {
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    var destPosition =
        LatLng(destinationLocation.latitude, destinationLocation.longitude);

    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        icon: sourceIcon));

    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        icon: destinationIcon));
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
    destinationLocation =
        new LatLng(destinationLocation.latitude, destinationLocation.longitude);
    updatePinOnMap();
  }

  void setMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icons/marker_yellow.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icons/marker_red.png');
  }

  void updatePinOnMap() async {
    CameraPosition camPos = CameraPosition(
      target: currentLocation,
      zoom: 20.0,
    );
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(camPos));

    showPinsOnMap();
  }

  void setPolylines() async {
    // var result = await polylinePoints.getRouteBetweenCoordinates(
    //     "AIzaSyAaIVgOLQXMDc3lloX6VA_JJIlYVSdN8js",
    //     currentLocation.latitude,
    //     currentLocation.longitude,
    //     destinationLocation.latitude,
    //     destinationLocation.longitude);

    // if (result.isNotEmpty) {
    //   result.forEach((PointLatLng point) {
    //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    //   });

    //   setState(() {
    //     _polylines.add(Polyline(
    //         width: 5, // set the width of the polylines
    //         polylineId: PolylineId("poly"),
    //         color: Color.fromARGB(255, 40, 122, 198),
    //         points: polylineCoordinates));
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: widget.raports.doc(widget.raportId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                  child: Text(
                "Something went horribly wrong and we don't know what.",
                style: TextStyle(color: Colors.red),
              )),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            var lat = (data['latitude']).toDouble();
            var lon = (data['longitude']).toDouble();
            destinationLocation = LatLng(lat, lon);

            return Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Text("Some text"),
                  ),
                  backgroundColor: kPrimaryColor,
                ),
                body: Stack(
                  children: [
                    GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: MapType.normal,
                      polylines: _polylines,
                      onMapCreated: (GoogleMapController controller) {
                        try {
                          mapController.complete(controller);
                          showPinsOnMap();
                        } catch (e) {
                          showPinsOnMap();
                        }
                      },
                      markers: _markers,
                      initialCameraPosition: CameraPosition(
                        target: currentLocation,
                        zoom: 20.0,
                      ),
                    ),
                    Container(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RawMaterialButton(
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.blue,
                                        size: 70,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: RawMaterialButton(
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 70,
                                    ),
                                  ))
                                ],
                              ),
                              width: double.infinity,
                              height: 100,
                            )
                          ],
                        )),
                  ],
                ));
          } else {
            return Scaffold(
              body: Center(
                  child: Text("Loading",
                      style: TextStyle(
                          color: kPrimaryColor, fontSize: kmediumFontSize))),
            );
          }
        });
  }
}

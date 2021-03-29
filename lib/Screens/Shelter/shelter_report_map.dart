import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../constants.dart';

class ShelterReportMap extends StatefulWidget {
  double shelterLon, shelterLat, targetLat, targetLon;

  ShelterReportMap({
    Key key,
    @required this.shelterLat,
    @required this.shelterLon,
    @required this.targetLat,
    @required this.targetLon,
  }) : super(key: key);

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
  PolylinePoints polylinePoints = PolylinePoints();

  LocationData currentLocation;
  LocationData destinationLocation;

  // coords of lboro

  @override
  void initState() {
    super.initState();

    location = new Location();
    polylinePoints = PolylinePoints();

    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      // currentLocation = cLoc;
      // updatePinOnMap();
    });
    setMarkerIcons();
    setInitialLocation();
    fancyCamera();
  }

  void fancyCamera() async {
    var middleLat = (widget.shelterLat + widget.targetLat) / 2;
    var middleLon = (widget.shelterLon + widget.targetLon) / 2;

    // var initPoint = LatLng(middleLat, middleLon);
    var initPoint = LatLng(currentLocation.latitude, currentLocation.longitude);

    CameraPosition camPos = CameraPosition(
      target: initPoint,
      zoom: 20.0,
    );
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(camPos));
  }

  void setInitialLocation() async {
    // currentLocation = new LocationData.fromMap(
    //     {"latitude": widget.shelterLat, "longitude": widget.shelterLon});
    currentLocation = new LocationData.fromMap(
        {"latitude": 52.76510085541201, "longitude": -1.2320534015136977});
    destinationLocation = new LocationData.fromMap(
        {"latitude": widget.targetLat, "longitude": widget.targetLon});

    fancyCamera();
  }

  void setMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icons/marker_yellow.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icons/marker_red.png');
  }

  void showPinsOnMap() {
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    var destPosition =
        LatLng(destinationLocation.latitude, destinationLocation.longitude);

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition,
          icon: sourceIcon));

      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: destPosition,
          icon: destinationIcon));
    });

    setPolylines();
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyAaIVgOLQXMDc3lloX6VA_JJIlYVSdN8js",
        new PointLatLng(currentLocation.latitude, currentLocation.longitude),
        new PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude));

    for (var point in result.points) {
      print("KURWA MAC " + point.toString());
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    setState(() {
      _polylines.add(Polyline(
          width: 5, // set the width of the polylines
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates));
    });
  }

  @override
  Widget build(BuildContext context) {
    var middleLat = (widget.shelterLat + widget.targetLat) / 2;
    var middleLon = (widget.shelterLon + widget.targetLon) / 2;

    var initPoint = LatLng(middleLat, middleLon);
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Target Location"),
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
                mapController.complete(controller);
                showPinsOnMap();
              },
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: new LatLng(widget.shelterLat, widget.shelterLon),
                // target: LatLng(52.76510085541201, -1.2320534015136977),
                // target: initPoint,
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
  }
}

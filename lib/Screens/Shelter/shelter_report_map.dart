import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
            double lat = (data['lat']).toDouble();
            double lon = (data['lon']).toDouble();
            LatLng target = new LatLng(lat, lon);

            Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

            // TODO change pins' colour
            Marker markerTarget =
                new Marker(markerId: MarkerId("1"), position: target);
            Marker yourPosition = new Marker(
                markerId: MarkerId("2"),
                position: LatLng(52.76510085541201, -1.2320534015136977));

            markers[MarkerId("1")] = markerTarget;
            markers[MarkerId("2")] = yourPosition;

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

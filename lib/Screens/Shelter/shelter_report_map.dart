import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../constants.dart';

class ShelterReportMap extends StatelessWidget {
  String raportId;
  String shelterId;

  ShelterReportMap({Key key, @required this.raportId, @required this.shelterId})
      : super(key: key);
  CollectionReference raports =
      FirebaseFirestore.instance.collection('raports');

  GoogleMapController mapController;
  Location location = Location();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: raports.doc(raportId).get(),
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
                body: Stack(
              children: [
                GoogleMap(
                  // myLocationEnabled: true,
                  // myLocationButtonEnabled: true,
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: target,
                    zoom: 16.0,
                  ),
                  markers: Set<Marker>.of(markers.values),
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

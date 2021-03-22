import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gsc_project/Screens/User/user_report_questionaire.dart';
import 'package:gsc_project/constants.dart';
// import 'package:location/location.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

void main() => runApp(UserReportMap());

class UserReportMap extends StatefulWidget {
  @override
  _UserReportMapState createState() => _UserReportMapState();
}

class _UserReportMapState extends State<UserReportMap> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.343434, -122.545454);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  String _title = "";
  String _detail = "";

  TextEditingController _lane1;
  TextEditingController _lane2;
  TextEditingController _lane3;

  @override
  void initState() {
    super.initState();
    _lane1 = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            GoogleMap(
              mapToolbarEnabled: false,
              //              myLocationEnabled: true,
              //              myLocationButtonEnabled:true,
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: _center, zoom: 11.0),
              markers: _markers,
              mapType: _currentMapType,
              onCameraMove: _onCameraMove,
              onTap: _handleTap,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    _customButton(
                        FontAwesomeIcons.map, _onMapTypeButtonPressed),
                    SizedBox(
                      height: 15,
                    ),
                    _customButton(
                        FontAwesomeIcons.mapMarker, _onAddMarkerButtonPressed),
                    SizedBox(
                      height: 5,
                    ),
                    _customButton(FontAwesomeIcons.mapPin, _getUserLocation),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 4,
                    width: _width * 0.2,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: _height * 0.2,
                          width: _width,
                          color: Colors.white,
                          child: TextField(
                            maxLines: 4,
                            controller: _lane1,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: kPrimaryColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: kPrimaryColor),
                                ),
                                errorStyle: TextStyle(
                                    color: kPrimaryColor.withOpacity(0.5)),
                                labelStyle: TextStyle(
                                    color: kPrimaryColor.withOpacity(0.5)),
                                labelText: "Address "),
                            cursorColor: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        debugPrint("Save Address");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: _width * 0.3,
                        height: 40,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 6, bottom: 6),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        //      floatingActionButton: FloatingActionButton.extended(
        //        onPressed: _goToTheLake,
        //        label: Text('To the lake!'),
        //        icon: Icon(Icons.directions_boat),
        //      ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _customButton(IconData icon, Function function) {
    return FloatingActionButton(
      heroTag: icon.codePoint,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.amber,
      child: Icon(
        icon,
        size: 16,
        color: kPrimaryColor,
      ),
    );
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    _markers.clear();
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(title: _title, snippet: _detail),
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  _handleTap(LatLng point) {
    _markers.clear();
    _getLocation(point);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(title: _title, snippet: _detail),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ));
    });
  }

  _getLocation(LatLng point) async {
    final coordinates = new Coordinates(point.latitude, point.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");

    setState(() {
      _title = first.featureName;
      _detail = first.addressLine;
      _lane1.text = _title + "   " + _detail;
    });
  }

  _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 16),
      ),
    );

    setState(() {
      _title = first.featureName;
      _detail = first.addressLine;
      _lane1.text = _title + "   " + _detail;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController _controller;

  final LatLng _cairoLocation = LatLng(30.0444, 31.2357); // Cairo, Egypt

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Map"), centerTitle: true),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _cairoLocation,
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: MarkerId("cairo"),
            position: _cairoLocation,
            infoWindow: InfoWindow(title: "Cairo, Egypt"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
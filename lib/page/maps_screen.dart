import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers = _getMarkers();
  }

  Set<Marker> _getMarkers() {
    Set<Marker> markers = {};

    // Example data - replace with actual donor and hospital data
    List<MapMarker> mapData = [
      MapMarker(
        id: '1',
        name: 'Donor 1',
        latitude: 28.3949,
        longitude: 84.1240,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
      MapMarker(
        id: '2',
        name: 'Donor 2',
        latitude: 27.7172,
        longitude: 85.3240,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
      MapMarker(
        id: '3',
        name: 'Hospital A',
        latitude: 27.7008,
        longitude: 85.3001,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
      MapMarker(
        id: '4',
        name: 'Hospital B',
        latitude: 28.2106,
        longitude: 83.9856,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    ];

    for (var item in mapData) {
      markers.add(Marker(
        markerId: MarkerId(item.id),
        position: LatLng(item.latitude, item.longitude),
        infoWindow: InfoWindow(title: item.name),
        icon: item.icon,
      ));
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donors and Hospitals Map'),
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(28.3949, 84.1240), // Center the map on Nepal
          zoom: 7.0, // Zoom level
        ),
        markers: _markers,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    mapController.dispose();
    super.dispose();
  }
}

class MapMarker {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final BitmapDescriptor icon;

  MapMarker({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.icon,
  });
}

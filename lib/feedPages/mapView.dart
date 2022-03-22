import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart';


class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);


  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {


  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        Navigator.of(context).pop();

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure?"),
      content: Text("If you are sure that this is your location, press Yes."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        print(alert);
        return alert;
      },
    );
  }

  Completer<GoogleMapController> _controller = Completer();
  late Marker _origin ;
  late Set<Marker> markers;

  static const LatLng _center = const LatLng(40.89193877162805, 29.377914784885466);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Location location = new Location();
  late LocationData _locationData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers = Set.from([]);
  }



  void _addMarker(LatLng point){
    setState(() {
      _origin = Marker(
        markerId: MarkerId('marker'),
        position: point,
        icon: BitmapDescriptor.defaultMarker,
      );

    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(
                  Icons.check,
                color: Colors.white,
              ),
          ),
        ],
        title: Text('Choose Location'),
        backgroundColor: Colors.black,
      ),
      body: GoogleMap(
        buildingsEnabled: true,
        markers: markers,
        mapToolbarEnabled: true,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: _onMapCreated,
        onTap: (point){
          print('Tapped');
          print('$point');


          Marker f = Marker(
            markerId: MarkerId('marker'),
            icon: BitmapDescriptor.defaultMarker,
            draggable: true,
            position: point,
            onTap: (){
            },
            );
          setState(() {
            markers.add(f);
          });
          showAlertDialog(context);
        },

        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 13.0,
        ),
      ),
    );
  }
}


class mapPage extends StatefulWidget {
  const mapPage({Key? key}) : super(key: key);

  @override
  _mapPageState createState() => _mapPageState();
}

class _mapPageState extends State<mapPage> {

  @override
  Widget build(BuildContext context) {
    return Map();
  }
}

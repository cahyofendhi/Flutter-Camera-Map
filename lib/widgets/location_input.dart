import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/helpers/location_helper.dart';
import 'package:map/screens/map_screen.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  LatLng _locationPreview;
  GoogleMapController mapController;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _locationPreview = LatLng(locData.latitude, locData.longitude);
    });
    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    setState(() {
      _locationPreview = selectedLocation;
    });
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _locationPreview, zoom: 20.0),
      ),
    );
    print('Location : ${selectedLocation.latitude}');
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _locationPreview == null
              ? Text(
                  'No Location Choosen',
                  textAlign: TextAlign.center,
                )
              : GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _locationPreview.latitude,
                      _locationPreview.longitude,
                    ),
                    zoom: 16,
                  ),
                  markers: _locationPreview == null
                      ? null
                      : {
                          Marker(
                              markerId: MarkerId('m1'),
                              position: _locationPreview),
                        },
                ),
          // : Image.network(
          //     _previewImageUrl,
          //     fit: BoxFit.cover,
          //     width: double.infinity,
          //   ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}

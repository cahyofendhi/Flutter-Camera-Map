import 'dart:io';

import 'package:flutter/material.dart';
import 'package:map/models/place.dart';
import 'package:map/providers/great_places.dart';
import 'package:map/widgets/image_input.dart';
import 'package:map/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double latitude, double longitude) {
    _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    final placeData = Provider.of<GreatPlaces>(context, listen: false);
    placeData.addPlace(_titleController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add n New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: RaisedButton.icon(
              icon: Icon(Icons.add, color: Colors.white,),
              label: Text('Add Place', style: TextStyle(color: Colors.white),),
              onPressed: _savePlace,
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

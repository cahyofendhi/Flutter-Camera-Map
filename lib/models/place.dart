
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    @required this.address,
  });

}

class Place {

  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image
  });

}
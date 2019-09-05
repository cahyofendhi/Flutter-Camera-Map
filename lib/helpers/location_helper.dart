import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyCoSR3eIsRqWJeI9o30a2zaAwghfn7m3CI';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double latitude, double longitude) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
    print('Url Geocode : $url');
    final response = await http.get(url);
    final responseData = response.body;
    print('Data Geocode : $responseData');
    // return json.decode(response.body)['results'][0]['formatted_address']; //! must to enable billing account on cloud google, to use Geocode feature
    return "Dummy address";
  }

}

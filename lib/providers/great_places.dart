import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_great_places_app/helpers/db_helper.dart';
import 'package:flutter_great_places_app/helpers/location_helper.dart';
import 'package:flutter_great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => [..._items];

  static const _placesTableName = 'user_places';

  Future<void> addPlace(String title, File image, PlaceLocation place) async {
    final address =
        'Configure the google api'; //TODO: Configure the google API.;
    //await LocationHelper.getPlaceAddress(place.latitude, place.longitude);
    final updatedLocation = PlaceLocation(
        latitude: place.latitude, longitude: place.longitude, address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        location: updatedLocation,
        title: title);
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert(_placesTableName, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(_placesTableName);

    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }

  Place findById(String id) => _items.firstWhere((place) => place.id == id);
}

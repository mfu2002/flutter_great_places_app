import 'package:flutter/material.dart';
import 'package:flutter_great_places_app/providers/great_places.dart';
import 'package:flutter_great_places_app/screens/add_place_screen.dart';
import 'package:flutter_great_places_app/screens/place_detail.screen.dart';
import 'package:flutter_great_places_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        routes: {
          AddPlacesScreen.routeName: (_) => AddPlacesScreen(),
          PlaceDetailScreen.routeName: (_) => PlaceDetailScreen(),
        },
        home: PlacesListScreen(),
      ),
    );
  }
}

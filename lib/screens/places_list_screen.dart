import 'package:flutter/material.dart';
import 'package:flutter_great_places_app/providers/great_places.dart';
import 'package:flutter_great_places_app/screens/add_place_screen.dart';
import 'package:flutter_great_places_app/screens/place_detail.screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AddPlacesScreen.routeName),
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (bctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: const Text('Got no places yet, start adding some!'),
                  builder: (ctx, greatPlaces, child) => greatPlaces
                              .items.length ==
                          0
                      ? child
                      : ListView.builder(
                          itemBuilder: (ctx, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.items[index].image),
                            ),
                            title: Text(greatPlaces.items[index].title),
                            subtitle: Column(
                              children: [
                                Text(
                                    'Lat: ${greatPlaces.items[index].location.latitude}'),
                                Text(
                                    'Lng: ${greatPlaces.items[index].location.longitude}'),
                                Text(greatPlaces.items[index].location.address),
                              ],
                            ),
                            onTap: () => Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: greatPlaces.items[index].id),
                          ),
                          itemCount: greatPlaces.items.length,
                        )),
        ));
  }
}

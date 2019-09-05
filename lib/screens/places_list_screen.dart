import 'package:flutter/material.dart';
import 'package:map/providers/great_places.dart';
import 'package:map/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('Got no Places yet, start adding place'),
                ),
                builder: (ctx, greatePlace, ch) => greatePlace.items.length == 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatePlace.items.length,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatePlace.items[index].image),
                          ),
                          title: Text(greatePlace.items[index].title),
                          subtitle: Text(greatePlace.items[index].location.address),
                          onTap: () {
                            
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}

import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/services/locations_service.dart';
import 'package:flutter/material.dart';

class BlaLocationPicker extends StatefulWidget {
  const BlaLocationPicker({super.key});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> locations = LocationsService.availableLocations;

  String search = '';

  Widget _buildLocationsList() {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return ListTile(
          title: Text(location.name),
          subtitle: Text(location.country.name),
          onTap: () {
            Navigator.pop(context, location);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search location',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      search = value;
                      locations = LocationsService.availableLocations
                          .where((location) => location.name.startsWith(search))
                          .toList();
                    });
                  },
                ),
              ),
            ],
          ),
          Expanded(child: _buildLocationsList()),
        ],
      ),
    );
  }
}

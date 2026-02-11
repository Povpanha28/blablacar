import 'package:blablacar/ui/theme/theme.dart';
import 'package:blablacar/ui/widgets/display/bla_divider.dart';
import 'package:blablacar/ui/widgets/display/bla_input_tile.dart';
import 'package:blablacar/ui/widgets/inputs/bla_location_picker.dart';
import 'package:blablacar/utils/date_time_util.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    departure = widget.initRidePref?.departure;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    arrival = widget.initRidePref?.arrival;
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void swapDepartureArrival() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  Widget _showSwapButton() {
    return widget.initRidePref != null
        ? IconButton(
            onPressed: () => swapDepartureArrival(),
            icon: Icon(Icons.swap_vert),
          )
        : SizedBox.shrink();
  }

  Widget _buildSearchButton(
    Color bgColor,
    Color fgColor,
    VoidCallback onPressed, {
    IconData? icon,
    String title = 'Search',
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon),
          if (icon != null) SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BlaInputTile(
                      title: departure != null
                          ? departure!.name
                          : 'Leaving from',

                      subtitle: departure != null
                          ? departure!.country.name
                          : null,
                      icon: Icons.circle_outlined,
                      onTap: () async {
                        final selectedLocation =
                            await Navigator.push<Location?>(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => BlaLocationPicker(),
                              ),
                            );
                        if (selectedLocation != null) {
                          setState(() {
                            departure = selectedLocation;
                          });
                        }
                      },
                    ),
                  ),
                  _showSwapButton(),
                ],
              ),

              BlaDivider(),
              BlaInputTile(
                title: arrival != null ? arrival!.name : 'Going to',
                subtitle: arrival != null ? arrival!.country.name : null,
                icon: Icons.circle_outlined,
                onTap: () async {
                  final selectedLocation = await Navigator.push<Location?>(
                    context,
                    MaterialPageRoute(builder: (ctx) => BlaLocationPicker()),
                  );
                  if (selectedLocation != null) {
                    setState(() {
                      arrival = selectedLocation;
                    });
                  }
                },
              ),
              BlaDivider(),
              BlaInputTile(
                title: DateTimeUtils.formatDateTime(departureDate),
                icon: Icons.calendar_month_outlined,
              ),
              BlaDivider(),
              BlaInputTile(
                title: requestedSeats.toString(),
                icon: Icons.person,
              ),
            ],
          ),
        ),
        _buildSearchButton(BlaColors.backGroundColor, BlaColors.white, () {}),
      ],
    );
  }
}

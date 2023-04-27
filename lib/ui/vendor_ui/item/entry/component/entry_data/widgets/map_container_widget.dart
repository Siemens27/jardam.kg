import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googlemap;
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/constant/ps_dimens.dart';
import 'package:psxmpc/core/vendor/provider/entry/item_entry_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/ui/custom_ui/item/entry/component/entry_data/widgets/map_for_flutter.dart';
import 'package:psxmpc/ui/custom_ui/item/entry/component/entry_data/widgets/map_for_google.dart';

class MapContainerWiget extends StatelessWidget {
  const MapContainerWiget(
      {Key? key,
      required this.latitudeController,
      required this.longitudeController,
      required this.flutterMapController,
      required this.zoom,
      required this.updateMap,
      required this.latLng,
      required this.updateMapController,
      required this.googleMapController,
      required this.userInputAddress,
      required this.currentPosition,
      required this.addressCurrentLocation,
      required this.itemEntryProvider
      })
      : super(key: key);

  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final MapController flutterMapController;
  final double zoom;
  final Function updateMap;
  final LatLng latLng;
  final Function? updateMapController;
  final googlemap.GoogleMapController? googleMapController;
  final TextEditingController userInputAddress;
  final Position? currentPosition;
  final String? addressCurrentLocation;
  final ItemEntryProvider? itemEntryProvider;
  
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    /**
     * UI SECTION
     */
    return Container(
      height: 260,
      margin: const EdgeInsets.all(PsDimens.space16),
      decoration: BoxDecoration(
        color: PsColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(PsDimens.space4),
        border: Border.all(color: PsColors.mainDividerColor!),
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
        // children: <Widget>[
          // Padding(
          //   padding:
          //       const EdgeInsets.only(right: 4, left: 4, bottom: 8, top: 4),
          //   child: Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(PsDimens.space10),
          //         border: Border.all(color: PsColors.mainDividerColor!),
          //       ),
          //       height: 200,
                child: psValueHolder.isUseGoogleMap!
                    ? CustomMapForGoogle(
                        updateMapController: updateMapController,
                        googleMapController: googleMapController,
                        latLng: latLng,
                        userInputAddress: userInputAddress,
                        updateGoogleMap: updateMap,
                        zoom: zoom,
                        addressCurrentLocation: addressCurrentLocation,
                      //  itemEntryProvider: itemEntryProvider,
                        currentPosition: currentPosition,)
                    :  CustomMapForFlutter(
                        flutterMapController: flutterMapController,
                        latLng: latLng,
                        updateFlutterMap: updateMap,
                        zoom: zoom,
                        addressCurrentLocation: addressCurrentLocation,
                       // itemEntryProvider: itemEntryProvider,
                        currentPosition: currentPosition,),
                      //  ),
          //),
          // if (Utils.showUI(psValueHolder.latitude))
          //   LatLngWidget(
          //       latitudeController: latitudeController,
          //       longitudeController: longitudeController),
       // ],
      //),
    );
  }
}
